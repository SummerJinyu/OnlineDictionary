function imgnew = maskgenerator(str,maskrow,maskcol)
img = imread(str);
img = img(:,:,1);
imgnew = imresize(img, [maskrow,maskcol]); %resize img to the mask size
imgnew = im2bw(imgnew,0.5); %convert image binary image, using 0.5 as threshold
end
%imwrite(imgnew,'mask*.png')