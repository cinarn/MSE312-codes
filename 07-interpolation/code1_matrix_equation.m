clear all;
clc;

% Define the given data points
x = [1 2 3 4 5 6 7 8];
y = [1 4 7 12 16 13 10 0];
n = length(x);

% Construct the Vandermonde matrix A for polynomial interpolation
A = zeros(n);
for i = 1:n
    for j = 1:n
        A(i,j) = x(i)^(j-1);  % Each row i corresponds to x(i) powers
    end
end

% Solve the linear system A*a = y to get polynomial coefficients
a = A\y';

% Evaluate the polynomial at many points for plotting
xx = linspace(min(x), max(x), 100);
yy = zeros(size(xx));
for i = 1:n
    yy = yy + a(i) * xx.^(i-1);  % Evaluate using the polynomial formula
end

% Plot the original points and the polynomial
plot(x, y, 'o', xx, yy, '-');
title('Exact Interpolation');
legend('Data Points', 'Interpolating Polynomial');
