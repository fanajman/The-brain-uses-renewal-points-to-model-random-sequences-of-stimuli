function AvgElecs(base_rootdir,  e, cond)
%% Example of arguments
%base_rootdir = '/Users/pesquisador/Desktop/servidor/MATLAB/ExportFolder/Pre-processed_data/';
%e = [9, 10, 11];
%% Begin code
%if ~exist( base_destdir, 'dir' )
%    mkdir( base_destdir );
%end
%% Find files with the preprocessed data.
rootdir = fullfile( base_rootdir);
files = dir( fullfile( rootdir, '*.mat' ) );
caseuse = {'ter', 'qua'};

%% Free parameters. plac_sup is the length of the strings of the stimuli sequence minus one. Alpha is the quantile removed with the depth measure.
plac_sup = 2;
alpha = 0.1;



%% Make save folder
flname = 'E_';
for uee = 1:length(e)
   flname = [flname num2str(e(uee)) '_'];
end
flname = [flname cond];
mkdir(flname);

u_e = e;
for i = 1:length(files)

    
    %% Load Data
    load([base_rootdir files(i).name])
    eegi = zeros(length(data.Y_qua), 113, 793);
    e = u_e;
    %% Find if electrodes exist, remove NaN otherwise
    id = [];
    for re = 1:length(e)
        if any(strcmp(evnts, ['E' num2str(e(re))]))
            if strcmp(cond, caseuse{1})
                eegi(e(re), :, :) = data.Y_qua{2, find(strcmp(evnts, ['E' num2str(e(re))]))};
            elseif strcmp(cond, caseuse{2})
                eegi(e(re), :, :) = data.Y_ter{2, find(strcmp(evnts, ['E' num2str(e(re))]))};
            end
        else
            id = [id re];
        end
    end
    if id > 0
        e(id) = [];
    end
    if i == 1
        if size(eegi, 3) > 1
            eeg = zeros(size(squeeze(eegi(1, :, :))));
        else
            eeg = zeros(size(eegi));	
        end
    end
    %% Identify the strings which occur in the sequence
    if strcmp(cond, caseuse{1})
        [placement, ~] = Find_Placement(data.X_qua, 0:1:2, plac_sup+1);
    elseif strcmp(cond, caseuse{2})
        [placement, ~] = Find_Placement(data.X_ter, 0:1:2, plac_sup+1);
    end
    placement = [repmat(-1, 1, plac_sup) placement];
    %% Average the EEG signa;.
	for j = 1:length(e)
        if size(eegi, 3) > 1
			eeg = eeg + squeeze(eegi(e(j), :, :));
		else
			eeg = eeg + eegi;
        end
	end
	eeg = eeg/length(e);
    
    %% Remove the 0.1 quantile
    u_eeg = [];
	u_placement = [];
    for h = 1:max(placement)
		depths = [];
		posi = find(placement == h);
		for m = posi			
			depths = [depths FunctionDepth(m, eeg')];
		%for m = 1:length(posi)
		%	depths = [depths FunctionDepth(m, eeg(:, posi)')];
		end
		[~, who_e] = sort(depths);
		u_eeg = [u_eeg eeg(:, posi(who_e(1:round(end*(1-alpha)))))];
		u_placement = [u_placement placement(posi(who_e(1:round(end*(1-alpha)))))];
    end
    %% Save data.
    save([flname '/' files(i).name(1:3) '_' cond '_'], 'u_eeg', 'u_placement')
end