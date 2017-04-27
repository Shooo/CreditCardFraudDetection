% This script generates the graphs of each feature and its corresponding
% label


figure;
for i=2:29
    subplot(5,6,i);
    plot(M(:,i),M(:,31),'.');
end