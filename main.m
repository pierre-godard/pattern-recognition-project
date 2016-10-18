%% Parameters
%%
% clear;clc;

words = {'call', 'delete', 'dial', 'hang_up', 'modify', 'next',....
    'previous', 'record', 'repeat', 'save', 'send'};
folder = 'data/';
ratio = 0.8;
nb_word = size(words, 2);
nb_sample = 16;
threshold = round(ratio * nb_sample);



[train_data, test_data, train_label, test_label, train_length, test_length] = extractAllData(words, folder, ratio);


%% Creation HMM
%%
% Nb of states for hmm per words
nb_class_word = [3 4 3 3 4 3 4 3 4 3 3] + 2;


for i=1:nb_word
    hmm(i) = MakeLeftRightHMM(nb_class_word(i), GaussMixD, train_data{i}, train_length(i,:));
end

%% Test
%%

for j=1:threshold
    offset = 0;
    for i=1:nb_word
        logP = logprob(hmm,train_data{i} ... 
            (:,offset + 1:train_length(i,j) + offset));
        [m(i,j),s(i,j)] = max(logP);
    end
    offset = offset + train_length(i,j);
end

for j=1:(nb_sample - threshold)
    offset = 0;
    for i=1:nb_word
        logP = logprob(hmm,test_data{i} ... 
            (:,offset + 1:test_length(i,j) + offset));
        [m(i,j + threshold),s(i,j + threshold)] = max(logP);
    end
    offset = offset + test_length(i,j);
end

%% Confusion matrix 
%%
%
%
% conf(i,j) : answer i but solution j

conf = zeros(nb_word, nb_word);

for j=1:nb_sample
    for i=1:nb_word
        k = s(i,j);
        conf(k,i) = conf(k,i) + 1;
    end
end

figure; 
imagesc(conf);
colorbar;

