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
Nf=30;% number of features
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
%%
band= [0.1,4,8,12,30;
         4,8,12,30,70]; 
 
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
    % step 2-5: fourier transform
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
    
    % calculate frequency resolution
    rf= linspace(0,fs/2,round(N/2));
    for j=1:size(band,2)
        fl= band(1,j);
        fh= band(2,j);
        indx= find(rf>= fl & rf<fh);
        pxx_a1= pxx_a(indx);
        pxx_b1= pxx_b(indx);
        pxx_c1= pxx_c(indx);
        pxx_d1= pxx_d(indx);
        pxx_e1= pxx_e(indx);
        
        tpA(:,j) = myfeatureExtraction(pxx_a1);
        tpB(:,j) = myfeatureExtraction(pxx_b1);
        tpC(:,j) = myfeatureExtraction(pxx_c1);
        tpD(:,j) = myfeatureExtraction(pxx_d1);
        tpE(:,j) = myfeatureExtraction(pxx_e1);

    end  
    featuresA(:,i) = tpA(:);
    featuresB(:,i) = tpB(:);
    featuresC(:,i) = tpC(:);
    featuresD(:,i) = tpD(:);
    featuresE(:,i) = tpE(:);
    disp(['iteration: ',num2str(i)])
end
save Freqfeatures2 featuresA featuresB featuresC featuresD featuresE




