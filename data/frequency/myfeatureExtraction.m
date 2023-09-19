function [features] = myfeatureExtraction(sig)
    mu= mean(sig);
    v= var(sig);
    sk= skewness(sig);
    kr= kurtosis(sig);
    H= wentropy(sig,'shannon');
    P= mean(sig.^2);
    features= [mu;v;sk;kr;H;P];
end
