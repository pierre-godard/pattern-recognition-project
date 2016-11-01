%
%  Pattern Recognition (EQ2340) - Assignment 2.2 (Speech Recognition)
%  Code authors:
%    Corentin Abgrall
%    Pierre Godard
%
%% A.2.2 - Sound Signals
%%
% Open the samples
[sampleFemale, sampleRateFemale] = audioread('female.wav');
[sampleMusic, sampleRateMusic] = audioread('music.wav');
[sampleMale, sampleRateMale] = audioread('male.wav');

%%
% Play a sample
%sound(sampleFemale, sampleRateFemale);
%sound(sampleMusic, sampleRateMusic);
%sound(sampleMale, sampleRateMale);

%%
% Plot the female speech signal
time = (1:length(sampleFemale))/sampleRateFemale;
figure;
    plot(time, sampleFemale);
    xlabel('Time (in seconds)');
    ylabel('Amplitude');
    title('Female speech signal');

%%
% Plot the music signal
time = (1:length(sampleMusic))/sampleRateMusic;
figure;
    plot(time, sampleMusic);
    xlabel('Time (in seconds)');
    ylabel('Amplitude');
    title('Music signal');

%% A.2.2 - The Fourier Transform
%%
% Get the signals spectrograms
windowLength = 0.03; % in seconds
%
[spectrogramFemale, frequenciesFemale, timesFemale] = GetSpeechFeatures(sampleFemale, sampleRateFemale, windowLength);
[spectrogramMusic, frequenciesMusic, timesMusic] = GetSpeechFeatures(sampleMusic, sampleRateMusic, windowLength);
[spectrogramMale, frequenciesMale, timesMale] = GetSpeechFeatures(sampleMale, sampleRateMale, windowLength);

%%
% Plot the female speech signal features
figure;
    imagesc(timesFemale, frequenciesFemale, log10(spectrogramFemale));
    colormap winter;
    colorbar;
    xlabel('Time (in seconds)'); 
    ylabel('Frequency (in hertz)');
    ylim([0 5000]);
    title('Female speech signal logarithmic spectrogram'); 

%%
% Plot the music signal features
figure;
    imagesc(timesMusic, frequenciesMusic, log10(spectrogramMusic));
    colormap winter;
    colorbar;
    xlabel('Time (in seconds)'); 
    ylabel('Frequency (in hertz)');
    ylim([0 5000]);
    title('Music signal logarithmic spectrogram'); 

%%
% Subplot one region corresponding to an unvoiced sound and one region
% corresponding to a voiced sound in the female speech spectrogram.
range = 0.04; % in seconds
startUnvoicedSound = 0.2; % in seconds
startVoicedSound = 0.3; % in seconds
%
endUnvoicedSound = range + startUnvoicedSound;
endVoicedSound = range + startVoicedSound;
time = (1:length(sampleFemale))/sampleRateFemale;
figure;
    subplot(2, 2, 1);
        imagesc(timesFemale, frequenciesFemale/1000, log10(spectrogramFemale));
        xlim([startUnvoicedSound endUnvoicedSound]);
        colormap winter;
        colorbar;
        xlabel('Time (in seconds)'); 
        ylabel('Frequency (in hertz)');
        title('(a) logarithmic spectogram in an unvoiced sound region'); 
    subplot(2, 2, 2);
        imagesc(timesFemale, frequenciesFemale/1000, log10(spectrogramFemale));
        xlim([startVoicedSound endVoicedSound]);
        colormap winter;
        colorbar;
        xlabel('Time (in seconds)'); 
        ylabel('Frequency (in hertz)');
        title('(b) logarithmic spectogram in a voiced sound region');
    subplot(2, 2, 3);
        plot(time, sampleFemale);
        xlim([startUnvoicedSound endUnvoicedSound]);
        xlabel('Time (in seconds)');
        ylabel('Amplitude');
        title('(c) signal in an unvoiced sound region');
    subplot(2, 2, 4);
        plot(time, sampleFemale);
        xlim([startVoicedSound endVoicedSound]);
        xlabel('Time (in seconds)');
        ylabel('Amplitude');
        title('(d) signal in an voiced sound region');
        
    axes('Position',[0 0 1 1],'Xlim',[0 1],'Ylim',[0 1],'Box','off','Visible','off','Units','normalized', 'clipping' , 'off');
    text(0.5, 1,'\bf Female speech signal zooms','HorizontalAlignment','center','VerticalAlignment', 'top', 'FontSize', 12);

%% A.2.2 - MFCCs (Mel Frequency Cepstrum Coefficients)
%%
% Get the signals spectrograms and cepstrograms
windowLength = 0.03; % in seconds
numberCepstralCoefficients = 13; % including the zeroth coefficient
%
[mfccsFemale, spectrogramFemale, frequenciesFemale, timesFemale] = GetSpeechFeatures(sampleFemale, sampleRateFemale, windowLength, numberCepstralCoefficients);
[mfccsMusic, spectrogramMusic, frequenciesMusic, timesMusic] = GetSpeechFeatures(sampleMusic, sampleRateMusic, windowLength, numberCepstralCoefficients);
[mfccsMale, spectrogramMale, frequenciesMale, timesMale] = GetSpeechFeatures(sampleMale, sampleRateMale, windowLength, numberCepstralCoefficients);

%%
% Normalize the cepstrograms
mfccs = mfccsFemale;
numberCoefficients = size(mfccs,2);
means = repmat(mean(mfccs, 2), 1, numberCoefficients);
stds = repmat(std(mfccs, 0, 2), 1, numberCoefficients);
mfccsFemale = (mfccs - means)./ stds;
%
mfccs = mfccsMusic;
numberCoefficients = size(mfccs,2);
means = repmat(mean(mfccs, 2), 1, numberCoefficients);
stds = repmat(std(mfccs, 0, 2), 1, numberCoefficients);
mfccsMusic = (mfccs - means)./ stds;
%
mfccs = mfccsMale;
numberCoefficients = size(mfccs,2);
means = repmat(mean(mfccs, 2), 1, numberCoefficients);
stds = repmat(std(mfccs, 0, 2), 1, numberCoefficients);
mfccsMale = (mfccs - means)./ stds;

%%
% Plot side by side the spectrogram and the cepstrogram of the female 
% speech signal.
figure;
    subplot(1, 2, 1);
        imagesc(timesFemale, frequenciesFemale, log10(spectrogramFemale));
        colormap winter;
        colorbar;
        xlabel('Time (in seconds)'); 
        ylabel('Frequency (in hertz)');
        title('(a) logarithmic spectrogram');
    subplot(1, 2, 2);
        imagesc(timesFemale, 0:size(mfccsFemale, 1)-1, mfccsFemale);
        colormap winter;
        colorbar;
        xlabel('Time (in seconds)');
        ylabel('Coefficients');
        title('(b) cepstrogram'); 
    axes('Position',[0 0 1 1],'Xlim',[0 1],'Ylim',[0 1],'Box','off','Visible','off','Units','normalized', 'clipping' , 'off');
    text(0.5, 1,'\bf Comparison of the spectrogram and the cepstrogram of the female speech signal','HorizontalAlignment','center','VerticalAlignment', 'top', 'FontSize', 12);

%%
% Plot side by side the spectrogram and the cepstrogram of the music
% signal.
figure;
    subplot(1, 2, 1);
        imagesc(timesMusic, frequenciesMusic, log10(spectrogramMusic));
        colormap winter;
        colorbar;
        xlabel('Time (in seconds)'); 
        ylabel('Frequency (in hertz)');
        title('(a) logarithmic spectrogram');
    subplot(1, 2, 2);
        imagesc(timesMusic, 0:size(mfccsMusic, 1)-1, mfccsMusic);
        colormap winter;
        colorbar;
        xlabel('Time (in seconds)'); 
        ylabel('Coefficients');
        title('(b) cepstrogram'); 
    axes('Position',[0 0 1 1],'Xlim',[0 1],'Ylim',[0 1],'Box','off','Visible','off','Units','normalized', 'clipping' , 'off');
    text(0.5, 1,'\bf Comparison of the spectrogram and the cepstrogram of the music signal','HorizontalAlignment','center','VerticalAlignment', 'top', 'FontSize', 12);

%%
% Plot side by side the spectrograms of the female speech signal and the
% man speech signal.
figure;
    subplot(1, 2, 1);
        imagesc(timesFemale, frequenciesFemale, log10(spectrogramFemale));
        colormap winter;
        colorbar;
        xlabel('Time (in seconds)'); 
        ylabel('Frequency (in hertz)');
        title('(a) of the female speech signal');
    subplot(1, 2, 2);
        imagesc(timesMale, frequenciesMale, log10(spectrogramMale));
        colormap winter;
        colorbar;
        xlabel('Time (in seconds)'); 
        ylabel('Frequency (in hertz)');
        title('(b) of the male speech signal');
    axes('Position',[0 0 1 1],'Xlim',[0 1],'Ylim',[0 1],'Box','off','Visible','off','Units','normalized', 'clipping' , 'off');
    text(0.5, 1,'\bf Comparison of the logarithmic spectrograms','HorizontalAlignment','center','VerticalAlignment', 'top', 'FontSize', 12);

%%
% Plot side by side the cepstrograms of the female speech signal and the
% man speech signal.
figure;
    subplot(1, 2, 1);
        imagesc(timesFemale, 0:size(mfccsFemale, 1)-1, mfccsFemale);
        colormap winter;
        colorbar;
        xlabel('Time (in seconds)'); 
        ylabel('Coefficients');
        title('(a) of the female speech signal');
    subplot(1, 2, 2);
        imagesc(timesMale, 0:size(mfccsMale, 1)-1, mfccsMale);
        colormap winter;
        colorbar;
        xlabel('Time (in seconds)'); 
        ylabel('Coefficients');
        title('(b) of the male speech signal');
    axes('Position',[0 0 1 1],'Xlim',[0 1],'Ylim',[0 1],'Box','off','Visible','off','Units','normalized', 'clipping' , 'off');
    text(0.5, 1,'\bf Comparison of the cepstrograms','HorizontalAlignment','center','VerticalAlignment', 'top', 'FontSize', 12);

%%
% Compute the correlations between the different coefficients.
corrSpectrogramFemale = corr(log10(spectrogramFemale)');
corrMfccsFemale = corr(mfccsFemale');
corrSpectrogramMusic = corr(log10(spectrogramMusic)');
corrMfccsMusic = corr(mfccsMusic');
corrSpectrogramMale = corr(log10(spectrogramMale)');
corrMfccsMale = corr(mfccsMale');

%%
% Plot side by side the correlations of the spectogram and the cepstrogram
% coefficients of the female speech signal.
figure;
    subplot(1, 2, 1);
        imagesc(abs(corrSpectrogramFemale));
        colormap gray;
        colorbar;
        axis equal tight;
        xlabel('Coefficients'); 
        ylabel('Coefficients');
        title('(a) of the logarithmic spectrogram coefficients');
    subplot(1, 2, 2);
        imagesc(abs(corrMfccsFemale));
        colormap gray;
        colorbar;
        axis equal tight;
        xlabel('Coefficients'); 
        ylabel('Coefficients');
        title('(b) of the cepstrogram coefficients');
    axes('Position',[0 0 1 1],'Xlim',[0 1],'Ylim',[0 1],'Box','off','Visible','off','Units','normalized', 'clipping' , 'off');
    text(0.5, 1,'\bf Comparison of the female speech signal correlations','HorizontalAlignment','center','VerticalAlignment', 'top', 'FontSize', 12);

%%
% Plot side by side the correlations of the spectogram and the cepstrogram
% coefficients of the music signal.
figure;
    subplot(1, 2, 1);
        imagesc(abs(corrSpectrogramMusic));
        colormap gray;
        colorbar;
        axis equal tight;
        xlabel('Coefficients'); 
        ylabel('Coefficients');
        title('(a) of the logarithmic spectrogram coefficients');
    subplot(1, 2, 2);
        imagesc(abs(corrMfccsMusic));
        colormap gray;
        colorbar;
        axis equal tight;
        xlabel('Coefficients'); 
        ylabel('Coefficients');
        title('(b) of the cepstrogram coefficients');
    axes('Position',[0 0 1 1],'Xlim',[0 1],'Ylim',[0 1],'Box','off','Visible','off','Units','normalized', 'clipping' , 'off');
    text(0.5, 1,'\bf Comparison of the music signal correlations','HorizontalAlignment','center','VerticalAlignment', 'top', 'FontSize', 12);

%% A.2.2 - Dynamic Features
%%
% Compute the dynamic features and add it to the static ones
windowLength = 0.03; % in seconds
numberCepstralCoefficients = 13; % including the zeroth coefficient
%
featFemale = FeaturesExtraction(sampleFemale, sampleRateFemale, windowLength, numberCepstralCoefficients);
featMusic = FeaturesExtraction(sampleFemale, sampleRateFemale, windowLength, numberCepstralCoefficients);
featMale = FeaturesExtraction(sampleFemale, sampleRateFemale, windowLength, numberCepstralCoefficients);
