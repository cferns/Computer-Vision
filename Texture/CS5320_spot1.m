function S1 = CS5320_spot1
% CS5320_spot1 - texture feature: spot 1
% On input:
%     N/A
% On output:
%     S1 (11x11 array): spot filter
% Call:
%     S1 = CS5320_spot1
% Method:
%     uses combination of 3 symmetric Gaussian filters:
%     S1 = G1 - 2*G2 + G3
%     where
%       G1 is Gaussian with sigma = 0.62
%       G2 is Gaussian with sigma = 1
%       G3 is Gaussian with sigma = 1.6
% Author:
%     Clinton Fernandes
%     UU
%     Spring 2016
%

G1 = fspecial('gaussian',11,0.62);
G2 = fspecial('gaussian',11,1);
G3 = fspecial('gaussian',11,1.6);
S1 = G1 - 2*G2 + G3;