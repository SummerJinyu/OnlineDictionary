figure(1);
hold on;
a = zeros([10,10,200]);
%D2 = (D2-minPoint)/(maxPoint-minPoint);
for i = 1:200
    a(:,:,i) = reshape(D2(:,i), [sqrt(m),sqrt(m)]);
    %subplot(10,20,i);
    %imshow(a(:,:,i));
    imshow(a(:,:,i), [minPoint maxPoint])
end
hold off;

imshow(a(:,:,3), [minPoint maxPoint])