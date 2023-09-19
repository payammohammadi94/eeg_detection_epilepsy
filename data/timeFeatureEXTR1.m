clc
clear
close all
%% www.onlinebme.com
load A
fs=173.61;% sampling frequency
Nf=6;% number of features
Nt= size(A,2); % number of trials
featuresA=zeros(Nf,Nt);
for i=1:Nt
    sig= A(:,i);
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
    
    featuresA(:,i)= [mu;v;sk;kr;H;P];
end





