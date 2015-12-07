clear all

sm = 10; m = sm*sm; %(custom)side-length of one patch
% Online dictionary learning 
T = 1000;          %number of samples/iteration times
k = 200;            %(custom)k atoms
lambdaLasso = 1e-2; 
diff2 = 4e-4; % for dictionary learning, limit of the distance between succesive dictionaries
maxCount = 150; % for dictionary learning, max number of iteration for DictionaryUpadate()
% Image inpainting
lambdaGood = 10;    % the weight for preserving original image       
img = imgData('pic/TUM-IID/images/1.png');
img = img(:,:,1);
mask = imgData('pic/TUM-IID/masks/mask3.png');


[row,col] = size(img);
patchNum = getPatchNum(row, col, sm);
isGoodiPatch = zeros(patchNum,1);
for iPatch = 1:patchNum
    if sum(getPatch(mask, sm, iPatch)) == 0
        isGoodiPatch(iPatch) = 1;
    end
end
goodiPatches = find(isGoodiPatch == 1);
% choose T samples from all possible patched WITH replacement
iPatchSet = datasample(goodiPatches, T);
X = zeros([m, T]);
for t = 1:T
    iPatch = iPatchSet(t); % to get the index of the starting pixel
    X(:,t) = getPatch(img, sm, iPatch); 
end

D = Algorithm1(X, k, lambdaLasso, diff2, maxCount);

inpimg = imgInpaint(img, mask, D, sm, lambdaGood, lambdaLasso);
