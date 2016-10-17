function [train_data_temp, test_data_temp, train_label, test_label, train_length, test_length] ...
    = extractAllData(words, folder, ratio)

%% Parameters of the dataset

underscore = '_';
format = '.wav';


%ratio = 0.8; % = size of train dataset (=0.7 -> 70% of the whole dataset)
%onlyMFCC = true;

nb_word = size(words, 2);
nb_sample = 16;

%% Extracting all data
%%
% feature = nbwords * nbsample * {mfccscoef * length}

windowLength = 0.03;
numberCoefficients = 13;

feature = cell(nb_word, nb_sample);
label = zeros(nb_word, nb_sample);
for i = 1:nb_word
    for j = 1:nb_sample
        filename = strcat(folder, words{i}, underscore, int2str(j), format);
        [sample, sampleRate] = audioread(filename);
        features_temp = FeaturesExtraction(sample, sampleRate, windowLength, numberCoefficients);
        feature{i,j} = features_temp;
        label(i,j) = i*100 + j;
    end
end

%% Shuffle the dataset
%%

featureShuffled = cell(nb_word, nb_sample);
labelShuffled = zeros(nb_word, nb_sample);
for i=1:nb_word
    p = randperm(nb_sample);
    featureShuffled(i,:) = feature(i,p);
    labelShuffled(i,:) = label(i,p);
end

%% Split the dataset
%%

threshold = round(ratio * nb_sample);

train_data = featureShuffled(:,1:threshold);
train_label = labelShuffled(:,1:threshold);
test_data = featureShuffled(:,threshold+1:end);
test_label = labelShuffled(:,threshold+1:end);

%% Convert to proper form
%%

train_length = zeros(nb_word,threshold);
test_length = zeros(nb_word,nb_sample - threshold);

train_data_temp = cell(nb_word,1);
test_data_temp = cell(nb_word,1);

for i=1:nb_word
    word_temp = [];
    for j=1:threshold
        word_temp = cat(2,word_temp, featureShuffled{i,j});
        train_length(i,j) = size(featureShuffled{i,j},2);
    end
    train_data_temp{i} = word_temp;
    word_temp = [];
    for j=threshold+1:nb_sample
        word_temp = cat(2,word_temp, featureShuffled{i,j});
        test_length(i,j - threshold) = size(featureShuffled{i,j},2);
    end
    test_data_temp{i} = word_temp;
    
end




end
