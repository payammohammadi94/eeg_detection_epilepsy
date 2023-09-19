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
[b1,a1]= butter(order,[fl fh]/ (fs/2), type);
% 
% band= [0.1 4 8 12 30
%        4  8 12 30 70];

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
    sigA= filtfilt(b1,a1,sigA);
    sigB= filtfilt(b1,a1,sigB);
    sigC= filtfilt(b1,a1,sigC);
    sigD= filtfilt(b1,a1,sigD);
    sigE= filtfilt(b1,a1,sigE);
    
    %% step 2: extract eeg rhythms in time domin
    for j= 1:size(band,2)
        % design bandpass filter
        wn= band(:,j)/ (fs/2);
        [b2,a2]= butter(3,wn,'bandpass');
        % apply designed bandpass filter
        sigA1= filtfilt(b2,a2,sigA);
        sigB1= filtfilt(b2,a2,sigB);
        sigC1= filtfilt(b2,a2,sigC);
        sigD1= filtfilt(b2,a2,sigD);
        sigE1= filtfilt(b2,a2,sigE);
    
        tpA(:,j) = myfeatureExtraction(sigA1);
        tpB(:,j) = myfeatureExtraction(sigB1);
        tpC(:,j) = myfeatureExtraction(sigC1);
        tpD(:,j) = myfeatureExtraction(sigD1);
        tpE(:,j) = myfeatureExtraction(sigE1);
    end
    %% step 3: feature extraction
    featuresA(:,i) = tpA(:);
    featuresB(:,i) = tpB(:);
    featuresC(:,i) = tpC(:);
    featuresD(:,i) = tpD(:);
    featuresE(:,i) = tpE(:);
    disp(['iteration: ',num2str(i)])
end
save Timefeatures2 featuresA featuresB featuresC featuresD featuresE




