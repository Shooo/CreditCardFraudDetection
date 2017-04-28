net = patternnet(10);
% view(net)
[net,tr] = train(net,train_x',train_y');
%nntraintool

labels = net(test_x');
