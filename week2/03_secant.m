clear; clc;

% Define the function
f = @(x) x.^3 + 3.*x.^2 - 10; % Function

% Initial guesses
x0 = 1.0;
x1 = 2.0;

% Maximum number of iterations and tolerance
max_num_iter = 100;
tol = 1e-6;

for i = 1:max_num_iter
    % Compute the next approximation using the secant method formula
    x = x1 - f(x1) * (x1 - x0) / (f(x1) - f(x0));
    
    % Compute relative error
    delta = abs((x - x1) / x);
    
    % Check convergence
    if delta < tol
        fprintf('Root found: x = %.8f\n', x);
        break;
    end
    
    % Display current iteration details
    fprintf('Iter: %d, x0 = %.8f, x1 = %.8f, x = %.8f, delta = %.8f, f(x) = %.8f\n', ...
        i, x0, x1, x, delta, f(x));
    
    % Update previous values for the next iteration
    x0 = x1;
    x1 = x;
end

% If the maximum number of iterations is reached
if i == max_num_iter
    fprintf('Root not found within %d iterations\n', max_num_iter);
end
