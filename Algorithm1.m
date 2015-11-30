%Online dictionary learning 
T = 20000; 
n = T;              %number of samples, the same as iteration times
m = 100;            %(custom)
k = 200;            %(custom)k atoms
x = zeros ([m,1]);  %signal
D = rand(m,k);  %randomly initialized dictionary 
lambda = 0.1;         %penalty
tau = 1.0000e-04;   %stepsize of Lasso iteration
diff = 0.0001;
diff2 = 0.001; % for dictionary update


img = double(imread('Lenna.png'))/255;
size(img);
[row,col] = size(img(:,:,1));
img_red = img(:,:,1);
%set p(x)
%Draw samples from (row-sqrt(m))*(col-sqrt(m)) without replacement:
rowLength = (row-sqrt(m));
colLength = (col-sqrt(m));
pointSet = randsample(rowLength*colLength, rowLength*colLength);
p = zeros([m, T]);
for t = 1:T
    point = pointSet(t);
    r = round(point/colLength)+1;
    c = mod(point, colLength)+1; 
    patch = img_red(r:(r+sqrt(m)-1),c:(c+sqrt(m)-1));
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
    D2 = dictionaryUpdate(D1, A2, B2, m, k, diff2/sqrt(t),aa);
end

minPoint = 0;
maxPoint = 0;
for i = 1:100
    for j = 1:200
        if D2(i,j) < minPoint
            minPoint = D2(i,j);
        end
        if D2(i,j) > maxPoint
            maxPoint = D2(i,j);
        end
    end
end


figure(1);
hold on;
a = zeros([10,10,200]);
for i = 1:200
    a(:,:,i) = reshape(D2(:,i), [sqrt(m),sqrt(m)]);
    subplot(10,20,i);
    imshow(a(:,:,i), [minPoint maxPoint])
end






