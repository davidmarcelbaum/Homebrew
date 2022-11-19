data = OverallSpindles.E10.OdorOn;

for iSubj = 1:size(data, 2)
    
    early_break = 0;
    for iTrl = 1:size(data, 1)
        
        if isempty(data{iTrl, iSubj})
            numTrials(iSubj, 1) = iTrl - 1;
            early_break = 1;
            break
        end
        
        
    end
    
    if early_break == 0
        numTrials(iSubj) = iTrl;
    end
end