function im_lm = CS5320_local_max(im)
% CS5320_local_max - local maxima of image
% On input:
%     im (mxn array): input image
% On output:
%     im_lm (mxn array): non-zero values at local maxima
% Call:
%     A_lm = CS5320_local_max(A);
% Author:
%     T. Henderson
%     UU
%     Spring 2016
%

im_lm = imregionalmax(im);