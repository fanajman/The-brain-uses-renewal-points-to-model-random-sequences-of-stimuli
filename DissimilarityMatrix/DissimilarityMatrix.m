function DissimilarityMatrix(base_rootdir)
%% Example of an argument
%base_rootdir = '/Users/pesquisador/Desktop/servidor/MATLAB/ExportFolder/Averaging_electrodes/';

%% Find all the folders with the averaged EEG data.
folders = dir(fullfile(base_rootdir));
flds = [folders.isdir];
folders = folders(flds);
folders = folders(3:end);


%% Paramenters. seedBrown is the seed used to generate the random directions. If seedBrown = 0, will not fix a seed.
%% numDirecs is the number of random directions used.
%% smplRate is the length of an EEG segment.
%% cutPoint is the criterion to select a partition from the dendrogram retrieved from a participant's EEG data.
seedBrown = 1;
numDirecs = 5000;
smplRate = 113;
cutPoint = 276;



%% Generate random directions
browns = CreateBrown(numDirecs, smplRate, seedBrown);

for fol = 1:length(folders)
    %% Make save folder.
    foldername = folders(fol).name;
    mkdir(foldername);



    %% Find the EEG data files.
    rootdir = fullfile( [base_rootdir foldername]);
    files = dir( fullfile( rootdir, '*.mat' ) );






    for i = 1:length(files)
        load([base_rootdir foldername '/' files(i).name])
        %% Alocate memory for the results.
        if i == 1
           mat_u = zeros(length(files), max(u_placement), max(u_placement));
           retmat = zeros(max(u_placement));
        end
        %% Create the dissimilarity matrix.
        for k = 1:max(u_placement)
            for l = k+1:max(u_placement)
                %disp(['Par_' num2str(i) '_w1_' num2str(k) '_w2_' num2str(l)])
                %% This function give the dissimilarity between two sets of funcional data.
                r = TestProjs(u_eeg, browns, u_placement, k, l, 0.05);
                mat_u(i, k, l) = sum(r(3, :));
                mat_u(i, l, k) = mat_u(i, k, l);
                %keyboard
                %sv_all{i, k, l} = r;
            end
        end
        %keyboard
        %% Save dissimilarity matrix.
        save([foldername '/DistMat_Par_' files(i).name], 'mat_u')
        %% Add the information of the individual partition to the summary dissimilarity matrix.
        lin = linkage(squishMat(squeeze(mat_u(i, 1:max(u_placement), 1:max(u_placement)))), 'complet');
        rm = HierData(lin, 2, cutPoint);
        retmat = retmat+rm;
    end
    %% Save summary dissimilarity matrix.
    save([foldername '/SummaryDendrogram'], 'retmat')
end
 