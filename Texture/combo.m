function X = combo(im1,im2)
%
% combo: displays image im1 with non-zero elements of im2 overlayed in red
%
% On input:
%     im1 (nr x nc x np image): base image to be shown
%     im2 (nr x nc image): image to show as red overlay
% On output:
%     X (nr x nc x np image): combined
% Call:
%     X = combo(im1,im2)
% Author:
%     T. Henderson
%     UU
%     20th century
%

[nr,nc,np] = size(im1);
if np==1
    X(:,:,1) = im1;
    X(:,:,2) = im1;
    X(:,:,3) = im1;
else
    X = im1;
end

for r = 1:nr
    for c = 1:nc
        if im2(r,c)>0
	        X(r,c,1) = uint8(255); X(r,c,2) = uint8(0); X(r,c,3) = uint8(0);
        end
    end
end

clf;
imshow(X);
