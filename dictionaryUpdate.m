function [ D2 ] = dictionaryUpdate( D1, A2, B2, m, k, diff,maxCount, aa)

D2 = D1;
count = 0;
diffnow = 100; % big number
while (diffnow > diff && count < maxCount)
    D1 = D2;
    for j = 1:k
        %update the j-th cols of D1:
        uj = 1/max(0.001,A2(j,j))*(B2(:,j) - D2*A2(:,j)) + D2(:,j);
        D2(:,j) = 1/max(norm(uj),1)*uj;
    end
    count = count + 1;
    diffnow = norm(D2-D1);
    if mod(count,100) == 0 
        diffnow
    end
    aa(count) = diffnow;
end
end

