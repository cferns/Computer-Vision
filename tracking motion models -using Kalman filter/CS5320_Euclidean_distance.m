function d =  CS5320_Euclidean_distance(obsVect, model)
% CS5320_detect_red_ball - find red ball in image
% On input:
%     im (1x3 array): rgb Vector
%     model (1x3 vector): rgb model
% On output:
%     d = distance;
% Call:
%     d =  CS5320_Euclidean_distance(obsVect, [250,0,0])
% Author:
%     Clinton Fernandes
%     UU
%     Spring 2016
%

d = norm(obsVect - model);