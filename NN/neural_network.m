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