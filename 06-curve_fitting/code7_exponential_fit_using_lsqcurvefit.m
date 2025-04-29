clear all;
clc;

% Load data from a text file
% Assumes 'population_data.txt' has two columns: year (x) and population (y)
data = load('population_data.txt');
x = data(:,1); % Extract year
y = data(:,2); % Extract population

% Define model function for fitting: exponential form
f = @(a, x) a(1)*exp(a(2)*x);

% Initial guess for parameters [a(1), a(2)]
a0 = [0 0];

% Set options for the optimization solver
options = optimoptions('lsqcurvefit', ...
    'Algorithm', 'levenberg-marquardt', ...
    'MaxIterations', 1000, ...   % Allow more iterations
    'MaxFunctionEvaluations', 5000, ... 
    'FunctionTolerance', 1e-9, ...
    'StepTolerance', 1e-9);

% Solve nonlinear least squares fitting
a = lsqcurvefit(f, a0, x, y, [], [], options);

% Plot original data
plot(x, y, 'ko');
hold on;

% Generate smooth curve
xi = min(x);
xf = max(x);
width = xf - xi;
x_fit = linspace(xi-0.1*width, xf+0.1*width, 250);

% Plot fitted model
plot(x_fit, a(1)*exp(a(2)*x_fit), 'r--');
hold off;

xlabel('year');
ylabel('population (millions)');
grid on;
legend('data', 'fit', 'location', 'northwest');
