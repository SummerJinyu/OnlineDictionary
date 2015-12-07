function mask = getmask(img,threshold)
%% this function is used to get the simple mask from the mixed image
% if the mask and the original image is hard to differ from each other
% we need some futher processing
[m,n] = size(img);
mask = zeros(m,n);
mask = im2bw(img,threshold); % threshold = 0.98...
h = strel('disk',5);
mask = imopen(mask,h); % to remove some small noise
%imshow(mask)
end 