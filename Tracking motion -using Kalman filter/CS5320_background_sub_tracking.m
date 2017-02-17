function t_im = CS5320_background_sub_tracking(im)
% CS5320_background_sub_tracking - track by background difference
% On input:
%      im (struct array): image sequence (p images)
%        im(k).im (mxnxd array): k_th image
% On output:
%      t_im (mxnxp array): subtracted images (image from average)
% Call:
%      t_im = CS5320_background_sub_tracking(ims);
% Author:
%      Clinton Fernandes
%      UU
%      Spring 2016
%

numIm = size(im,2);
[rows, cols, planes] = size(im(1).cdata);
meanImg = zeros(rows,cols,planes);
sumImg = zeros(rows,cols,planes);
t_im = zeros(rows,cols,numIm);

for i = 1:numIm
    for j = 1:planes
        sumImg(:,:,j) = sumImg(:,:,j) + double(im(i).cdata(:,:,j));
    end
end

for j = 1:planes
    meanImg(:,:,j) = sumImg(:,:,j)/numIm;
end

t = zeros(rows,cols,planes);

for i = 1:numIm
	for j = 1:planes
        t(:,:,j) = (double(im(i).cdata(:,:,j))-meanImg(:,:,j));
    end
    
    for m = 1:rows
        for n = 1:cols
            t_im(m,n,i) = norm([t(m,n,1),t(m,n,2),t(m,n,3)]);
        end
    end
end