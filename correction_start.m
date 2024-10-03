function error_number = correction_start

prompt = {'Enter the Transducer NUMBER that needs adjustment (or 0 to terminate script):'};
dlgtitle = 'Feedback';
fieldsize = [1 80];
definput = {'0'};
options.WindowStyle = 'normal';
answer = inputdlg(prompt, dlgtitle, fieldsize, definput, options);

error_number = str2double(answer);