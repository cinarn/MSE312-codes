clear; clc;

% Define the function and its derivative
f = @(x) x.^3 + 3.*x.^2 - 10; % Function
fp = @(x) 3*x.^2 + 6*x;       % Derivative

% Define x values for plotting
x = linspace(-4, 3, 500); 

% Evaluate the function and its derivative
y_f = f(x);
y_fp = fp(x);

% Create a new figure
figure;

% Plot the function f(x) in blue
plot(x, y_f, 'b', 'LineWidth', 2); 
hold on; % Allows adding more plots on the same figure without erasing previous ones

% Plot the derivative f'(x) in red dashed line
plot(x, y_fp, 'r--', 'LineWidth', 2); 

hold off; % Stops adding plots, ensuring further plots create new figures

% Add labels and grid
xlabel('x');
ylabel('y');
grid on; % Enables grid for better visualization

% Add legend and title
legend({'f(x) = x^3 + 3x^2 - 10', 'f''(x) = 3x^2 + 6x'}, 'Location', 'northwest');
title('Plot of f(x) and f''(x)');
