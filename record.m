%% Parameters
%%

words = {'call', 'delete', 'dial', 'hang_up', 'modify', 'next',....
    'previous', 'record', 'repeat', 'save', 'send'};
folder = 'data/';
nb_word = size(words, 2);


%% Recording
%%


sampleRate = 22050;
recObj = audiorecorder(sampleRate, 16, 1);

display('You have 3 seconds to record starting when you press Enter');
pause;

display('Start recording...');
recordblocking(recObj, 3);
display('done');


%% Play the recorded sound
%%

% play(recObj);


%% Get the data
%%

windowLength = 0.03;
numberCoefficients = 13;
y = cell(1,1);
y{1,1} = FeaturesExtraction(getaudiodata(recObj), sampleRate, windowLength, numberCoefficients);
y_length = size(y{1},2);

%% Train the HMM
%%

nb_class_word = [3 4 3 3 4 3 4 3 4 3 3] + 2;
% nb_class_word_pronostic = [3 4 3 3 4 3 4 3 4 3 3];
% nb_class_word = nbStatePerWord(nb_class_word_pronostic, data, data_length);

feature = extractAllData(words, folder);
featureShuffled = shuffle(feature);
[data, data_length] = convertToRightForm(featureShuffled);

hmmArray = trainAllHmm(nb_class_word, data, data_length);

%% Prediction
%%

s = testHmm(hmmArray, y, y_length);

display(['You said : ',  words{s}]);
