function  D2 = Algorithm1(X, k, lambdaLasso, diff2, maxCount)
[m, T] = size(X);

%reset the past information:
A2 = zeros ([k k]);     %a_1 ~ a_k
B2 = zeros ([m k]);     %b_1 ~ b_k
D2 = zeros([m k]);
for t = 1:T
    t
    %Update information
    D1 = D2; A1 = A2; B1 = B2; 
    %draw iid samples of p(x):
    xt = X(:,t); 
    %spare coding: compute using LASSO
    % w0 = ones([k, 1]);
    % wt = Lasso(D1, xt, tau, diff, lambda, w0);
    wt = lasso(D1, xt, 'lambda', lambdaLasso);
    A2 = A1 + wt*wt';
    B2 = B1 + xt*wt';
    %Compute Dt using Alg 2, with D(t-1) as warm restart:
    aa = zeros([100 1]);
    D2 = dictionaryUpdate(D1, A2, B2, m, k, diff2/sqrt(t), maxCount, aa);
end

