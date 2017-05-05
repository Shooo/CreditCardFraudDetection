load('../data.mat');
load('../features.mat');


% Training model with linear regression to get weights
bhat = glmfit(MTrain(:,2:29),MTrain(:,31),'binomial');

% Training with candidate and good features
% bhat = glmfit(MTrain(:,cand_and_good),MTrain(:,31),'binomial');

% Training with strictly good features
% bhat = glmfit(MTrain(:,good),MTrain(:,31),'binomial');

% Attempting to run self made logistic regression function
% bhat = LR(test_x,test_y,1,10000);

% Testing our model with out trainig set
x = [ones(size(MTest,1),1) MTest(:,2:29)] * bhat;

% Testing with candidate and good features
% x = [ones(size(MTest,1),1) MTest(:,cand_and_good)] * bhat;

% Testing with strictly good features
% x = [ones(size(MTest,1),1) MTest(:,good)] * bhat;

% sigmoid function for output
hatProb = 1./( 1 +exp(-x));

% Set the threshold to 0.2 after testing for optimum threshold
haty = (hatProb >= 0.2);

% Calculating average error with training set
avgErr = mean(abs(haty - MTest(:,31)));
disp(avgErr);

% Calculating confusion matrix
labels = +haty;
C = confusionmat(test_y,labels);
disp(C);
acc = sum(diag(C)) ./ sum(C(:));
disp(acc);


% Calculating per class Recall and Precision
P = [];
R = [];

for i=1:2
    P(i) = C(i,i) ./ sum(C(:,i));
    R(i) = C(i,i) ./ sum(C(i,:));
end

% Display calculated per class Recall and Precision
for i=1:2
    fprintf('Precision for label %d: %d\n',(i-1),P(i));
end
for i=1:2
    fprintf('Recall for label %d: %d\n',(i-1),R(i));
end


% Testing different thresholds to see which gets minimum error

% i = 1;
% for tsh = 0.001:0.001:0.999
%     haty = (hatProb >= tsh);
%     avgErr(i) = mean(abs(haty - MTest(:,31)));
%     i = i + 1;
% end

% Plot change in threshold with error

% figure
% plot(0.021:0.001:0.999,avgErr(21:999),'r.');
% xlabel('threshold');
% ylabel('error');

% According to the plot, the best threshold should be 0.20