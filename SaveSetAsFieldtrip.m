pathData = 'D:\germanStudyData\datasetsSETS\Ori_CueNight\preProcessing\EEGLABFiltered_Off_On\NREM';
FilesList = dir([pathData, filesep, '*.set']);

savePath = [pathData, filesep, 'Conv'];
mkdir(savePath)

for i_file = 1:numel({FilesList.name})
    
    hdr    = ft_read_header([pathData, filesep, ...
        FilesList(i_file).name]);
    data   = ft_read_data([pathData, filesep, ...
        FilesList(i_file).name], 'header', hdr);
    events = ft_read_event([pathData, filesep, ...
        FilesList(i_file).name], 'header', hdr);
    
    hdr.orig.rejecteddata = []; % Avoid saving an unsused large field
    
    saveName = strcat(extractBefore(FilesList(i_file).name, '.set'), ...
        '.mat');
    
    save([savePath, filesep, saveName], 'hdr', 'data', 'events', ...
        '-nocompression', '-v7.3');
    % Required for files larger than 2GB
    % nocompression should be set because files with non-repeated data
    % (such as EEG) will take a LONG time to be saved and loaded when
    % compressed!

end