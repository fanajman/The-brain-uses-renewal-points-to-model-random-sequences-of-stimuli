function MyRunPreProc
%% Path to the raw data
base_rootdir = '/Users/pesquisador/Desktop/servidor/MATLAB/ExportFolder/raw_data';
%% Pre-processing. This code was made by Aline/Noslen. The only modification I have made to the code was to pre-process the EEG recorded in all electrodes.
%% Aline/Noslen only pre-processed the EEG of the 18 electrodes considered in Hernandez et al. 2021.
EEG_Processing(base_rootdir)