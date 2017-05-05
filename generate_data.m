% load data credicard data into M
M = csvread('creditcard.csv');

% Divide data set into class 0 and class 1
M0 = M(M(:,31) == 0,:);
M1 = M(M(:,31) == 1,:);

% Shuffle dataset and divide into testing and training
M0TrainIndex = randperm(284315,199021);
M1TrainIndex = randperm(492,344);
M0TestIndex = setdiff(1:284315, M0TrainIndex);
M1TestIndex = setdiff(1:492, M1TrainIndex);
M0Train = M0(M0TrainIndex,:);
M1Train = M1(M1TrainIndex,:);
M0Test = M0(M0TestIndex,:);
M1Test = M1(M1TestIndex,:);

% Combine classes and reshuffle dataset

MTrain = [M1Train;M0Train];
MTrainSize = size(MTrain);
shuffleIndex1 = randperm(MTrainSize(1));
MTrain = MTrain(shuffleIndex1,:);

MTest = [M1Test;M0Test];
MTestSize = size(MTest);
shuffleIndex2 = randperm(MTestSize(1));
MTest = MTest(shuffleIndex2,:);

% MTrain and MTest will be used throughout the models
% MTrain is our training set
% MTest is our testing set

train_x = MTrain(:,2:29);
train_x = normc(train_x);
train_y = MTrain(:,31);

test_x = MTest(:,2:29);
test_x = normc(test_x);
test_y = MTest(:,31);

% Save the important variables into data.mat
save('data.mat','M','MTest','MTrain','test_x','test_y','train_x','train_y');
