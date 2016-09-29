%% -- Assignement 2 --
%
% TODO :
%  - Nettoyer le code (trop long)
%  - Verifier comment normaliser data MFCCs
%  - Se renseigner sur les dynamic features...
% 
% 
% !!!Check that 'sound.wav is in the current directory
%
% close all;clear; clc;


%% Read female audio file and plot it
[y,Fs]=audioread('female.wav');

x = 1:length(y);
x = x / Fs;

figure(1);
plot(x,y);
xlabel('Time (sec)');
ylabel('Amplitude');
title('Complete female sound'); 

timeLength = length(x)/Fs;

%% Plot sample of signal

duration = 0.02;    % in sec
begin1 = 0.2;        % in sec

wSize = duration*Fs;
wBegin = begin1*Fs; 

figure(2);
subplot(2,1,1);
plot(x(wBegin:wBegin + wSize), y(wBegin:wBegin + wSize));
xlabel('Time (sec)'); 
ylabel('Amplitude');
title('Sample female sound'); 

begin1 = 1.50;        % in sec
wBegin = begin1*Fs; 

subplot(2,1,2);
plot(x(wBegin:wBegin + wSize), y(wBegin:wBegin + wSize));
xlabel('Time (sec)'); 
ylabel('Amplitude');
title('Sample female sound'); 


%% FFT

winlength = 0.01;   % in sec
[spectgram,f,t]=GetSpeechFeatures(y,Fs,winlength);
spectgram = log10(spectgram);

figure(2);
imagesc(t,f,spectgram);
xlabel('Time (sec)'); 
ylabel('Amplitude');
title('Spectrograms'); 


%% Partial plot of the FFT

duration = 0.02;    % in sec
begin1 = 0.2;       % in sec
begin2 = 0.2;       % in sec

sSize = duration / 0.005;
sBegin1 = begin1 / 0.005; 
sBegin2 = begin2 / 0.005; 

figure(3);
subplot(1,2,1);
imagesc(t(sBegin1:sBegin1 + sSize),f,spectgram(:,sBegin1:sBegin1 + sSize));
xlabel('Time (sec)'); 
ylabel('Amplitude');
title('Spectrograms'); 
colorbar;

subplot(1,2,2);
imagesc(t(sBegin2:sBegin2 + sSize),f,spectgram(:,sBegin2:sBegin2 + sSize));
xlabel('Time (sec)'); 
ylabel('Amplitude');
title('Spectrograms'); 
colorbar;

%% Comuting all the data

% clear; clc; close all;

winlength = 0.03; % in sec
ncep = 13;


[ySong,FsSong]=audioread('music.wav');
[yFemale,FsFemale]=audioread('female.wav');
[yMale,FsMale]=audioread('male.wav');
[ySound,FsSound]=audioread('sound.wav');

figure(4);
plot(xSong,ySong);
xlabel('Time (sec)');
ylabel('Amplitude');
title('Complete music'); 


xSong = 1:length(ySong);
xSong = xSong / FsSong;
xFemale = 1:length(yFemale);
xFemale = xFemale / FsFemale;
xMale = 1:length(yMale);
xMale = xMale / FsMale;
xSound = 1:length(ySound);
xSound = xSound / FsSound;

[mfccsMale,spectgramMale,fMale,tMale] = GetSpeechFeatures(yMale,FsMale,winlength,ncep);
[mfccsFemale,spectgramFemale,fFemale,tFemale] = GetSpeechFeatures(yFemale,FsFemale,winlength,ncep);
[mfccsSong,spectgramSong,fSong,tSong] = GetSpeechFeatures(ySong,FsSong,winlength,ncep);
[mfccsSound,spectgramSound,fSound,tSound] = GetSpeechFeatures(ySong,FsSong,winlength,ncep);

spectgramMale = log10(spectgramMale);
spectgramFemale = log10(spectgramFemale);
spectgramSong = log10(spectgramSong);

mMale = mean(mfccsMale')';
stdMale = std(mfccsMale')';
mfccsMale = (mfccsMale - repmat(mMale,[1,size(mfccsMale,2)]) )./(repmat(stdMale,[1,size(mfccsMale,2)]));

mFemale = mean(mfccsFemale')';
stdFemale = std(mfccsFemale')';
mfccsFemale = (mfccsFemale - repmat(mFemale,[1,size(mfccsFemale,2)]) )./(repmat(stdFemale,[1,size(mfccsFemale,2)]));

mSong = mean(mfccsSong')';
stdSong = std(mfccsSong')';
mfccsSong = (mfccsSong - repmat(mSong,[1,size(mfccsSong,2)]) )./(repmat(stdSong,[1,size(mfccsSong,2)]));

mSound = mean(mfccsSound')';
stdSound = std(mfccsSound')';
mfccsSound = (mfccsSound - repmat(mSound,[1,size(mfccsSound,2)]) )./(repmat(stdSound,[1,size(mfccsSound,2)]));

corrSPECFemale = corr(spectgramFemale');
corrMFCCFemale = corr(mfccsFemale');
corrSPECMale = corr(spectgramMale');
corrMFCCMale = corr(mfccsMale');

corrMFCCSound = corr(mfccsSound');


%% MFCCs - Comparison between female and song (only the plots)

figure(5);
subplot(2,2,1);
imagesc(tFemale,fFemale,spectgramFemale);
xlabel('Time (sec)'); 
ylabel('Amplitude');
title('Spectrograms Female'); 
colorbar;
subplot(2,2,2);
imagesc(tSong,fSong,spectgramSong);
xlabel('Time (sec)'); 
ylabel('Amplitude');
title('Spectrograms Song'); 
colorbar;
subplot(2,2,3);
imagesc(mfccsFemale);
xlabel('Time (sec)'); 
ylabel('Amplitude');
title('Cepstrograms Female'); 
colorbar;
subplot(2,2,4);
imagesc(mfccsSong);
xlabel('Time (sec)'); 
ylabel('Amplitude');
title('Cepstrograms Song'); 
colorbar;


%% MFCCs - Compare female and male sound (only the plots)

figure(6);
subplot(2,2,1);
imagesc(tFemale,fFemale,spectgramFemale);
xlabel('Time (sec)'); 
ylabel('Amplitude');
title('Spectrograms Female'); 
colorbar;
subplot(2,2,2);
imagesc(tMale,fMale,spectgramMale);
xlabel('Time (sec)'); 
ylabel('Amplitude');
title('Spectrograms Male'); 
colorbar;
subplot(2,2,3);
imagesc(mfccsFemale);
xlabel('Time (sec)'); 
ylabel('Amplitude');
title('Cepstrograms Female'); 
colorbar;
subplot(2,2,4);
imagesc(mfccsMale);
xlabel('Time (sec)'); 
ylabel('Amplitude');
title('Cepstrograms Male'); 
colorbar;

%% Correlation matrix -- (Only the plots)

figure(7);
subplot(2,2,1);
colormap gray;
imagesc(corrSPECFemale);
xlabel('Spect'); 
ylabel('Spect');
title('Correlation Matrix Female');
axis square;
colorbar;
subplot(2,2,2);
imagesc(corrSPECMale);
xlabel('Spect'); 
ylabel('Spect');
title('Correlation Matrix Male');
axis square;
colorbar;
subplot(2,2,3);
imagesc(corrMFCCFemale);
xlabel('MFCCs'); 
ylabel('MFCCs');
title('Correlation Matrix Female');
axis square;
colorbar;
subplot(2,2,4);
imagesc(corrMFCCMale);
xlabel('MFCCs'); 
ylabel('MFCCs');
title('Correlation Matrix Male'); 
axis square;
colorbar;

%% Dynamic Features

dMale = diff(mfccsMale')';
ddMale = diff(dMale')';
dFemale = diff(mfccsFemale')';
ddFemale = diff(dFemale')';

dSound = diff(mfccsSound')';
ddSound = diff(dSound')';



% On enlève les derniers éléments car ils n'ont pas de dérivé
featMale = cat(1, mfccsMale(:,1:end-2), dMale(:,1:end-1), ddMale);
featFemale = cat(1, mfccsFemale(:,1:end-2), dFemale(:,1:end-1), ddFemale);
featSound = cat(1, mfccsSound(:,1:end-2), dSound(:,1:end-1), ddSound);

corrFeatMale = corr(featMale');
corrFeatFemale = corr(featFemale');
corrFeatSound = corr(featSound');

%% Plot final correlation matrix with all 39 features

figure(8);
subplot(1,2,1);
colormap gray;
imagesc(abs(corrFeatMale));
xlabel('Features'); 
ylabel('Features');
title('Correlation Matrix Male');
axis square;
colorbar;
subplot(1,2,2);
imagesc(abs(corrFeatFemale));
xlabel('Features'); 
ylabel('Features');
title('Correlation Matrix Female'); 
axis square;
colorbar;

