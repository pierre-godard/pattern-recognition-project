%% -- Assignement 2 --
%
%
%


%% Read female audio file and plot it
[y,Fs]=audioread('female.wav');

x = 1:length(y);
x = x / Fs;

figure;
plot(x,y);
xlabel('Time (sec)');
ylabel('Amplitude');
title('Complete female sound'); 

timeLength = length(x)/Fs;

%% Plot sample of signal

duration = 0.02; % in sec
begin = 0.2; % in sec

wSize = duration*Fs;
wBegin = begin*Fs; 

figure;
plot(x(wBegin:wBegin + wSize), y(wBegin:wBegin + wSize));
xlabel('Time (sec)'); 
ylabel('Amplitude');
title('Sample female sound'); 

%% 