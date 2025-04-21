clear all;
clc

% Define the differential equation dy/dx = f(x, y)
f = @(x,y) x.^2./y;

% Define the analytical solution for comparison
y_analytical = @(x) sqrt(2*x.^3/3 + 4);

% Initial conditions and parameters
x0 = 0;      % initial x value
y0 = 2;      % initial y value
x1 = 2.1;    % final x value
h = 0.7;     % step size
N = (x1 - x0) / h;  % number of steps

%% Euler's Method
fprintf('Euler''s method:\n');
x = x0;
y = y0;
for i = 1:N
    y = y + f(x, y) * h;  % Euler's update
    x = x + h;
    ya = y_analytical(x); % Analytical value at current x
    rel_err = abs(1 - y / ya); % Relative error
    fprintf('x = %.4f, y = %.4f, ya = %.4f, rel_err = %g\n', x, y, ya, rel_err);
end

%% Modified Euler's Method (Heun's Method)
fprintf('Modified Euler''s (Heun''s) method:\n');
x = x0;
y = y0;
for i = 1:N
    yeu = y + f(x, y) * h; % Predict y using Euler
    y = y + h / 2 * (f(x, y) + f(x + h, yeu)); % Corrected y using average slope
    x = x + h;
    ya = y_analytical(x);
    rel_err = abs(1 - y / ya);
    fprintf('x = %.4f, y = %.4f, ya = %.4f, rel_err = %g\n', x, y, ya, rel_err);
end

%% Runge-Kutta 2nd Order Method (RK2)
fprintf('RK2 method:\n');
x = x0;
y = y0;
for i = 1:N
    K1 = f(x, y); % First slope
    K2 = f(x + h, y + K1 * h); % Slope at endpoint
    y = y + h / 2 * (K1 + K2); % Average slope
    x = x + h;
    ya = y_analytical(x);
    rel_err = abs(1 - y / ya);
    fprintf('x = %.4f, y = %.4f, ya = %.4f, rel_err = %g\n', x, y, ya, rel_err);
end

%% Runge-Kutta 4th Order Method (RK4)
fprintf('RK4 method:\n');
x = x0;
y = y0;
for i = 1:N
    K1 = f(x, y);                            % Slope at start
    K2 = f(x + h / 2, y + K1 * h / 2);       % Slope at midpoint (1)
    K3 = f(x + h / 2, y + K2 * h / 2);       % Slope at midpoint (2)
    K4 = f(x + h, y + K3 * h);               % Slope at end
    y = y + h / 6 * (K1 + 2 * K2 + 2 * K3 + K4); % Weighted average
    x = x + h;
    ya = y_analytical(x);
    rel_err = abs(1 - y / ya);
    fprintf('x = %.4f, y = %.4f, ya = %.4f, rel_err = %g\n', x, y, ya, rel_err);
end

%% Optional: Solve using built-in RK4 function from Gilat & Subramaniam textbook
% Uncomment and use if 'odeRK4' is available in your workspace
% [x, y] = odeRK4(@(x,y) x.^2/y, 0, 2.1, 0.7, 2)
