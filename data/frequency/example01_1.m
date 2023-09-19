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
hold on
%% step 5: determine coeficients of delta rhythms
band= [0.1,4,8,12,30;
         4,8,12,30,70];
name= {'Delta','Theta', 'Alpha','Beta','Gamma'};
for j=1:size(band,2)
    fl= band(1,j);
    fh= band(2,j);
    indx= find(rf>= fl & rf<=fh);
    stem(rf(indx),fx(indx),'linewidth',1,'marker','none')
    xpos=rf(indx(1));
    ypos= max(fx(indx));
    text(xpos,ypos,name{j},'fontsize',20)
    drawnow
end




