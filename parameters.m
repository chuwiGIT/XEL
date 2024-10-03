function [data_name, time_run, transducer_num, middle_distance, transducer_distance, std_multiplier_num, ...
    pressure_matrix, pressure_data_size, pressure_data_time] = parameters

% UI get file (select .lvm files)
[file,location,indx] = uigetfile('*.lvm');
if isequal(file,0)
   error('User selected Cancel. Press Ctrl+C to terminate script. Then Restart.')
else
   disp(['User selected ', fullfile(location,file),... 
         ' and filter index: ', num2str(indx)])

% Hardcoded Parameters
data_name = erase(file, '.lvm');             % filename is the name of the lvm name (without the .lvm)
time_run = 0.5;                              % seconds
transducer_num = 9;                          % 9 transducers
transducer_position = [1.78435 2.346325 2.5019 2.9083 3.063875 3.470275 3.62585 4.03225 4.187825]; % transducer position (m)
transducer_distance = diff(transducer_position); % distance between each transducer position
middle_distance = (transducer_position(1:end-1) + transducer_position(2:end))/2; % takes the midpoint between each transducer position
std_multiplier_num = 10;                      % default stdev filtering parameter (higher = less peaks)

% Importing LVM file
data_struct = lvm_import(file); % importing unorganized data
pressure_matrix = data_struct.Segment1.data;
pressure_data_size = size(pressure_matrix,1);

% Linspace of time for all 250000 data points
pressure_data_time = [linspace(0, time_run, pressure_data_size)]';
end

