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
% model = fitcsvm(train_x,train_y,'KernelFunction', 'rbf', 'KernelScale', 0.2);
model = fitcsvm(train_x(:,cand_and_good-1),train_y,'KernelFunction', 'rbf', 'KernelScale', 0.2);
% model = fitcsvm(train_x(:,good-1),train_y,'KernelFunction', 'rbf', 'KernelScale', 0.2);

% [label,score] = predict(model,test_x);
[label,score] = predict(model,test_x(:,cand_and_good-1));
% [label,score] = predict(model,test_x(:,good-1));

avgErr = mean(abs(label - MTest(:,31)));
disp(avgErr);

C = confusionmat(test_y, label);
disp(C);
acc = sum(diag(C)) ./ sum(C(:));
disp(acc);

P = [];
R = [];

for i=1:2
    P(i) = C(i,i) ./ sum(C(:,i));
    R(i) = C(i,i) ./ sum(C(i,:));
end

for i=1:2
    fprintf("Precision for label %d: %d\n",(i-1),P(i));
end
for i=1:2
    fprintf("Recall for label %d: %d\n",(i-1),R(i));
end
