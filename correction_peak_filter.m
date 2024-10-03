function time_selected_peaks = correction_peak_filter(data_name, pressure_data_time, pressure_matrix_normalized, ...
    error_number, group_locations, group_peaks, pressure_data_max_time, time_selected_peaks, chosen_peaks_and_times)

% Correction Plot Pop-Ups
fig3_name = append('(CORRECTION) ', data_name, ': Transducer ', string(error_number), ' Data and Peaks');
fig3 = figure('Name', fig3_name);
hold on
plot(pressure_data_time, pressure_matrix_normalized(:,error_number));
h2 = plot(cell2mat(group_locations{1,error_number}), cell2mat(group_peaks{1,error_number}),'--o');
plot_star = plot(chosen_peaks_and_times(error_number, 1), chosen_peaks_and_times(error_number, 2));
plot_star.Marker = 'pentagram'; plot_star.MarkerSize = 10;
plot_star.MarkerFaceColor = [0 1 0]; plot_star.MarkerEdgeColor = [0 1 0];
grid on
xlim([0.999*pressure_data_max_time(1), 1.01*pressure_data_max_time(1)])
ylim([0,1])
ylabel('Arbitrary Y-Value')
title(fig3_name, 'Interpreter', 'none')
hold off

legend({'Data', 'Peaks', 'Previous Selected Peak'}, 'Location', 'northeast')
fig3.Position = [0, 0, 700, 700];

% Mouse-Clicking Mechanism
if evalin('base', 'exist("time_selected_coordinate", "var")')
    time_placeholder = evalin('base', 'time_selected_coordinate(1)');
    disp(time_placeholder) 
else
    time_placeholder = -1;
end

h2.ButtonDownFcn = @showZValueFcn;

uiwait(fig3)
if evalin('base', 'exist("time_selected_coordinate", "var")')
    time_saved = evalin('base', 'time_selected_coordinate(1)');
    if time_saved ~= time_placeholder
    time_selected_peaks(error_number) = time_saved;
    fprintf('Selected time point from Transducer %d is: %.5f second\n\n', error_number, time_saved)
    else 
    fprintf('[No change] Selected time point from Transducer %d is: %.5f second\n\n', error_number, time_selected_peaks(error_number))
    end
else
    disp('No time selected.');
end
end

% Mechanism Function
function [coordinateSelected, minIdx] = showZValueFcn(hObj, event)
x = hObj.XData; 
y = hObj.YData; 
pt = event.IntersectionPoint;       % The (x0,y0,z0) coordinate you just selected
pt(:,3) = [];                       % deletes the z0 coordinates

coordinates = [x(:),y(:)];          % matrix of your input coordinates

dist = pdist2(pt(1:2),coordinates); % distance between your selection and all points
[~, minIdx] = min(dist);            % index of minimum distance to points
coordinateSelected = coordinates(minIdx,:); % the selected coordinate
assignin('base', 'time_selected_coordinate', coordinateSelected);

fprintf('[x,y] = [%.5f, %.5f]\n', coordinateSelected)
end