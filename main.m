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
% nb_class_word = [6 5 8 2 7 5 3 3 7 7 5]; % Celui là est fait avec
% logprob, c'est le plus sensé à mon avis
% nb_class_word = [11 17 14 20 20 14 20 20 17 10 14]; % Celui-là est fait
% avec 3 états par phonèmes
[measures, nb_class_word] = nbStatePerWord(shuffle(feature), 2, 4, 20, @testHmmProb);

% Questions:
% - Is there a better way to fix the threshold? (and to deal with nb_part?)
% - Can't we use more test data (from the training set of other hmms)?
% - Can't we optimize by not doing the computations once the threshold is
% reached?


%% Cross val
%%

nb_part = 4;
s = crossValidation(nb_part, shuffle(feature), nb_class_word);

%% Error rate
%%

nb_errors = s - repmat(1:nb_word, nb_sample, 1)' ~= 0;
error_rate = sum(sum(nb_errors)) / (nb_word * nb_sample);
error_rate_word = sum(nb_errors, 2) / nb_sample;

%% Confusion matrix 
%%
% Compute confusion matrix

conf = makeConfusionMatrix(s, nb_word, nb_sample);

%%
% Plot confusion matrix

figure; 
imagesc(conf);
colorbar;
set(gca,'XTick',1:nb_word,'XTicklabel',words,'YTick',1:nb_word,'YTicklabel',words);
ylabel('Found word');
xlabel('Spoken word');

