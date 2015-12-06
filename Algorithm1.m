clear all

%Online dictionary learning 
T = 2000; 
n = T;              %number of samples, the same as iteration times
sm = 10; m = sm*sm; %(custom)side-length of one patch
k = 200;            %(custom)k atoms
x = zeros ([m,1]);  %signal
D = rand(m,k);  %randomly initialized dictionary 
lambda = 0.1;         %penalty
tau = 1.0000e-04;   %stepsize of Lasso iteration 
% less than 1/(||D||^2)
diff = 0.0004;
diff2 = 0.0001; % for dictionary update
maxCount = 150; % max number of iteration for DictionaryUpadate()

img = double(imread('Lenna.png'))/255;
size(img);
[row,col] = size(img(:,:,1));
img_red = img(:,:,1);
%set p(x)
nrow = (row-sm);
ncol = (col-sm);
% choose T samples from all possible patched WITH replacement
pointSet = datasample(1:nrow*ncol, T);
p = zeros([m, T]);
for t = 1:T
    point = pointSet(t); % to get the position of the starting pixel
    r = round(point/ncol)+1; 
    c = mod(point, ncol)+1; 
    patch = img_red(r:(r+sm-1),c:(c+sm-1));
    p(:,t) = reshape(patch, [m,1]); 
end



%reset the past information:
A2 = zeros ([k k]);     %a_1 ~ a_k
B2 = zeros ([m k]);     %b_1 ~ b_k
D2 = D;
for t = 1:T
    t
    %Update information
    D1 = D2; A1 = A2; B1 = B2; 
    %draw iid samples of p(x):
    xt = p(:,t); 
    %spare coding: compute using LASSO
    w0 = ones([k, 1]);
    wt = Lasso(D1, xt, tau, diff, lambda, w0);
    A2 = A1 + wt*wt';
    B2 = B1 + xt*wt';
    %Compute Dt using Alg 2, with D(t-1) as warm restart:
    aa = zeros([100 1]);
    D2 = dictionaryUpdate(D1, A2, B2, m, k, diff2, maxCount, aa);
end

