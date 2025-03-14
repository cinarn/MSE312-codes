clear all;
clc;

% Define the function to be integrated
f = @(x) 10*exp(-x);

% Define the exact integral function
g = @(a,b) f(a)-f(b);   % Exact integral

% Define integration limits
a = 0;
b = 3;
N = 60;  % Number of subintervals

h = (b-a)/N;  % Step size

% Generate equally spaced x values
x = linspace(a, b, N+1);
y = f(x);  % Evaluate function at x values

% Plot the function
figure;
plot(x, y, 'b-', 'LineWidth', 2);
title('Function Plot: f(x) = 10*exp(-x)');
xlabel('x');
ylabel('f(x)');
grid on;

% Compute exact integral value
Ie = g(a,b);  % Exact integral value

% Apply Trapezoidal Rule using direct formula
It1 = h/2*(y(1)+y(N+1)) + h*sum(y(2:N));

% Alternative method for the Trapezoidal Rule
It2 = h/2*sum(y(2:end) + y(1:end-1));

% Compute integral using MATLAB's built-in `trapz` function
It3 = trapz(x, y);

% Another alternative method using `diff`
It4 = sum(diff(x)/2 .* (y(2:end) + y(1:end-1)));

% Compute relative errors for different methods
Et1 = abs(1 - It1/Ie);
Et2 = abs(1 - It2/Ie);
Et3 = abs(1 - It3/Ie);
Et4 = abs(1 - It4/Ie);

% Display results with high precision
fprintf('Exact Integral Value: %.10f\n', Ie);
fprintf('--------------------------------------------------\n');
fprintf('Trapezoidal Rule (Method 1 - Direct Formula):\n');
fprintf('  Computed Integral: %.10f\n', It1);
fprintf('  Relative Error: %.10e\n', Et1);
fprintf('--------------------------------------------------\n');
fprintf('Trapezoidal Rule (Method 2 - Summation Formula):\n');
fprintf('  Computed Integral: %.10f\n', It2);
fprintf('  Relative Error: %.10e\n', Et2);
fprintf('--------------------------------------------------\n');
fprintf('MATLAB''s trapz Function:\n');
fprintf('  Computed Integral: %.10f\n', It3);
fprintf('  Relative Error: %.10e\n', Et3);
fprintf('--------------------------------------------------\n');
fprintf('Alternative Trapezoidal Rule (Using diff function):\n');
fprintf('  Computed Integral: %.10f\n', It4);
fprintf('  Relative Error: %.10e\n', Et4);
