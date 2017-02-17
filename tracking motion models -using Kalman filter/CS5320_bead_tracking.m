function track = CS5320_bead_tracking(t_im)
% bead_tracking - track the bead position in the image
% On input:
%      t_im (mxnxp array): subtracted images (image from average)
% On output:
%      track (mxn array): [rows,cols] of the center of object
% Call:
%      track = bead_tracking(Bead);
% Author:
%      Clinton Fernandes
%      UU
%      Spring 2016
%

track =[];
[rows,cols,numImages] = size(t_im);

for i = 1:numImages
    temp_im = zeros(rows,cols);
    threshold = 0.65*max(max(t_im(:,:,i)));
    for j = 1:rows
        for k = 1:cols
            if t_im(j,k,i)>threshold%previously 170 works
                temp_im(j,k,i)=1;
            end
        end
    end
    
    %to find largest connected object
    CC = bwconncomp(temp_im(:,:,i));
    maxObjects = size(CC.PixelIdxList(1,:),2);
    a=zeros(maxObjects,1);
    for ob = 1:maxObjects
        a(ob,1) = size(CC.PixelIdxList{1, ob},1);
    end
    
    maxIndex = find(a == max(a));
        
	S = regionprops(CC,'Centroid');
    
    c = round(S(maxIndex).Centroid(1));
    r = round(S(maxIndex).Centroid(2));

	track= [track;[r,c]];
end