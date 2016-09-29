%% -- Assignement 2 --
%
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

%% MFCCs



