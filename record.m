%% Parameters
%%

words = {'call', 'delete', 'dial', 'hang_up', 'modify', 'next',....
    'previous', 'record', 'repeat', 'save', 'send'};
folder = 'data/';
nb_word = size(words, 2);

%% Train the HMM
%%

nb_class_word = [3 4 3 3 4 3 4 3 4 3 3] + 4;
% nb_class_word_pronostic = [3 4 3 3 4 3 4 3 4 3 3];
% nb_class_word = nbStatePerWord(nb_class_word_pronostic, data, data_length);

feature = extractAllData(words, folder);
featureShuffled = shuffle(feature);
[data, data_length] = convertToRightForm(featureShuffled);

hmmArray = trainAllHmm(nb_class_word, data, data_length, GaussMixD);

%% Recognise
%%

% Record
sampleRate = 22050;
recObj = audiorecorder(sampleRate, 16, 1);

display('You have 3 seconds to record starting when you press Enter');
pause;

display('Start recording...');
recordblocking(recObj, 3);
display('done');

% Get the feature vector
windowLength = 0.03;
numberCoefficients = 13;
y = cell(1,1);
y{1,1} = FeaturesExtraction(getaudiodata(recObj), sampleRate, windowLength, numberCoefficients);
y_length = size(y{1},2);

% Identify the word
s = testHmm(hmmArray, y);
display(['You said : ',  words{s}]);

%% Play the recorded sound
%%

play(recObj);
