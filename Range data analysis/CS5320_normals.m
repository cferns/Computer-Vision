function normals = CS5320_normals(pts_im,k)
% CS5320_normals - compute normals on range data
% On input:
%      im (mxnx3 array): range data image
%      k (int): uses 2k+1 by 2k+1 neighborhood for normal computation
% On output:
%      normals (mxnx3 array): normals at each point
% Call:
%      ht_im_normals = CS5320_normals(ht_im_pts,2);
% Author:
%      Clinton Fernandes
%      UU
%      Spring 2016
%

[rows,cols,planes] = size(pts_im);
xdiff = zeros(1,3);
ydiff = zeros(1,3);
normals = zeros(rows,cols,planes);

for yr=1+k:rows-k
    for xc = 1+k:cols-k
        for pl=1:3
            xdiff(1,pl) = pts_im(yr,xc+k,pl)-pts_im(yr,xc-k,pl);
            ydiff(1,pl) = pts_im(yr-k,xc,pl)-pts_im(yr+k,xc,pl);
        end
        N = cross(xdiff,ydiff);
        N = N/norm(N);
        for pl=1:planes
            normals(yr,xc,pl) = N(pl);
        end
    end
end