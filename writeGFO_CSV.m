function writeGFO_CSV(OutFilename, t_dy, Rho, Rho_dot)
    % Open the output file for writing 
    %w stands for write mode, so the code is specifying that it will be
    %writign to the given file
    file = fopen(OutFilename, 'w');

    % Write headers
    fprintf(file, 'time [dec. year],range [m],range-rate [m/s]\n');

    % Write data to the file. After the headers, the for loop will write
    % each of the chategories t_dy, Rho(i) and Rho_dot(i) to the file.
    for i = 1:86400
        fprintf(file, '%f,%f,%f\n', t_dy(i), Rho(i), Rho_dot(i));
    end

    % Closes the file
    fclose(file);
end