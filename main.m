%% Parameters

% clear;clc;

words = {'call', 'delete', 'dial', 'hang_up', 'modify', 'next',....
    'previous', 'record', 'repeat', 'save', 'send'};
folder = 'data/';
ratio = 0.8;
nb_word = size(words, 2);



%% Load data

[train_data, test_data, train_label, test_label] = extractAllData(words, folder, ratio);

%% Creation HMM

% Nb of states for hmm per words
nb_class_word = [3 4 3 3 4 3 4 3 4 3 3];


hmm = 
for i=1:nb_word
    hmm = MakeLeftRightHMM(nStates,pD,obsData,lData);
end