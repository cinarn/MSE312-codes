clear all; % Clear all variables
clc;       % Clear command window

% Load data from a text file
data = load('random_data.txt');
x = data(:,1); % x values
y = data(:,2); % y values
n = length(x); % Number of data points

% Goal: Fit a cubic polynomial
% f(x) = a0 + a1*x + a2*x^2 + a3*x^3

% Build the design matrix for a cubic polynomial
X = [ones(n,1) x x.^2 x.^3]; % Each row: [1, x, x^2, x^3]

% Solve for the polynomial coefficients
a = X \ y; % a(1) = a0, a(2) = a1, etc.

% Plot the original data
plot(x, y, 'ko'); % Black circles
hold on;

% Generate x values for smooth fitted curve
xi = min(x);
xf = max(x);
width = xf - xi;
x_fit = linspace(xi-0.1*width, xf+0.1*width, 250);

% Plot the fitted cubic polynomial
plot(x_fit, a(1) + a(2)*x_fit + a(3)*x_fit.^2 + a(4)*x_fit.^3, 'r--');
title(sprintf('a0 = %g, a1 = %g, a2 = %g, a3 = %g', a(1), a(2), a(3), a(4)))

hold off;

% Add labels, grid, and legend
xlabel('X');
ylabel('Y');
grid on;
legend('data', 'fit', 'location', 'northwest');
