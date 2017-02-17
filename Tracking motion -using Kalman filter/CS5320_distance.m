function [row,col] = CS5320_distance(im,model,choice)

% On input:
%     im (mxnx3 array): rgb image
%     model (1x3 vector): rgb model
%     choice: 1 for Euclidean distance
%             2 for Mahalanobis distance
%             3 for Gaussian Probability distance
% On output:
%     row (int): row of red ball centroid
%     col (int): col of red ball centroid
% Call:
%     [rc,cc] = CS5320_red_ball(Falling_ball(1).cdata,[230,30,30]);
% Author:
%     Clinton Fernandes
%     UU
%     Spring 2016
%


% Mahalanobis distance
if choice == 2
    [meanRGB, covarRGB, sampleRGB] = mean_covar_of_pixels;
    temp_im = im(:);

    maxNum = rows*cols;
    im_obs = zeros(maxNum,3);
    obsNum = 0;

    for j = 1:cols
        for i = 1:rows
            obsNum = obsNum+1;
            im_obs(obsNum,:) = [im(i,j,1),im(i,j,2),im(i,j,3)];
        end
    end

    mah_dist = mahal(im_obs,sampleRGB);
    dist = reshape(mah_dist,[rows,cols]);
end


% Gaussian Probability distance
if choice == 2
    %
end


%threshold
max_d = max(max(dist));
threshold = 150;

for i = 1:rows
    for j = 1:cols
        if dist(i,j) >threshold
            dist(i,j)=max_d;
        end
    end
end

[row,col] = find(dist==min(min(dist)));