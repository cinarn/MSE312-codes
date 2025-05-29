clear all;
clc;

% Define data points
x = [1 2 3 4 5 6 7 8];
y = [1 4 7 12 16 13 10 0];

% Evaluation points
xx = linspace(min(x), max(x), 1000);

% Use built-in interpolation: linear and cubic (spline)
yy = interp1(x,y,xx,"linear");
yy_cubic = interp1(x,y,xx,"spline");

% Plot both results for comparison
plot(x, y, 'o', xx, yy, '--', xx, yy_cubic, '-');
title('Linear Spline');
legend('Data Points', 'Linear Spline', 'Cubic Spline');
