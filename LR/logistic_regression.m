load('../data.mat');
load('../features.mat');
% Training model with linear regression to get weights
bhat = glmfit(MTrain(:,2:30),MTrain(:,31),'binomial');
%bhat = glmfit(MTrain(:,cand_and_good),MTrain(:,31),'binomial');
% bhat = glmfit(MTrain(:,good),MTrain(:,31),'binomial');

% bhat = LR(test_x,test_y,1,1000000);

% Testing our model with out trainig set
x = [ones(size(MTest,1),1) MTest(:,2:30)] * bhat;
%x = [ones(size(MTest,1),1) MTest(:,cand_and_good)] * bhat;
% x = [ones(size(MTest,1),1) MTest(:,good)] * bhat;
hatProb = 1./( 1 +exp(-x));
haty = (hatProb >= 0.5);
avgErr = mean(abs(haty - MTest(:,31)));
disp(avgErr);

labels = +haty;
C = confusionmat(test_y,labels);
disp(C);
C = confusionmat(test_y, labels);
acc = sum(diag(C)) ./ sum(C(:));
disp(acc);

P = [];
R = [];

for i=1:2
    P(i) = C(i,i) ./ sum(C(:,i));
    R(i) = C(i,i) ./ sum(C(i,:));
end

for i=1:2
    fprintf("Precision for label %d: %d\n",i,P(i));
end
for i=1:2
    fprintf("Recall for label %d: %d\n",i,R(i));
end


% Testing different thresholds to see which gets minimum error

i = 1;
for tsh = 0.001:0.001:0.999
    haty = (hatProb >= tsh);
    avgErr(i) = mean(abs(haty - MTest(:,31)));
    i = i + 1;
end

plot(0.021:0.001:0.999,avgErr(21:999),'r.');
% According to the plot, the best threshold should be 0.35