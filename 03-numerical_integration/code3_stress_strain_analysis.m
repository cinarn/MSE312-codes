% Clear all variables and command window
clear all;
clc;

% Load stress-strain data from file
data = load('stress_strain.txt');

% Extract stress (MPa) and strain (%) and convert strain to a fraction
stress = data(:,1);  
strain = data(:,2) / 100;  % Convert percentage to fraction

% Calculate the toughness (area under the stress-strain curve)
toughness = trapz(strain, stress);  % MPa * unitless strain = MJ/m³

% Define the elastic region (assuming strain < 0.002 as elastic)
elastic_idx = strain < 0.002;
elastic_strain = strain(elastic_idx);
elastic_stress = stress(elastic_idx);

% Compute Young's modulus (slope of the elastic region)
young_modulus = mean(diff(elastic_stress) ./ diff(elastic_strain));  % MPa

% Plot stress-strain curve
figure;
hold on;
plot(strain, stress, 'b.', 'DisplayName', 'Stress-Strain Data'); % Original data

% Plot linear elastic region
linear_elastic_line = young_modulus * (strain - 0.002); % Offset 0.2% strain
plot(strain, linear_elastic_line, 'r-', 'DisplayName', '0.2% Offset Line');

% Find proof stress (intersection of offset line and stress-strain curve)
proof_stress_idx = find(linear_elastic_line <= stress, 1, 'last');
proof_stress = stress(proof_stress_idx);

% Highlight proof stress point
plot(strain(proof_stress_idx), proof_stress, 'ko', 'MarkerFaceColor', 'k', ...
    'DisplayName', 'Proof Stress');

% Improve plot aesthetics
ylim([0, max(stress) * 1.2]);
xlabel('Strain (fraction)');
ylabel('Stress (MPa)');
title('Stress-Strain Curve');
legend('Location', 'best');
grid on;
hold off;

% Display computed values with correct units
fprintf('Young\''s Modulus: %.2f MPa\n', young_modulus);
fprintf('Proof Stress: %.2f MPa\n', proof_stress);
fprintf('Toughness: %.2f MJ/m³\n', toughness);
