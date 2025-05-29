clear all;
clc;

% Input data
x = [1 2 3 4 5 6 7 8];
y = [1 4 7 12 16 13 10 0];

% Define evaluation points
xx = linspace(min(x), max(x), 100);
yy = zeros(size(xx));

% Apply linear interpolation for each interval
for k = 1:length(xx)
    z = xx(k)
    for i = 1:length(x)-1
        if x(i) <= z && z <= x(i+1)
            % Linearly interpolate between y(i) and y(i+1)
            yy(k) = (z-x(i+1))/(x(i)-x(i+1))*y(i) + (z-x(i))/(x(i+1)-x(i))*y(i+1);
            break;
        end
    end
end

% Plot the linear spline
plot(x, y, 'o', xx, yy, '-');
title('Linear Spline');
legend('Data Points', 'Linear Segments');
