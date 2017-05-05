load('../data.mat');

% Set to 2 clusters
K = 2;
[idx,C,sumd] = kmeans(test_x,K);

% Count number of class 1
disp(sum(idx(:)==1));

% Count number of class 2
disp(sum(idx(:)==2));