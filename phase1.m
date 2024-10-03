function [fig2, time_difference, middle_distance] = ...
    phase1(data_name, middle_distance, transducer_distance, time_selected_peaks)

% Preallocation
fig2_name = append(data_name, ': Detonation Velocity');

% Calculating Position and Velocity Points
time_difference = diff(time_selected_peaks);
velocity = transducer_distance./time_difference;

% Plotting Details
fig2 = figure('Name', fig2_name); 
plot(middle_distance, velocity,'-o')
grid on
xlabel('Position between Transducers (m)'); ylabel('Speed (m/s)'); title(fig2_name, 'Interpreter', 'none')

fig2.Position = [0, 0, 700, 700];