clc
clear
close all
%% www.onlinebme.com
load A
load B
load C
load D
load E


fs=173.61;% sampling frequency
Nf=6;% number of features
Nt= size(A,2); % number of trials
featuresA=zeros(Nf,Nt);
featuresB=zeros(Nf,Nt);
featuresC=zeros(Nf,Nt);
featuresD=zeros(Nf,Nt);
featuresE=zeros(Nf,Nt);

% design stop filer
fl=49.9;
fh=50.1;
order= 3;
type= 'stop';
[b,a]= butter(order,[fl fh]/ (fs/2), type);
for i=1:Nt
    sigA= A(:,i);
    sigB= B(:,i);
    sigC= C(:,i);
    sigD= D(:,i);
    sigE= E(:,i);
    %% step 1: denoising
    % apply notch (stop) filter
    sigA= filtfilt(b,a,sigA);
    sigB= filtfilt(b,a,sigB);
    sigC= filtfilt(b,a,sigC);
    sigD= filtfilt(b,a,sigD);
    sigE= filtfilt(b,a,sigE);
    %% step 2: feature extraction
    % step 2-1: fourier transform
    N= length(sigA);
    fx_a= fft(sigA,N);
    % step 2-2:  select half of coeficients
    fx_a= fx_a(1:round(N/2));
    %% step 2-3: calculate Magnitude of coeficients
    pxx_a= abs(fx_a);
    featuresA(:,i) = myfeatureExtraction(pxx_a);
    
    
    %     featuresA(:,i) = myfeatureExtraction(sigA);
    %     featuresB(:,i) = myfeatureExtraction(sigB);
    %     featuresC(:,i) = myfeatureExtraction(sigC);
    %     featuresD(:,i) = myfeatureExtraction(sigD);
    %     featuresE(:,i) = myfeatureExtraction(sigE);
    disp(['iteration: ',num2str(i)])
end
% save Freqfeatures1 featuresA featuresB featuresC featuresD featuresE




