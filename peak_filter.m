function [fig1, time_selected_peaks, group_peaks, group_locations, chosen_peaks_and_times] = ...
    peak_filter(transducer_num, pressure_matrix_normalized, pressure_data_time, std_multiplier_num, data_name)

% Preallocation
time_selected_peaks = zeros(1,transducer_num);
chosen_peaks_and_times = zeros(transducer_num, 2);
group_peaks = cell(1,transducer_num);
group_locations = cell(1,transducer_num);
NumTicks = 4; % 4 X-axis ticks per Transducer Graph

% Graph details
transducer_graph_name = append(data_name, ': Transducer Readings');
fig1 = figure('Name', transducer_graph_name);
tile_fig1 = tiledlayout(3,3);
tile_fig1.Padding = "compact";
tile_fig1.TileSpacing = "compact";
title(tile_fig1, transducer_graph_name, 'Interpreter', 'none')
xlabel(tile_fig1, 'Time (s)')
ylabel(tile_fig1, 'Arbitrary Y-Value')

% Peak Filtering and 1st-Round Logical Peak Selection
for column_number = 1:transducer_num
    entry_number = 2;
    pressure_data_by_column_number = pressure_matrix_normalized(:,column_number);
    [peaks, location] = findpeaks(pressure_data_by_column_number, pressure_data_time,...
        'MinPeakProminence', std_multiplier_num * std(pressure_data_by_column_number));
    
    group_peaks{1,column_number} = num2cell(peaks);
    group_locations{1,column_number} = num2cell(location);
    time_selected_peaks(1, column_number) = cell2mat(group_locations{1, column_number}(1));

    if column_number > 1
        time_selected_peaks(1, column_number) = cell2mat(group_locations{1, column_number}(1));
        while time_selected_peaks(1, column_number) <= time_selected_peaks(1, column_number-1)
            time_selected_peaks(1, column_number) = cell2mat(group_locations{1, column_number}(entry_number));
            entry_number = entry_number + 1;
        end
    end

    time_range = [0.999*group_locations{1,column_number}{1}, 1.001*group_locations{1,column_number}{end}];
    chosen_peaks_and_times(column_number, :) = ...
        [time_selected_peaks(1, column_number), cell2mat(group_peaks{1, column_number}(entry_number-1))];
    
    % Plotting Details for Each Graph
    ax_fig2 = nexttile(column_number);
    hold on
    plot(pressure_data_time, pressure_matrix_normalized(:,column_number),...
        cell2mat(group_locations{1, column_number}), cell2mat(group_peaks{1, column_number}),'--o')
    plot_star = plot(chosen_peaks_and_times(column_number, 1), chosen_peaks_and_times(column_number, 2));
    plot_star.Marker = 'pentagram'; plot_star.MarkerSize = 10;
    plot_star.MarkerFaceColor = [0 1 0]; plot_star.MarkerEdgeColor = [0 1 0];

    title(ax_fig2, append('Transducer ', string(column_number)))
    xlim(ax_fig2, time_range)
    set(ax_fig2,'XTick',linspace(time_range(1),time_range(2),NumTicks))
    ylim(ax_fig2, [0, 1.1])
end
hold off

lgd_fig1 = legend({'Data', 'Peaks', 'Selected Peak'});
lgd_fig1.Layout.Tile = 'north'; lgd_fig1.Orientation = "horizontal";
fig1.Position = [720, 0, 800, 700];
end