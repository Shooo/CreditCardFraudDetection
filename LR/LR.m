function thetas = LR(x,y,a,max_iter)

alpha = a;
MAXITER = max_iter;
% initialize thetas
thetas = zeros(size(x,2),1);

for iter=1:MAXITER
    for j=1:size(x,2)
        sum = 0;
        for i=size(x,1)
            temp = sigmf((-(thetas' * x(i,:)')),[1 0]);
            temp = (temp - y(i,:)) * x(i,j);
            sum = sum + temp;
        end
        thetas(j) = thetas(j) - alpha * sum;
    end
end

thetas = [1; thetas];

