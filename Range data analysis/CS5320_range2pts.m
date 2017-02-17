function points_im = CS5320_range2pts(range_im)
% CS5320_range2pts - convert range image to full x,y,z points image
% On input:
%      range_im (mxnxd array): range image (d is either 1 or 3)
% On output:
%      points_im (mxnm3 array): x,y,z points in image format
% Call:
%      ht_im_pts = CS5320_range2pts(ht_im);
% Author:
%      Clinton Fernandes
%      UU
%      Spring 2016
%

[rows,cols,d] = size(range_im);

if d == 3
    points_im = range_im;
    return;
end

points_im = zeros(rows,cols,3);
for r = 1:rows
    for c = 1:cols
        points_im(r,c,1) = c;
        points_im(r,c,2) = rows - r + 1;
        points_im(r,c,3) = range_im(r,c);
    end
end