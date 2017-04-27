% Training model with linear regression to get weights
bhat = glmfit(MTrain(:,2:29),MTrain(:,31),'binomial');

% Testing our model with out trainig set
x = [ones(size(MTest,1),1) MTest(:,2:29)] * bhat;
hatProb = 1./( 1 +exp(-x));
haty = (hatProb >= 0.5);
avgErr = mean(abs(haty - MTest(:,31)));
disp(avgErr);


% Testing different thresholds to see which gets minimum error

i = 1;
for tsh = 0.001:0.001:0.999
    haty = (hatProb >= tsh);
    avgErr(i) = mean(abs(haty - MTest(:,31)));
    i = i + 1;
end

plot(0.021:0.001:0.999,avgErr(21:999),'r.');
% According to the plot, the best threshold should be 0.35