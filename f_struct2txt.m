function f_struct2txt(structIn, exportPath, exportName)

% This function works on structures with three levels and will export it to
% a leveled text file
% structIn      = Structure variable to export
% exportPath    = Where the exported text file has to be saved
% exportName    = Naming the export file

if exist('OCTAVE_VERSION', 'builtin') == 0
    
if ~strcmp(exportPath(end), filesep)
    exportPath = strcat(exportPath, filesep);
end

if ~contains(exportName, '.txt')
    exportName = strcat(exportName, '.txt');
end

fid = fopen(strcat(exportPath, exportName), 'w+');
c_fieldsLev1 = fields(structIn);
for i_fld1 = 1:numel(c_fieldsLev1)
    fprintf(fid, '%s\n', strcat('+', string(c_fieldsLev1(i_fld1))));
    if isstruct(structIn.(char(c_fieldsLev1(i_fld1))))
        c_fieldsLev2 = fields(structIn.(char(c_fieldsLev1(i_fld1))));
        for i_fld2 = 1:numel(c_fieldsLev2)
            fprintf(fid, '%s\n', strcat('    +', string(c_fieldsLev2(i_fld2))));
            if isstruct(structIn.(char(c_fieldsLev1(i_fld1))).(char(c_fieldsLev2(i_fld2))))
                c_fieldsLev3 = fields(structIn.(char(c_fieldsLev1(i_fld1))).(char(c_fieldsLev2(i_fld2))));
                for i_fld3 = 1:numel(c_fieldsLev3)
                    fprintf(fid, '%s\n', strcat('        +', string(c_fieldsLev3(i_fld3))));
                    if isstruct(structIn.(char(c_fieldsLev1(i_fld1))).(char(c_fieldsLev2(i_fld2))).(char(c_fieldsLev3(i_fld3))))
                        warning('This function does not work with structures that contain 4 levels. Who creates structures this deep anyway?! You monster!')
                    elseif iscell(structIn.(char(c_fieldsLev1(i_fld1))).(char(c_fieldsLev2(i_fld2))).(char(c_fieldsLev3(i_fld3))))
                        for i_fld4 = 1:numel(structIn.(char(c_fieldsLev1(i_fld1))).(char(c_fieldsLev2(i_fld2))).(char(c_fieldsLev3(i_fld3))))
                            fprintf(fid, '%s\n',strcat('            +----', char(structIn.(char(c_fieldsLev1(i_fld1))).(char(c_fieldsLev2(i_fld2))).(char(c_fieldsLev3(i_fld3))){i_fld4})));
                        end
                    else
                        fprintf(fid, '%s\n',strcat('            +----', string(structIn.(char(c_fieldsLev1(i_fld1))).(char(c_fieldsLev2(i_fld2))).(char(c_fieldsLev3(i_fld3))))));
                    end
                end
            elseif iscell(structIn.(char(c_fieldsLev1(i_fld1))).(char(c_fieldsLev2(i_fld2))))
                for i_fld3 = 1:numel(structIn.(char(c_fieldsLev1(i_fld1))).(char(c_fieldsLev2(i_fld2))))
                    fprintf(fid, '%s\n',strcat('        +----', char(structIn.(char(c_fieldsLev1(i_fld1))).(char(c_fieldsLev2(i_fld2))){i_fld3})));
                end
            else
                fprintf(fid, '%s\n',strcat('        +----', string(structIn.(char(c_fieldsLev1(i_fld1))).(char(c_fieldsLev2(i_fld2))))));
            end
        end
    elseif iscell(structIn.(char(c_fieldsLev1(i_fld1))))
        for i_fld2 = 1:numel(structIn.(char(c_fieldsLev1(i_fld1))))
            fprintf(fid, '%s\n',strcat('    +----', string(structIn.(char(c_fieldsLev1(i_fld1))){i_fld2})));
        end
    else
        fprintf(fid, '%s\n',strcat('    +----', string(structIn.(char(c_fieldsLev1(i_fld1))))));
    end
end
fclose(fid);

elseif exist('OCTAVE_VERSION', 'builtin') ~= 0

if ~strcmp(exportPath(end), filesep)
    exportPath = strcat(exportPath, filesep);
end

if isempty(strfind(exportName, '.txt'))
    exportName = strcat(exportName, '.txt');
end

error('Octave compatibility is not implemented!')

end



end
