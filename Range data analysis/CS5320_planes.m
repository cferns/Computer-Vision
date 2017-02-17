function planes = CS5320_planes(points,normals,k)
% CS5320_planes - find best plane fit at each pixel
% On input:
%      points (mxnx3 array): x,y,z points
%      normals (mxnx3 array): surface normal at each point
%      k (int): uses 2k+1 by 2k+1 window to fit plane
% On output:
%      planes (mxnm5 array): plane parameters and error of fit
%        channels 1-4: a,b,c,d plane parameters
%        channel 5: mean error of fit in window
% Call:
%      im_pl = CS5320_planes(im_xyz,im_nor,2);
% Author:
%      Clinton Fernandes
%      UU
%      Spring 2016
%

[rows, cols, planes] = size(points);
planes = zeros(rows,cols,5);

for i = 1+k:rows-k
    for j = 1+k:cols-k
        %abc
        planes(i,j,1) = normals(i,j,1);
        planes(i,j,2) = normals(i,j,2);
        planes(i,j,3) = normals(i,j,3);
        
        %get xyz values of neighborhood
        x = points(i-k:i+k,j-k:j+k,1);
        y = points(i-k:i+k,j-k:j+k,2);
        z = points(i-k:i+k,j-k:j+k,3);
        
        %d
        planes(i,j,4) = -( normals(i,j,1)*mean(x(:))...
            + normals(i,j,2)*mean(y(:)) + normals(i,j,3)*mean(z(:)));
        
        %error
        temp = (planes(i,j,1)*x + planes(i,j,2)*y...
            + planes(i,j,3)*z + planes(i,j,4)*ones(2*k+1)).^2;
        planes(i,j,5) = sum(sum(temp))/(2*k+1)^2;
    end
end