# Test the bottom-up / swab algorithm with stock data
clear all
source('swab.m');

% data = load('stock_data.dat');
% data = load('t_body_acc_energy_x.dat');
data = load('body_acc_x_train_first_column_head.dat');
y = data(1:end,1)';
% x = [1:length(y)];

clf
figure("Position",[0,0,1600,800]);
hold on;

segments = bottom_up(y, 0.6);

% segments

function draw_segments(segments)
  % x = [1:length(segments)];
  x_running = 1;
  colors = "gbmck";
  for i = 1 : length(segments)
    segment = segments(i){1,1};
    segment_length = length(segment);
    x_segment = [x_running:x_running+segment_length-1];

    p = polyfit(x_segment, segment, 1);
    yfit = polyval(p,x_segment);

    line_segment = plot(x_segment, yfit, 'r-');
    points = plot(x_segment,segment, 'b.+');

    set( [line_segment, points] , 'color', colors(mod(i - 1,length(colors)) + 1));

    x_running += segment_length;
  endfor
endfunction

% segments

% best_line(0.05)

% segments = swab(0.8, 10);
draw_segments(segments);
printf("Number of final segments: %i\n", length(segments));
% segments