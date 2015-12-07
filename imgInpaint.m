function inpaintedImgData = imgInpaint(imgData, maskData, dict, sm, lambdaGood, tauLasso, diffLasso, lambdaLasso)
    m = sm * sm; % size of a patch
    k = length(dict); % # of atoms in the dictionary
    [r, c] = size(imgData); % # of rows and columns of the image
    patchNum = getPatchNum(r, c, sm); % # of all possible patches
    
    round = 0;
    inpaintedImgData = imgData;
    inpaintedMaskData = maskData;
    while 1 % repeat until all the 
        round = round + 1
        imgDataNew = inpaintedImgData * (1 - inpaintedMaskData); % new image inpainted for the current interation 
        countDataNew = lambdaGood * (1 - inpaintedMaskData);
        nNewPatch = 0; % count if there is new inpainted patch
        
        iPatch = 1 + floor(rand() * sm);
        while iPatch <= patchNum % travel thru all the patches, and randonly skip some of them :)
            if mod(iPatch,10000) == 0
                iPatch
            end
            patchInpaintMask = getPatch(inpaintedMaskData, sm, iPatch); % an mX1 (0,1)-mask indicates where in the patch to inpaint
            nHole = sum(patchInpaintMask); % # of pixels that need to be recover
            if (nHole == 0 || nHole > 3) 
                % The patch is totally good,
                % or too many area missing, wait for next iteration.
                % nothing need to be done here.
                continue
            end
            % the hole is small enough in the patch so we can inpaint it in this interation
            nNewPatch = nNewPatch + 1;
            patch = getPatch(imgData, sm, iPatch); % an mX1 column vector
            maskPatch = getPatchMask(r, c, sm, iPatch); % an rXc (0,1)-matrix indicates where is the patch
            ind = find(patchInpaintMask == 1);
            iPatch
            a = Lasso( dict(ind,:), patch(ind), tauLasso, diffLasso, lambdaLasso, rand(k,1));
            'lasso'
            patchNew = dict*a;
            [ir, ic] = getPatchPos(r, c, sm, iPatch);
            imgDataNew(ir:(ir+sm-1),ic:(ic+sm-1)) = imgDataNew(ir:(ir+sm-1),ic:(ic+sm-1)) + reshape(patchNew,[sm,sm]);
            countDataNew = countDataNew + maskPatch;
            
            iPatch = iPatch + 1 + floor(rand() * sm);
        end
        if nNewPatch == 0 % no new patch generated
            % This means all the holes is inpainted
            break
        end
        inpaintedMaskData = (countDataNew ~= 0); % new mask
        inpaintedImgData = imgDataNew / (inpaintedMaskData + countDataNew); % average inpainted parts, "+ countDataNew" is to avoid being divided by zero
    end
end

