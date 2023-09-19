clc
clear
close all
%% www.onlinebme.com
load A
fs=173.61;% sampling frequency
Nf=6;% number of features
Nt= size(A,2); % number of trials
featuresA=zeros(Nf,Nt);
% design stop filer
fl=49.9;
fh=50.1;
order= 3;
type= 'stop';
[b,a]= butter(order,[fl fh]/ (fs/2), type);
for i=1:Nt
    sig= A(:,i);
    %% step 1: denoising
    % apply notch (stop) filter
    sig= filtfilt(b,a,sig);
    %% step 2: feature extraction
    featuresA(:,i) = myfeatureExtraction(sig);
end





