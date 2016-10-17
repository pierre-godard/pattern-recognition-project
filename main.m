%% Parameters
%%

% clear;clc;

words = {'call', 'delete', 'dial', 'hang_up', 'modify', 'next',....
    'previous', 'record', 'repeat', 'save', 'send'};
folder = 'data/';
ratio = 0.8;
nb_word = size(words, 2);


%% Load data
%%


[train_data, test_data, train_label, test_label, train_length, test_length] = extractAllData(words, folder, ratio);


%% Creation HMM
%%
% Nb of states for hmm per words
nb_class_word = [3 4 3 3 4 3 4 3 4 3 3]+2;


for i=1:nb_word
    hmm(i) = MakeLeftRightHMM(nb_class_word(i), GaussMixD, train_data{i}, train_length(i,:));
end


%almost working
for j=1:3
    offset = 0;
    for i=1:nb_word
        logP=logprob(hmm,test_data{i}(:,offset:offset + test_length(i,j)- 1));
        [~,s(i,j)] = max(logP);
        offset = offset + test_length(i,j);
    end
end



