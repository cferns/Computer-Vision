function [H,pts] = CS5320_Hough(imo)
% CS5320_Hough - Hough transform of image
% On input:
%    imo (mxn array): gray-level image
% On output:
%    H (rxt array): Hough accumulator array (r rho values; t theta
%    values)
%      r = [indexes to cover from [-ceil(image diagonal to
%           ceil(image diagonal)]
%	   t = [1:180]
%    pts (rxt struct): contains points which contributed to line
%      pts(i,j).pts (kx2 array): k pixels (rows and cols)
% Call:
%    [H4,H4pts] = CS5320_Hough(double(hall4g));
% Author:
%    T. Henderson
%    UU
%    Spring 2016
%
[rows,cols] = size(imo);

r = ceil(sqrt(rows^2 + cols^2));
H = zeros(r*2+1,180);%% -1
pts(r*2+1,180).pts = [];

imEdge = edge(imo,'canny');

for i = 1:rows
    for j = 1:cols
        if imEdge(i,j)==1
            x = j;
            y = rows - i +1;
            for theta = 1:180
                rho = -(x*cosd(theta)+y*sind(theta));
                rho_ind = ceil(r + 1 - rho);%%%%%%%%%%%ceil
                H(rho_ind,theta)=H(rho_ind,theta)+1;
                pts(rho_ind,theta).pts = [pts(rho_ind,theta).pts; [i,j]];
            end
        end
    end
end
a=0;