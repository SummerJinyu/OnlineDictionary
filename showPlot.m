
minPoint = min(min(D2));
maxPoint = max(max(D2));

figure(1);
hold on;
a = zeros([sm,sm,T]);
for i = 1:T
    a(:,:,i) = reshape(D2(:,i), [sm, sm]);
    subplot(10,20,i);
    imshow(a(:,:,i), [minPoint maxPoint])
end
