clc
clear 
close all
%% www.onlinebme.com
load A
sig= A(:,1);
fs=173.61;% sampling frequency
% plot eeg in time domain
% figure
% plot(sig,'b','linewidth',1)
% grid on
% grid minor
% title('eeg in time domain')
%% step 1: denoising
% design stop filer
fl=49.9;
fh=50.1;
order= 3;
type= 'stop';
[b,a]= butter(order,[fl fh]/ (fs/2), type);
% apply notch (stop) filter
sig= filtfilt(b,a,sig);
%% step 2: feature extraction
mu= mean(sig);
v= var(sig);
sk= skewness(sig);
kr= kurtosis(sig);
H= wentropy(sig,'shannon');
P= mean(sig.^2);

features= [mu;v;sk;kr;H;P]





