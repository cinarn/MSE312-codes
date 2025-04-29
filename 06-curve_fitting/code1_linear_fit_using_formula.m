clear all; % Clear all variables from the workspace
clc;       % Clear the command window

% Load data from a text file
% Assumes the file 'random_data.txt' has two columns: x values and y values
data = load('random_data.txt');
x = data(:,1); % Extract first column as x
y = data(:,2); % Extract second column as y
n = length(x); % Number of data points

% Calculate the necessary summations for linear regression
Sx = sum(x);         % Sum of x values
Sy = sum(y);         % Sum of y values
Sxy = sum(x.*y);     % Sum of x*y products
Sxx = sum(x.^2);     % Sum of x squared

% Calculate slope (a1) and intercept (a0) using the least squares formulas
a1 = (n*Sxy - Sx*Sy) / (n*Sxx - Sx^2); % Slope
a0 = (Sxx*Sy - Sxy*Sx) / (n*Sxx - Sx^2); % Intercept

% Plot the original data points
plot(x, y, 'ko'); % 'ko' means black circles for data points
hold on;

% Generate x values for the fitted line
xi = min(x); % Minimum x value
xf = max(x); % Maximum x value
width = xf - xi;
% Extend the plot slightly beyond the data range for better visualization
x_fit = linspace(xi-0.1*width, xf+0.1*width, 250); 

% Plot the fitted line
plot(x_fit, a0 + a1*x_fit, 'r--'); % 'r--' means red dashed line
hold off;

% Add a title showing the fitted coefficients
title(sprintf('a0 = %g, a1 = %g', a0, a1));
