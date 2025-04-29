clear all; % Clear all variables from the workspace
clc;       % Clear the command window

% Load data from a text file
data = load('population_data.txt');
x = data(:,1); % Extract year values
y = data(:,2); % Extract population values
n = length(x); % Number of data points

% Goal: Fit an exponential model p = b * e^(m*x)
% Linearize the model:
% ln(p) = ln(b) + m*x
% This transforms it into a linear form Y = a0 + a1*x

Y = log(y); % Take natural logarithm of population

% Set up the matrix for linear regression
X = [ones(n,1) x]; % [1 x] structure for each row

% Solve for coefficients using least squares
a = X \ Y; % a(1) = ln(b), a(2) = m

% Recover original coefficients
b = exp(a(1)); % Since a(1) = ln(b)
m = a(2);      % Slope remains the same

% Plot the original data
plot(x, y, 'ko'); % Black circles
hold on;

% Generate fitted curve
xi = min(x);
xf = max(x);
width = xf - xi;
x_fit = linspace(xi-0.1*width, xf+0.1*width, 250);

% Plot the fitted exponential curve
plot(x_fit, b*exp(m*x_fit), 'r--'); % Red dashed curve

hold off;

% Add labels, grid, and legend
xlabel('year');
ylabel('population (millions)');
grid on;
legend('data', 'fit', 'location', 'northwest');
