load('../data.mat');
load('../features.mat');


net = patternnet(25);


% [net,tr] = train(net,train_x',train_y');
% [net,tr] = train(net,train_x(:,cand_and_good-1)',train_y');
[net,tr] = train(net,train_x(:,good-1)',train_y');


% prob = net(test_x');
% prob = net(test_x(:,cand_and_good - 1)');
prob = net(test_x(:,good - 1)');


% Testing different thresholds to see which gets minimum error

% i = 1;
% for tsh = 0.001:0.001:0.999
%     haty = (prob >= tsh);
%     avgErr(i) = mean(abs(haty' - MTest(:,31)));
%     i = i + 1;
% end
% 
% figure
% plot(0.021:0.001:0.999,avgErr(21:999),'r.');
% xlabel('threshold');
% ylabel('error');

% According to the plot, the best threshold should be 


labels = (prob >= 0.5);

labels = +labels;
labels = labels.';

avgErr = mean(abs(labels - MTest(:,31)));
disp(avgErr);

C = confusionmat(test_y, labels);
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
