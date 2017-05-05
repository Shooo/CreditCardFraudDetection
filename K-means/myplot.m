function myplot(U,objFcn)
% visualize the clustering matrix

figure(1)
subplot(2,1,1);
plot(U(1,:),'-b');
title('matrix degree of belonging')
ylabel('first cluster')
subplot(2,1,2);
plot(U(2,:),'-r');
ylabel('second cluster')

%subplot(3,1,3);
%plot(U(3,:),'-g');
%xlabel('the number of samples')
%ylabel('third cluster')
xlabel('the number of samples')


