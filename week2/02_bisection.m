clear; clc;

% Define the function
f = @(x) x.^3 + 3.*x.^2 - 10; % Function whose root we want to find

% Define the interval [xl, xr]
xl = 0;
xr = 3;

% Maximum number of iterations and tolerance
max_num_iter = 100;
tol = 1e-6;

% Initialize previous midpoint to a large value for comparison
x_old = inf;

% Ensure the function has opposite signs at the interval endpoints
if f(xl) * f(xr) < 0
    for i = 1:max_num_iter
        % Compute the midpoint
        xm = (xl + xr) / 2;
        
        % Compute relative error
        delta = abs((xm - x_old) / xm);
        
        % Check convergence
        if delta < tol
            fprintf('Root found: x = %.8f\n', xm);
            break;
        end
        
        % Determine which subinterval contains the root
        if f(xm) * f(xr) < 0
            xl = xm; % Root is in the right subinterval
        else
            xr = xm; % Root is in the left subinterval
        end
        
        % Display current iteration details
        fprintf('Iter: %d, x = %.8f, delta = %.8f, f(x) = %.8f\n', i, xm, delta, f(xm));
        
        % Update previous midpoint
        x_old = xm;
    end
    
    % If the maximum number of iterations is reached
    if i == max_num_iter
        fprintf('Root not found within %d iterations\n', max_num_iter);
    end
else
    fprintf('No root exists in the given interval [%f, %f]\n', xl, xr);
end
