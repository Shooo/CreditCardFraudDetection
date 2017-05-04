load('data.mat');
net = patternnet([25 15 5]);
% view(net)
[net,tr] = train(net,train_x',train_y');
% nntraintool

prob = net(test_x');
labels = (prob >= 0.5);
labels = +labels;
labels = labels.';

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
