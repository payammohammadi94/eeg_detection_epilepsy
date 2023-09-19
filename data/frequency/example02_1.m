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
    %% step 2: feature extraction in frequency domain
    % step 2-1: fourier transform
    N= length(sigA);
    fx_a= fft(sigA,N);
    fx_b= fft(sigB,N);
    fx_c= fft(sigC,N);
    fx_d= fft(sigD,N);
    fx_e= fft(sigE,N);
    
    pxx_a= abs(fx_a(1:round(N/2)));
    pxx_b= abs(fx_b(1:round(N/2)));
    pxx_c= abs(fx_c(1:round(N/2)));
    pxx_d= abs(fx_d(1:round(N/2)));
    pxx_e= abs(fx_e(1:round(N/2)));
    
    featuresA(:,i) = myfeatureExtraction(pxx_a);
    featuresB(:,i) = myfeatureExtraction(pxx_b);
    featuresC(:,i) = myfeatureExtraction(pxx_c);
    featuresD(:,i) = myfeatureExtraction(pxx_d);
    featuresE(:,i) = myfeatureExtraction(pxx_e);
    disp(['iteration: ',num2str(i)])
end
save Freqfeatures1 featuresA featuresB featuresC featuresD featuresE




