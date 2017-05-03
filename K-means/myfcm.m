function [U, V,objFcn] = myfcm(data, c, T, m, epsm)
% this is the FCM code

if nargin < 3
 T = 50; %default max iteration
end
if nargin < 5
 epsm = 1.0e-6; % default convergence precision
end
if nargin < 4
 m = 2; %
end

[n, s] = size(data);
U0 = rand(c, n);
temp = sum(U0,1);
for i=1:n
 U0(:,i) = U0(:,i)./temp(i);
end
iter = 0;
V(c,s) = 0; U(c,n) = 0; distance(c,n) = 0;

while( iter<T )
 iter = iter + 1;
%update V(t) centroid vector. K rows s colums,  K centers with s indicators
 Um = U0.^m;
 V = Um*data./(sum(Um,2)*ones(1,s)); 
% update U(t) {K rows and n colums}. U[ij] means the degree that data j belongs to cluster i
 for i = 1:c
 for j = 1:n
 distance(i,j) = sqrt(sum((data(j,:)-V(i,:)).^2));
 end
 end
	 U=1./(distance.^m.*(ones(c,1)*sum(distance.^(-m))));
	 objFcn(iter) = sum(sum(Um.*distance.^2));
 % check stop conditions
 if norm(U-U0,Inf)<epsm
	 break
 end
U0=U;
end
myplot(U,objFcn);


% 写的时候先 load('data.mat')
% 然后 myfcm(test_x,2)  或者 myfcm(test_x,3)
% 对应的myplot也要注释或者不注释第三个， 表格上面会很混乱