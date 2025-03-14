clear all;
clc;

% Define the function to be integrated
f = @(x) 10*exp(-x);

% Define the exact integral function
g = @(a,b) f(a)-f(b);   % Exact integral

% Define integration limits
a = 0;
b = 3;
N = 60;  % Number of subintervals (should be even for Simpson's 1/3 rule)

h = (b-a)/N;  % Step size

% Generate equally spaced x values
x = linspace(a, b, N+1);
y = f(x);  % Evaluate function at x values

% Compute exact integral value
Ie = g(a,b);

% Apply Simpson's 1/3 Rule
Is13 = h/3 * ( y(1) + y(N+1) ...
    + 4*sum(y(2:2:N)) ...  % Sum of odd indices (coeff 4)
    + 2*sum(y(3:2:N-1)));  % Sum of even indices (coeff 2)

% Compute relative error for Simpson's 1/3 rule
Es13 = abs(1 - Is13/Ie);

% Apply Simpson's 3/8 Rule
Is38 = 3*h/8 * ( y(1) + y(N+1) ...
    + 3*sum(y(2:3:N-1)) ...  % Sum of first two in every three (coeff 3)
    + 3*sum(y(3:3:N)) ...     % Sum of second two in every three (coeff 3)
    + 2*sum(y(4:3:N-2)));     % Sum of multiples of three (coeff 2)

% Compute relative error for Simpson's 3/8 rule
Es38 = abs(1 - Is38/Ie);

% Compute integral using MATLAB's built-in function
I_int = integral(f, a, b);

% Compute relative error for MATLAB's integral function
E_int = abs(1 - I_int/Ie);

% Display results with high precision
fprintf('Exact Integral Value: %.10f\n', Ie);
fprintf('--------------------------------------------------\n');
fprintf('Simpson''s 1/3 Rule:\n');
fprintf('  Computed Integral: %.10f\n', Is13);
fprintf('  Relative Error: %.10e\n', Es13);
fprintf('--------------------------------------------------\n');
fprintf('Simpson''s 3/8 Rule:\n');
fprintf('  Computed Integral: %.10f\n', Is38);
fprintf('  Relative Error: %.10e\n', Es38);
fprintf('--------------------------------------------------\n');
fprintf('MATLAB''s Integral Function:\n');
fprintf('  Computed Integral: %.10f\n', I_int);
fprintf('  Relative Error: %.10e\n', E_int);
