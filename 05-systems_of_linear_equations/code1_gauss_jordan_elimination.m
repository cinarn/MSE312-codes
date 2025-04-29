clear all; clc

% Size of the square matrix
N = 3;

% Generate a random NxN matrix A with values between 1 and 10
A = randi(10, N);

% Regenerate A until it is invertible (i.e., det(A) ≠ 0)
while det(A) < 1e-12
    A = randi(10, N);
end

% Generate a random Nx2 matrix b (2 columns of right-hand sides)
b = randi(10, N, 2);

% Create the augmented matrix [A | b]
aug = [A b];

% --- Forward Elimination ---
fprintf('Forward elimination:\n');
for i = 1:N
    % Find the maximum absolute value in the current column below or at row i
    [amax, idx] = max(aug(i:end, i));
    idx = idx + i - 1;  % Adjust index relative to full matrix

    % Swap current row with the row having the max pivot value (partial pivoting)
    
    % Method 1 (manual row swap using a temporary variable):
    temp = aug(idx, :);        % Store the row to swap
    aug(idx, :) = aug(i, :);   % Move row i into row idx
    aug(i, :) = temp;          % Move temp into row i

    % Method 2 (compact swap - equivalent):
    % aug([i idx], :) = aug([idx i], :);

    fprintf('Partial pivoting:\n');
    aug  % Display augmented matrix after pivoting

    % Eliminate entries below the pivot element
    for j = i+1:N
        factor = aug(j, i) / aug(i, i);  % Compute elimination factor
        aug(j, :) = aug(j, :) - factor * aug(i, :);  % Row operation
        fprintf('A(%d,%d)/A(%d,%d) = %g\n', j, i, i, i, factor);
        aug  % Show augmented matrix after each elimination step
    end
end

% --- Backward Elimination (to Reduced Row Echelon Form) ---
fprintf('Backward elimination:\n');
for i = N:-1:1
    fprintf('Normalize diagonal A(%d,%d):\n', i, i);
    aug(i, :) = aug(i, :) / aug(i, i);  % Normalize pivot to 1
    aug  % Show matrix after normalization

    % Eliminate entries above the pivot
    for j = i-1:-1:1
        factor = aug(j, i) / aug(i, i);
        aug(j, :) = aug(j, :) - factor * aug(i, :);
        fprintf('A(%d,%d)/A(%d,%d) = %g\n', j, i, i, i, factor);
        aug  % Show matrix after elimination above the pivot
    end
end

% --- Extract the solution from the augmented matrix ---
fprintf('Obtained solution:\n');
x1 = aug(:, N+1:end)  % Extract solution columns from augmented matrix

% --- Compare with MATLAB's built-in solver ---
fprintf('MATLAB A\\b:\n');
x2 = A \ b  % Solve using MATLAB’s backslash operator
