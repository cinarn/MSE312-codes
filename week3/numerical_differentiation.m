% Clear workspace and command window
clear all;   % Remove all variables from workspace
clc;         % Clear the command window

% Define the function f(t) and its exact first derivative f'(t)
f = @(t) 5 + 2*t.^0.5;    % f(t) = 5 + 2√t
fprime = @(t) t.^-0.5;    % f'(t) = 1/√t (exact derivative)

% Define step size and domain for t
h = 0.5;                    % Step size (h = 2)
t = 5:h:15;               % Generate t values from 5 to 15 with step h
N = length(t);            % Number of points in t

% Compute the function values at the given points
y = f(t);                 % Evaluate f(t) at each t

% Display the values of t and f(t) in the Command Window
disp('     t          f(t)');
disp([t' y']);

% Compute the exact derivative using fprime for comparison
dydt_exact = fprime(t);   % Exact derivative values at each t

%% -------------------------------
%% Forward Differentiation
%% -------------------------------
% The forward difference formula:
%   dydt(i) ≈ (y(i+1) - y(i)) / h
%
% Loop-based implementation:
dydt_forward = zeros(1, N);   % Initialize forward derivative array with zeros
for i = 1:N-1              % Loop over points 1 to N-1
    dydt_forward(i) = (y(i+1) - y(i)) / h;  % Compute forward difference at index i
end
dydt_forward(N) = NaN;     % The last point has no forward difference (set as NaN)

%% -------------------------------
%% Backward Differentiation
%% -------------------------------
% The backward difference formula:
%   dydt(i) ≈ (y(i) - y(i-1)) / h
%
% Vectorized implementation:
dydt_backward = [NaN, (y(2:N) - y(1:N-1)) / h];  
% Prepend NaN for the first point (backward difference is undefined at index 1)

%% -------------------------------
%% Central Differentiation
%% -------------------------------
% The central difference formula:
%   dydt(i) ≈ (y(i+1) - y(i-1)) / (2*h)
%
% Vectorized implementation (commented out):
% dydt_central_vector = [NaN, (y(3:N) - y(1:N-2)) / (2*h), NaN];
%
% Loop-based implementation:
dydt_central = zeros(1, N);  % Initialize central derivative array with zeros
for i = 2:N-1            % Loop over indices 2 to N-1 (exclude boundaries)
    dydt_central(i) = (y(i+1) - y(i-1)) / (2*h);  % Compute central difference
end
dydt_central(1) = NaN;    % Set first point to NaN (undefined)
dydt_central(N) = NaN;    % Set last point to NaN (undefined)

%% -------------------------------
%% Plotting First Derivative Approximations
%% -------------------------------
figure;                      % Create new figure
subplot(1,2,1);              % First subplot: Derivative approximations
plot(t, dydt_exact, 'ko-', 'LineWidth', 2);  % Plot exact derivative with black circles
hold on;                     % Hold the plot to overlay more lines
plot(t, dydt_forward, 'bo-', 'LineWidth', 1.5); % Plot forward difference in blue circles
plot(t, dydt_backward, 'rd-', 'LineWidth', 1.5);% Plot backward difference in red diamonds
plot(t, dydt_central, 'ms-', 'LineWidth', 1.5); % Plot central difference in magenta squares
hold off;                    % Release the plot hold
xlabel('t');                 % Label x-axis
ylabel('df/dt');             % Label y-axis
legend('Exact', 'Forward', 'Backward', 'Central');  % Add legend with labels
title('First Derivative Approximation');  % Title for the plot
grid on;                     % Turn on grid for clarity

%% -------------------------------
%% Compute Relative Errors for First Derivative
%% -------------------------------
error_forward = abs((dydt_forward - dydt_exact) ./ dydt_exact);   % Relative error for forward difference
error_backward = abs((dydt_backward - dydt_exact) ./ dydt_exact); % Relative error for backward difference
error_central = abs((dydt_central - dydt_exact) ./ dydt_exact);   % Relative error for central difference

% Plot the errors in a separate subplot
subplot(1,2,2);             % Second subplot: Error comparison
plot(t, error_forward, 'bo-', 'LineWidth', 1.5); % Plot error for forward difference in blue circles
hold on;                    
plot(t, error_backward, 'rd-', 'LineWidth', 1.5); % Plot error for backward difference in red diamonds
plot(t, error_central, 'ms-', 'LineWidth', 1.5);  % Plot error for central difference in magenta squares
hold off;                    
xlabel('t');                
ylabel('Relative Error');   
legend('Forward Error', 'Backward Error', 'Central Error');  % Legend for errors
title('Error Comparison for First Derivative');  % Title for error plot
grid on;                    

%% -------------------------------
%% Second Derivative Computation (Central Difference)
%% -------------------------------
% Define the exact second derivative of f(t)
fprime2 = @(t) -0.5*t.^-1.5;   % f''(t) = -0.5 * t^(-1.5)
dydt2_exact = fprime2(t);       % Compute exact second derivative

% Use the central difference formula for second derivative:
% dydt2(i) ≈ (y(i+1) + y(i-1) - 2*y(i)) / h^2
%
% Vectorized implementation (commented out):
% dydt2_central_vector = [NaN, (y(3:N) + y(1:N-2) - 2*y(2:N-1)) / (h^2), NaN];
%
% Loop-based implementation:
dydt2_central = zeros(1, N);  % Initialize second derivative array with zeros
for i = 2:N-1            % Loop from the second to the second-to-last index
    dydt2_central(i) = (y(i+1) + y(i-1) - 2*y(i)) / (h^2);
end
% Set boundaries to NaN (not defined using central difference)
dydt2_central(1) = NaN;
dydt2_central(N) = NaN;

% Compute the relative error for the second derivative
error2_central = abs((dydt2_central - dydt2_exact) ./ dydt2_exact);

%% -------------------------------
%% Plot Second Derivative Approximations and Errors
%% -------------------------------
figure;   % Create a new figure for second derivative plots

% Subplot for second derivative approximations
subplot(1,2,1);
hold on;
plot(t, dydt2_exact, 'ko-', 'LineWidth', 2);   % Plot exact second derivative in black
plot(t, dydt2_central, 'rd-', 'LineWidth', 1.5);  % Plot central difference approximation in red
hold off;
xlabel('t');
ylabel('d^2f/dt^2');
legend('Exact', 'Central');
title('Second Derivative Approximation');
grid on;

% Subplot for second derivative error
subplot(1,2,2);
plot(t, error2_central, 'rd-', 'LineWidth', 1.5);  % Plot relative error for second derivative
xlabel('t');
ylabel('Relative Error');
legend('Central Error');
title('Error in Second Derivative Approximation');
grid on;
