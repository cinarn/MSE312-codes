clear; clc;

% Define the function and its derivative
f = @(x) x.^3 + 3.*x.^2 - 10; % Function
fp = @(x) 3*x.^2 + 6*x;       % Derivative

% Initial guess
x = 1.0;

% Maximum number of iterations and tolerance
max_num_iter = 100;
tol = 1e-6;

for i = 1:max_num_iter
    x_old = x; % Store the previous value
    
    % Compute the next approximation
    x = x - f(x) / fp(x);
    
    % Compute relative error
    delta = abs((x - x_old) / x);
    
    % Check convergence
    if delta < tol
        fprintf('Root found: x = %.8f\n', x);
        break;
    end
    
    % Display current iteration details
    fprintf('Iter: %d, x = %.8f, delta = %.8f, f(x) = %.8f, f\''(x) = %.8f\n', ...
        i, x, delta, f(x), fp(x));
end

% If the maximum number of iterations is reached
if i == max_num_iter
    fprintf('Root not found within %d iterations\n', max_num_iter);
end
