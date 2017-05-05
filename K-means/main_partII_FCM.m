clear
clc
load('../data.mat');
load('../features.mat');

% Fuzzy C-means (FCM)
% step 1: load data
% load('data.mat','test_x');
K=2; % 10 clusters; 

arrCentroid=zeros(K,28); %center points; 
arrMember=zeros(85442, K); % degree of every sample and every cluster.
MAXITER=30;

% step 2: initialize memberships
epsm = 1.0e-6;
m = 2;
[n, s] = size(test_x);  % n rows and s colums
U0 = rand(K, n);
temp = sum(U0,1);
for i=1:n
    U0(:,i) = U0(:,i)./temp(i);
end
iter = 0;
V(K,s) = 0;
U(K,n) = 0;
distance(K,n) = 0;

while( iter<MAXITER )
    iter = iter + 1;
% step 3: Calculate the cluster centroids
%update V(t) centroid vector. K rows s colums,  K centers with s indicators
    Um = U0.^m;
    V = Um*test_x./(sum(Um,2)*ones(1,s));
% step 4: update membership values 
% update U(t) {K rows and n colums}. U[ij] means the degree that data j belongs to cluster i
    for i = 1:K
       for j = 1:n
            distance(i,j) =  sqrt(sum((test_x(j,:)-V(i,:)).^2));
       end
    end
    U=1./(distance.^m.*(ones(K,1)*sum(distance.^(-m))));
% step 6: calculate the sum of squared errors (SSE) as a quantitative metric of your clustering result
    objFcn(iter) = sum(sum(Um.*distance.^2));
    % FCM stop condition
% step 5: check stop conditions
    if norm(U-U0,Inf)<epsm
       break
    end
    U0=U;
end

% Plot convergency curve for which the horizontal-direction indicates iteration, 
%and the vertical-direction indicates the objective function F(i.e., SSE).
myplot(U,objFcn);
%label('iteration numbers')
%ylabel('objective function')
