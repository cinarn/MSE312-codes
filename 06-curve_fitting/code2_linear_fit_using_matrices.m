clear all; % Clear all variables from the workspace
clc;       % Clear the command window

% Load data from a text file
% Assumes 'random_data.txt' has two columns: x and y values
data = load('random_data.txt');
x = data(:,1); % Extract first column as x
y = data(:,2); % Extract second column as y
n = length(x); % Number of data points

% Construct the matrix X for linear regression: [1 x]
% Each row corresponds to a data point: [1, xi]
X = [ones(n,1) x];

% Solve the normal equations using matrix division (least squares solution)
% a(1) = intercept (a0), a(2) = slope (a1)
a = X \ y; % This is a compact way to solve X*a = y

% Plot the original data points
plot(x, y, 'ko'); % Black circles
hold on;

% Generate x values for the fitted line
xi = min(x);
xf = max(x);
width = xf - xi;
x_fit = linspace(xi-0.1*width, xf+0.1*width, 250);

% Plot the fitted line
plot(x_fit, a(1) + a(2)*x_fit, 'r--'); % Fitted line (red dashed)

hold off;

% Label the axes
xlabel('X');
ylabel('Y');

% Add grid and legend
grid on;
legend('data', 'fit', 'location', 'northwest');
