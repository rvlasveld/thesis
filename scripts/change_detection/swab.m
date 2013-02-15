## Octave script for SWAB: Sliding Window And Buttom-up
## Performs segmentation of signal, using linear regression
##
## Based on: An Online Algorithm for Segmenting Time Series
## Eamonn Keogh Selina Chu David Hart Michael Pazzani

1;

% Return a segments for a time series based on bottom-up approach
function segments = bottom_up( series, max_error)

  segments = {};

  # Create initial fine segments
  for i = 1 : 2 : length(series) - 1
    segments(end+1) = series(i:i+1);
  endfor


  merge_cost = [];
  for i = 1 : length(segments) - 1
    merged_segment = [segments(i){1,1}, segments(i+1){1,1}];
    merge_cost(i) = calculate_error(merged_segment);
  endfor

  % As long as we can merge a segment and stay below the error
  while (min(merge_cost) < max_error && length(segments) > 1)
    [minimum, index] = min(merge_cost);

    # Merge segment with lowest cost
    segments(index) = [segments(index){1,1} segments(index+1){1,1}];
    segments(index+1) = [];

    % Calculate new merge cost for current with next segment ...
    if index < (length(segments) - 1)
      % There is a next segment
      merged_new_with_next = [segments(index){1,1} segments(index+1){1,1}];
      merge_cost(index) = calculate_error( merged_new_with_next);
      merge_cost(index+1) = [];
    else
      % This was the last segment, no next merging
      merge_cost(index) = [];
    end

    # ... and current with previous segment
    if index > 1
      merged_new_with_previous = [segments(index-1){1,1} segments(index){1,1}];
      merge_cost(index-1) = calculate_error( merged_new_with_previous);
    endif
  endwhile
endfunction

% Return the error for a segment, with applying linear regression
% As used in http://www.mathworks.nl/help/matlab/data_analysis/linear-regression.html
function error = calculate_error( segment )

  x = [1:length(segment)];
  y = segment;

  % p = polyfit(x,y,1);
  % yfit = polyval(p,x);
  % yresid = y - yfit;
  % SSresid = sum(yresid.^2);
  % SStotal = (length(y)-1) * var(y);
  % error = SSresid / SStotal;


  %  http://emil.informatik.uni-bremen.de/~hiben/w/blog:simple_linear_regression_for_octave
  A = [sum(x.*x) sum(x); sum(x) length(x)];
  b = [sum(x.*y); sum(y)];
  % solve
  r = A\b;
  slope = r(1);
  intercept = r(2);

  error = sum( (((x .* slope) + intercept) - y).^2 ) / sum( (y - mean(y)).^2 );
  r2 = 1 - error;

endfunction


function segments = swab(max_error, segments_number)
  segments = {};

  buffer = get_data_points(4*segments_number);
  read_length = length(buffer);

  lower_bound = read_length / 2;
  upper_bound = read_length * 2;


  new_data = get_data_points(1, false);

  % "while data at input"
  while !isempty(new_data)

    T = bottom_up(buffer, max_error);
    first_segment = T(1){1,1};
    T(1) = [];
    segments(end+1) = first_segment;

    % Remove length of just created segment at beginning of buffer
    buffer(1:length(first_segment)) = [];

    new_data = get_data_points(1, false);
    if !isempty(new_data)

      new_segment = best_line(max_error);
      buffer = [buffer new_segment];
    else
      segments = [segments T];
    endif
  end


endfunction

% Perform sliding window to create a segment as
% long as error is below max_error
function s = best_line(max_error)
  error = 0;
  s = [];
  s_proposed = [];
  while error < max_error

    s = s_proposed;
    new_data = get_data_points(1);
    s_proposed = [s new_data];
    if length(new_data) > 0
      % There is new data

      if length(s_proposed) > 2
        % Segment is large enough to calculate error
        error = calculate_error(s_proposed);
      endif
    else
      % There is no data at the stream anymore
      return;
    end

  endwhile
endfunction


%
% Helping function to simulate online algorithm
%
function data = get_data_points(size, remove_from_stream = true)
  global current_input_pointer = 1;
  global data_stream;

  if isempty(data_stream)
    % data = load('stock_data.dat');
    data = load('body_acc_x_train_first_column_head.dat');
    data_stream = data(1:end,1)';
  end

  if (current_input_pointer + size) > length(data_stream)
    data = [];
    return;
  endif

  data = data_stream(current_input_pointer:current_input_pointer+size);

  if remove_from_stream
    current_input_pointer += size;
  endif
endfunction


