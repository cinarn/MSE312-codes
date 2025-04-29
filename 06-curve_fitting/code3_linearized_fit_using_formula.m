clear all; % Clear all variables from the workspace
clc;       % Clear the command window

% Load data from a text file
% Assumes 'population_data.txt' has two columns: year (x) and population (y)
data = load('population_data.txt');
x = data(:,1); % Extract year
y = data(:,2); % Extract population
n = length(x); % Number of data points

% We want to fit an exponential model: p = b * e^(m*x)
% Taking the natural log on both sides:
% ln(p) = ln(b) + m*x
% This is a linear relationship: Y = a0 + a1*x
% where a0 = ln(b), and a1 = m

Y = log(y); % Take the natural logarithm of population values

% Calculate necessary summations for linear regression on (x, ln(y))
Sx = sum(x);
Sy = sum(Y);
Sxy = sum(x.*Y);
Sxx = sum(x.^2);

% Solve for slope (a1) and intercept (a0)
a1 = (n*Sxy - Sx*Sy) / (n*Sxx - Sx^2); % Slope (m)
a0 = (Sxx*Sy - Sxy*Sx) / (n*Sxx - Sx^2); % Intercept (ln(b))

% Recover original coefficients
b = exp(a0); % Since a0 = ln(b)
m = a1;      % m is directly the slope

% Plot the original data points
plot(x, y, 'ko'); % Black circles for raw data
hold on;

% Generate fitted curve over a wider range
xi = min(x);
xf = max(x);
width = xf - xi;
x_fit = linspace(xi-0.1*width, xf+0.1*width, 250);

% Plot the fitted exponential curve
plot(x_fit, b*exp(m*x_fit), 'r--'); % Red dashed line for fit

hold off;

% Add labels and grid
xlabel('year');
ylabel('population (millions)');
grid on;
legend('data', 'fit', 'location', 'northwest');
