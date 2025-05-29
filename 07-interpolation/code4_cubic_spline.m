clear all;
clc;

% Data points
x = [1 2 3 4 5 6 7 8];
y = [1 4 7 12 16 13 10 0];
n = length(x);

% Step 1: Compute intervals h between x values
h = zeros(n-1,1);
for i = 1:n-1
    h(i) = x(i+1) - x(i);
end

% Step 2: Build the linear system A*a = b for second derivatives
A = zeros(n-2);
b = zeros(n-2,1);
for i=1:n-2
    A(i,i) = 2*(h(i)+h(i+1));
    if i > 1
        A(i,i-1) = h(i);
    end
    if i < n-2
        A(i,i+1) = h(i+1);
    end
    b(i) = 6*((y(i+2)-y(i+1))/h(i+1) - (y(i+1)-y(i))/h(i));
end

% Step 3: Solve for second derivatives at interior points
a = A\b;
a = [0; a; 0];  % Natural spline boundary conditions (second derivative = 0)

% Step 4: Define the spline function piecewise
f = @(i, z) a(i)/(6*h(i))*(x(i+1)-z)^3 ...
    + a(i+1)/(6*h(i))*(z-x(i))^3 ...
    + (y(i)/h(i) - a(i)*h(i)/6)*(x(i+1)-z) ...
    + (y(i+1)/h(i) - a(i+1)*h(i)/6)*(z-x(i));

% Step 5: Evaluate spline at many points
xx = linspace(min(x), max(x), 100);
yy = zeros(size(xx));
for k = 1:length(xx)
    for i = 1:n-1
        if xx(k) >= x(i) && xx(k) <= x(i+1)
            yy(k) = f(i,xx(k));
            break;
        end
    end
end

% Plot the spline
plot(x, y, 'o', xx, yy, '-');
title('Natural Cubic Spline');
legend('Data Points', 'Cubic Spline');
