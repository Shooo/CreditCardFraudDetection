load('../data.mat');
load('../features.mat');


% Changing the Kernel Scale allows us to change levels of gamma

% Testing optimum value for gamma

% errors = [];
% for i=0.2:0.2:1.0
%     model = fitcsvm(train_x, train_y, 'KernelFunction', 'rbf', 'KernelScale', i);
%     [label,score] = predict(model,test_x);
%     avgErr = mean(abs(label - MTest(:,31)));
%     errors = [errors avgErr];
% end

% Plot change in gamma with error

% figure
% plot(0.2:0.2:1.0,errors);
% xlabel('gamma');
% ylabel('error');
% this figure, we can see 0.2 is optimum gamma for rbf

% linear
% fprintf('linear\n')
% model = fitcsvm(train_x, train_y, 'KernelFunction', 'linear');

% rbf
% fprintf('rbf\n')
% model = fitcsvm(train_x, train_y, 'KernelFunction', 'rbf', 'KernelScale', 0.2);

% polynomial
% fprintf('polynomial\n')
% model = fitcsvm(train_x,train_y,'KernelFunction','polynomial');


% testing different features:

% Training with all features
model = fitcsvm(train_x,train_y,'KernelFunction', 'rbf', 'KernelScale', 0.2);

% Training with candidate and good features
% model = fitcsvm(train_x(:,cand_and_good-1),train_y,'KernelFunction', 'rbf', 'KernelScale', 0.2);

% Training with strictly good features
% model = fitcsvm(train_x(:,good-1),train_y,'KernelFunction', 'rbf', 'KernelScale', 0.2);

% Testing with all features
[label,score] = predict(model,test_x);

% Testing with candidate and good features
% [label,score] = predict(model,test_x(:,cand_and_good-1));

% Testing with strictly good features
% [label,score] = predict(model,test_x(:,good-1));

% Calculate error rate
avgErr = mean(abs(label - MTest(:,31)));
disp(avgErr);

% Calculate confusion Matrix
C = confusionmat(test_y, label);
disp(C);
acc = sum(diag(C)) ./ sum(C(:));
disp(acc);

% Calculate per class Recall and Precision
P = [];
R = [];

for i=1:2
    P(i) = C(i,i) ./ sum(C(:,i));
    R(i) = C(i,i) ./ sum(C(i,:));
end

% Display per class Recall and Precision
for i=1:2
    fprintf('Precision for label %d: %d\n',(i-1),P(i));
end
for i=1:2
    fprintf('Recall for label %d: %d\n',(i-1),R(i));
end
