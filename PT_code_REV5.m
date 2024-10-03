clf(); clc; close all; clear

%% Hardcoded Parameters & Importing and Preparing LVM Data
[data_name, time_run, transducer_num, middle_distance, transducer_distance, std_multiplier_num, ...
    pressure_matrix, pressure_data_size, pressure_data_time] = parameters;

clc;

%% Scaling/Normalizing Pressure Data
pressure_matrix_normalized = normalize(pressure_matrix, 1, "range");

[~, pressure_matrix_max_index] = max(pressure_matrix);
pressure_data_max_time = pressure_data_time(pressure_matrix_max_index);

%% Peak Filtering Phase
[fig1, time_selected_peaks, group_peaks, group_locations, chosen_peaks_and_times] = peak_filter(transducer_num, pressure_matrix_normalized,...
    pressure_data_time, std_multiplier_num, data_name);
shg
clc;

%% PHASE 1: Graphing Experimental Detonation Velocity
[fig2, time_difference, middle_distance] = ...
    phase1(data_name, middle_distance, transducer_distance, time_selected_peaks);
shg

clc;

%% CORRECTION Phase (Phase 2)

% Once both graphs are shown, user has option to change any peak selection
error_number = correction_start;

% Cases
while error_number ~= 0
    if ishandle(fig2)
        close(fig2)
    end
    time_selected_peaks = correction_peak_filter(data_name, pressure_data_time, pressure_matrix_normalized, ...
    error_number, group_locations, group_peaks, pressure_data_max_time, time_selected_peaks, chosen_peaks_and_times);
    
    error_number = correction_start;
end

clc;
if ishandle(fig2)
    close(fig2)
end

[fig2, time_difference, middle_distance] = ...
    phase1(data_name, middle_distance, transducer_distance, time_selected_peaks);
shg;

pause(3)
clc;
