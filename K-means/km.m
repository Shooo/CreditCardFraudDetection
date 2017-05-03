load('../data.mat');
K = 2;
[idx,C,sumd] = kmeans(test_x,K);

disp(sum(idx(:)==1));
disp(sum(idx(:)==2));