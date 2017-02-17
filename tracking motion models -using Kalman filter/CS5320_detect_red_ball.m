function [row,col] = CS5320_detect_red_ball(im,model)
% CS5320_detect_red_ball - find red ball in image
% On input:
%     im (mxnx3 array): rgb image
%     model (1x3 vector): rgb model
% On output:
%     row (int): row of red ball centroid
%     col (int): col of red ball centroid
% Call:
%     [rc,cc] = CS5320_detect_red_ball(Falling_ball(1).cdata,[250,0,0]);
% Author:
%     Clinton Fernandes
%     UU
%     Spring 2016
%

[rows,cols,planes] = size(im);
dist = zeros(rows,cols);

for i = 1:rows
    for j = 1:cols
        obsVect = double([im(i,j,1) im(i,j,2) im(i,j,3)]);
        dist(i,j) =  CS5320_Euclidean_distance(obsVect, model);
    end
end

[row,col] = find(dist==min(min(dist)),1);