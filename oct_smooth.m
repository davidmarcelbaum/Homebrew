function [v_smoothed] = oct_smooth(v_in, s_smoothing)

% This function is an attempt to imitate the MATLAB function "smooth" with
% its default parameters (moving average taking into account s_smoothing
% data points and dealing with missing points at start and end of array)

% v_in              A n-by-1 or 1-by-n vector
% s_smoothing       Smoothing degree (scalar of data points per averaging)

size_in = numel(v_in);

v_smoothed = nan(size_in, 1);

for i_init = 1:s_smoothing/2
    % Increasing number of data points available
    s_span = i_init - 1 + i_init;
    v_smoothed(i_init) = sum(v_in(1:s_span)) / s_span;
    % v_smoothed(i_init) = mean(v_in(1:s_span));
end

% Attempt to speed up this for loop since it's taking the longest and has 
% variables of constant lengths
idx_span = zeros(1, s_smoothing);
for i_full = i_init+1:numel(v_in)-s_smoothing/2
    idx_span           = i_full+1-s_smoothing/2:i_full+s_smoothing/2;
    v_smoothed(i_full) = sum(v_in(idx_span)) / s_smoothing;
    % v_smoothed(i_full) = mean(v_in(idx_span));
end
for i_end = i_full+1:numel(v_in)-1
    % Decreasing number of data points available
    diff2end = numel(v_in)-i_end;
    idx_v    = i_end-diff2end:i_end+diff2end;
    s_span   = numel(idx_v);
    v_smoothed(i_end) = sum(v_in(idx_v)) / s_span;
    % v_smoothed(i_end) = mean(v_in(idx_v));
end
v_smoothed(size_in) = v_in(end);

if size_in ~= numel(v_smoothed) || any(isnan(v_smoothed))
    error('Moving window size seems to be wrong')
end

end


