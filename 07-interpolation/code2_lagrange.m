clear all;
clc;

% Input data points
x = [1 2 3 4 5 6 7 8];
y = [1 4 7 12 16 13 10 0];
n = length(x);

% Prepare evaluation grid
xx = linspace(min(x), max(x), 100);
yy = zeros(size(xx));

% Compute the Lagrange interpolation polynomial at each point in xx
for k = 1:length(xx)
    z = xx(k);
    sum = 0;  % Initialize the interpolated value at xx(k)
    for i = 1:n
        L = 1;  % Initialize L_i(xx(k))
        for j = 1:n
            if i ~= j
                L = L * (z - x(j)) / (x(i) - x(j));  % Compute basis polynomial
            end
        end
        sum = sum + y(i) * L;  % Accumulate weighted basis polynomial
    end
    yy(k) = sum;  % Assign the computed value
end

% Plot the result
plot(x, y, 'o', xx, yy, '-');
title('Lagrange Interpolation');
legend('Data Points', 'Lagrange Polynomial');
