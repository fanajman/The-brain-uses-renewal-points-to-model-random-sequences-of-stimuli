# The brain uses renewal points to model random sequences of stimuli
 Full access to the code used in 'The brain uses renewal points to model random sequences of stimuli'

This folder contains all the EEG data and codes used in the analysis.

The codes starting with MyRun* are the codes used to generate the data files. 

The analysis use the data files at https://neuromat.numec.prp.usp.br/neuromatdb/EEGretrieving/. The folder raw_data contains he raw EEG dat files of each participant.

The first folder of the analysis is the Pre-processed_data. This folder contais the code used to pre-process the EEG data of the raw_data folder. This code uses the EEGLAB library for Octave/MATLAB to convert the files from the raw format to MATLAB?s .mat format. The second folder in the analysis is the Averaging_electrodes. This folder contains the codes used to average the pre-processed EEG data. 

The third folder is the DissimilarityMatrix. This folder contains the code used to retrieve the dissimilarity matrix from the averaged EEG data files in the third folder. This code also retrieves the summary dissimilarity matrix from each folder in Averaging_electrodes.

The final folder is the ClusteringByLaw. This folder contains one .R file which retrieves a dendrogram from each summary dissimilarity matrix in the third folder.

 These files are subject of changes in the documentation. More info please contact fanajman@gmail.com.