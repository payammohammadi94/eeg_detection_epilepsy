clc
clear
close all
%% www.onlinebme.com
load('A.mat')
fs=173.61;
sig= A(:,1)';
plot(sig,'b','linewidth',1)
grid on
grid minor
%% step 1: fourier transform
N= length(sig);
fx= fft(sig,N);
figure
stem(abs(fx),'b','linewidth',1,'marker','none')
grid on
grid minor
%% step 2: select half of coeficients
fx= fx(1: round(N/2));
figure
stem(abs(fx),'b','linewidth',1,'marker','none')
grid on
grid minor
%% step 3: calculate Magnitude of coeficients
fx= abs(fx);
%% step 4: calculate frequency resolution
rf= linspace(0,fs/2,round(N/2));
figure
stem(rf,fx,'b','linewidth',1,'marker','none')
grid on
grid minor
%% step 5: determine coeficients of delta rhythms
fl= 0.1;
fh= 4;
indx= find(rf>= fl & rf<=fh);
hold on
stem(rf(indx),fx(indx),'r','linewidth',1,'marker','none')

%% determine coeficients of Theta rhythms
fl= 4;
fh= 8;
indx= find(rf>= fl & rf<=fh);
stem(rf(indx),fx(indx),'g','linewidth',1,'marker','none')
%% determine coeficients of alpha rhythms
fl= 8;
fh= 12;
indx= find(rf>= fl & rf<=fh);
hold on
stem(rf(indx),fx(indx),'c','linewidth',1,'marker','none')
%% determine coeficients of beta rhythms
fl= 12;
fh= 30;
indx= find(rf>= fl & rf<=fh);
hold on
stem(rf(indx),fx(indx),'y','linewidth',1,'marker','none')
%% determine coeficients of gamma rhythms
fl= 30;
fh= 70;
indx= find(rf>= fl & rf<=fh);
hold on
stem(rf(indx),fx(indx),'m','linewidth',1,'marker','none')

















