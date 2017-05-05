% This script generates the graphs of each feature and its corresponding
% label


% Plotting each feature with its corresponding class
figure (1);
for i=2:29
    subplot(5,6,i);
    plot(M(:,i),M(:,31),'.');
end

% Plotting an example of bad, candidate, and good features
figure (2);
subplot(3,1,1);
plot(M(:,6), M(:,31),'.');
xlabel('feature V5 value');
ylabel('label');
title('Bad candidate and good feature')
subplot(3,1,2);
plot(M(:,18),M(:,31),'.');
ylabel('label');
xlabel('feature V17 value');
subplot(3,1,3);
plot(M(:,10),M(:,31),'.');
xlabel('feature V9 value');
ylabel('label')

% Candidate features and good features
cand_and_good = [2 3 8 10 11 12 13 15 16 18 19 21 23 24 25 29 30];

% Strictly good features
good = [3 8 10 11 12 13 15 17 24 25 30];

save('features.mat','cand_and_good','good');
