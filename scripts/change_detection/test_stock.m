# Test the bottom-up / swab algorithm with stock data

source('swab.m');

stock_data = load('stock_data.dat');
y = stock_data(1:end,1)';
x = [1:length(y)];

clf
hold on;

segments = bottom_up(y, 0.01);
x_running = 1;
colors = "gbmck";
for i = 1 : length(segments)
  segment = segments(i){1,1};
  segment_length = length(segment);
  x_segment = x(x_running:x_running+segment_length-1);

  p = polyfit(x_segment, segment, 1);
  yfit = polyval(p,x_segment);
  line_segment = plot(x_segment, yfit, 'r-');

  points = plot(x_segment,segment, '.+');
  set( [line_segment, points] , 'color', colors(mod(i - 1,length(colors)) + 1));

  x_running += segment_length;
endfor

segments