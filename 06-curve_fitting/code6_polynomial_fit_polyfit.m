clear all; % Clear all variables
clc;       % Clear command window

% Load data
data = load('random_data.txt');
x = data(:,1);
y = data(:,2);
n = length(x);

% Fit a 3rd-degree polynomial using built-in polyfit
% polyfit(x, y, degree) returns polynomial coefficients
a = polyfit(x, y, 3);

% Plot original data
plot(x, y, 'ko'); % Black circles
hold on;

% Create x values for smooth curve
xi = min(x);
xf = max(x);
width = xf - xi;
x_fit = linspace(xi-0.1*width, xf+0.1*width, 250);

% Evaluate polynomial at x_fit points
plot(x_fit, polyval(a, x_fit), 'r--'); % Red dashed fitted curve

% Display polynomial coefficients in the title
title(sprintf('a0 = %g, a1 = %g, a2 = %g, a3 = %g', a(4), a(3), a(2), a(1)))

hold off;

xlabel('X');
ylabel('Y');
grid on;
legend('data', 'fit', 'location', 'northwest');
