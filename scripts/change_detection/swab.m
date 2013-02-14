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

  p = polyfit(x,y,1);
  yfit = polyval(p,x);
  yresid = y - yfit;
  SSresid = sum(yresid.^2);
  SStotal = (length(y)-1) * var(y);
  error = 1 - SSresid / SStotal;

endfunction