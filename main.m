%% TODO
%% 
% Function to determine nb_class_word : intervalle [min, max] for each words and  ouputs the
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
featureShuffled = shuffle(feature);
[data, data_length] = convertToRightDataForm(featureShuffled);


%% Determination of number of states for each HMM
%% 

% Need to implement : nbStatePerWord
nb_class_word = [3 4 3 3 4 3 4 3 4 3 3] + 2;
% nb_class_word_pronostic = [3 4 3 3 4 3 4 3 4 3 3];
% nb_class_word = nbStatePerWord(nb_class_word_pronostic, data, data_length);


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

