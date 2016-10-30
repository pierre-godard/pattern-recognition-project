%% TODO
%% 
% Function to determine nb_class_word : intervalle [min, max] for each words and ouputs the
% best value/HMM
% Script pour record
% Save/Load hmm functions

%% Parameters
%%

words = {'call', 'delete', 'dial', 'hang_up', 'modify', 'next',....
    'previous', 'record', 'repeat', 'save', 'send'};
folder = 'data/';
nb_word = size(words, 2);
nb_sample = 16;

%% Load data
%%

feature = extractAllData(words, folder);
%featureShuffled = shuffle(feature);
%[data, data_length] = convertToRightForm(featureShuffled);


%% Determination of number of states for each HMM
%% 

% The nb_class_word variable returned the last time in ran the section
% (with a threshold=1.0).
% nb_class_word = [3 6 2 5 4 4 4 4 5 3 6];
nb_class_word = nbStatePerWord(shuffle(feature), 2, 7, 1.0, @testHmmProb);

% Questions:
% - Is there a better way to fix the threshold? (and to deal with nb_part?)
% - Can't we use more test data (from the training set of other hmms)?
% - Can't we optimize by not doing the computations once the threshold is
% reached?


%% Cross val
%%

nb_part = 4;
s = crossValidation(nb_part, shuffle(feature), nb_class_word);


%% Confusion matrix 
%%

conf = makeConfusionMatrix(s, nb_word, nb_sample);


%% Plot confusion matrix
%%

figure; 
imagesc(conf);
colorbar;

