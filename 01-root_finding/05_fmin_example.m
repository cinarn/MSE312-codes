clear; clc;

% Define the function
f = @(x) x.^3 + 3.*x.^2 - 10; % Function whose root we want to find

% Initial guess
x0 = 1.0;

% Set options for fzero (show iterations)
options = optimset('Display', 'iter');

% Find the root using fzero
[x, fval, exitflag, output] = fzero(f, x0, options);

% Display the results
fprintf('\nRoot found: x = %.8f\n', x);
fprintf('Function value at root: f(x) = %.8f\n', fval);
fprintf('Number of iterations: %d\n', output.iterations);
fprintf('Exit flag: %d (1 = Success, 0 = Failure)\n', exitflag);

% Check if fzero converged successfully
if exitflag == 1
    fprintf('The root was successfully found within the given tolerance.\n');
else
    fprintf('fzero did not converge. Try a different initial guess or method.\n');
end
