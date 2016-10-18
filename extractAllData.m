function [feature] = extractAllData(words, folder)

%% Parameters of the dataset

underscore = '_';
format = '.wav';


nb_word = size(words, 2);
nb_sample = 16;

%% Extracting all data
%%
% feature = nbwords * nbsample * {mfccscoef * length}

windowLength = 0.03;
numberCoefficients = 13;

feature = cell(nb_word, nb_sample);
% label = zeros(nb_word, nb_sample);
for i = 1:nb_word
    for j = 1:nb_sample
        filename = strcat(folder, words{i}, underscore, int2str(j), format);
        [sample, sampleRate] = audioread(filename);
        features_temp = FeaturesExtraction(sample, sampleRate, windowLength, numberCoefficients);
        feature{i,j} = features_temp;
%         label(i,j) = i*100 + j;
    end
end



end
