%model = fitcsvm(train_x,train_y);
%model = fitcsvm(train_x,train_y,'KernelFunction','polynomial');

% Changing the Kernel Scale allows us to change levels of gamma
model = fitcsvm(train_x, train_y, 'KernelFunction', 'rbf', 'KernelScale', 0.2);
[label,score] = predict(model,test_x);



C = confusionmat(test_y,label);
disp(C);