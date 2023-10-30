function MyRunAvg
%% Path to the preprocessed data
base_rootdir = '/Users/pesquisador/Desktop/servidor/MATLAB/ExportFolder/Pre-processed_data/';

%% Electrodes to be averaged. Each row is a cortical region.
ue = [9, 10, 11; 11, 18, 22; 108, 109, 102; 45, 46, 40; 75, 74, 82];

%% Quaternary or ternary conditions. Use 'qua' or 'ter' respectively.
cond = 'qua';

%% Run for each cortical region and each condition.
for ii = 1:5
    e = ue(ii, :);
    AvgElecs(base_rootdir,  e, cond);
end

cond = 'ter';
for ii = 1:5
    e = ue(ii, :);
    AvgElecs(base_rootdir,  e, cond);
end