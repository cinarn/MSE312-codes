clear all;
clc;

% Load data for logistic curve
data = load('logistic_curve_data.txt');
x = data(:,1);
y = data(:,2);

% Define logistic model (cannot be linearized easily)
f = @(a, x) a(1) ./ (1 + exp(-a(2) * (x-a(3)))); 

% Initial guess for parameters [a(1), a(2), a(3)]
a0 = [0 0 0];

% Set optimization options
options = optimoptions('lsqcurvefit', ...
    'Algorithm', 'levenberg-marquardt', ...
    'MaxIterations', 1000, ...
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
plot(x_fit, f(a, x_fit), 'r--');
hold off;

xlabel('X');
ylabel('Y');
grid on;
legend('data', 'fit', 'location', 'northwest');
