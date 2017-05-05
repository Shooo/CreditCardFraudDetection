load('../data.mat');
load('../features.mat');

% Layer set to single layer with 25 units after testing for optimum
net = patternnet(25);

% Learning rate set to 0.04 after testing for optimum
net.trainParam.lr = 0.04;

% testing different learning rates:

% a = [0.01 0.05 0.10 0.15 0.20];
% i = 1;
% for idx = 1:numel(a)
%     net.trainParam.lr = a(idx);
%     [net,tr] = train(net,train_x',train_y');
%     prob = net(test_x');
%     haty = (prob >= 0.5);
%     avgErr(i) = mean(abs(haty' - MTest(:,31)));
%     i = i + 1;
% end

% Plotting change in learning rate with corresponding error
% figure;
% plot(a,avgErr);
% xlabel('learning rate');
% ylabel('error');

% testing different number of units:
% net = patternnet(25);
% layers = [];
% i = 1;
% for idx = 1:10
%     layers = [10*idx];
%     net = patternnet(layers);
%     net.trainParam.lr = 0.04;
%     [net,tr] = train(net,train_x',train_y');
%     prob = net(test_x');
%     haty = (prob >= 0.5);
%     avgErr(i) = mean(abs(haty' - MTest(:,31)));
%     i = i + 1;
% end

% Plotting different units with error
% figure;
% plot(1:10,avgErr);
% xlabel('number of units');
% ylabel('error');


% Testing different layers:
% net = patternnet(25);
% layers = [];
% i = 1;
% for idx = 1:6
%     layers = [layers 25];
%     net = patternnet(layers);
%     net.trainParam.lr = 0.04;
%     [net,tr] = train(net,train_x',train_y');
%     prob = net(test_x');
%     haty = (prob >= 0.5);
%     avgErr(i) = mean(abs(haty' - MTest(:,31)));
%     i = i + 1;
% end

% Plotting different layers with error
% figure;
% plot(1:numel(layers),avgErr);
% xlabel('number of layers');
% ylabel('error');


% Train with all features
[net,tr] = train(net,train_x',train_y');

% Train with candidate and good features
% [net,tr] = train(net,train_x(:,cand_and_good-1)',train_y');

% Train with strictly good features
% [net,tr] = train(net,train_x(:,good-1)',train_y');


% Test with all features
prob = net(test_x');

% Test with candidate features and good features
% prob = net(test_x(:,cand_and_good - 1)');

% Test with strictly good features
% prob = net(test_x(:,good - 1)');


% Testing different thresholds to see which gets minimum error

% i = 1;
% for tsh = 0.001:0.001:0.999
%     haty = (prob >= tsh);
%     avgErr(i) = mean(abs(haty' - MTest(:,31)));
%     i = i + 1;
% end

% Plot different threshold with corresponding error
% figure
% plot(0.021:0.001:0.999,avgErr(21:999),'r.');
% xlabel('threshold');
% ylabel('error');

% According to the plot, the best threshold should be 0.05

% Threshold set to 0.5 after testing for optimum
labels = (prob >= 0.5);

labels = +labels;
labels = labels.';

% Calculating error rate
avgErr = mean(abs(labels - MTest(:,31)));
disp(avgErr);

% Calculating confusion Matrix
C = confusionmat(test_y, labels);
disp(C);

% Calculating Accuracy
acc = sum(diag(C)) ./ sum(C(:));
disp(acc);

% Calculating per class Recall and Precision
P = [];
R = [];

for i=1:2
    P(i) = C(i,i) ./ sum(C(:,i));
    R(i) = C(i,i) ./ sum(C(i,:));
end

% Displaying per class Precision and Recall
for i=1:2
    fprintf('Precision for label %d: %d\n',(i-1),P(i));
end
for i=1:2
    fprintf('Recall for label %d: %d\n',(i-1),R(i));
end
