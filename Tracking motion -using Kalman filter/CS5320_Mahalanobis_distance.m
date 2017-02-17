function d =  CS5320_Mahalanobis_distance(obsVect, meanRGB, covarRGB)

% CS5320_detect_red_ball - find red ball in image
% On input:
%     obsVect (1x3 array): rgb Vector
%     meanRGB (1x3 vector): mean of the sampled pixels in the ball
%     covarRGB (1x3 vector): covariance matrix
%       call [meanRGB, covarRGB, RGBstore] = mean_covar_of_pixels()
%       before this function
% On output:
%     d = distance;
% Call:
%     d =  CS5320_Mahalanobis_distance([230 5 3], meanRGB, covarRGB)
% Author:
%     Clinton Fernandes
%     UU
%     Spring 2016
%

 d = (obsVect - meanRGB)*inv((covarRGB))*(obsVect - meanRGB)';