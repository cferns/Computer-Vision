function S2 = CS5320_spot2
% CS5320_spot2 - texture feature: spot 2
% On input:
%     N/A
% On output:
%     S2 (11x11 array): spot filter
% Call:
%     S2 = CS5320_spot2
% Method:
%     uses combination of 2 symmetric Gaussian filters:
%     S1 = G1 - G2
%     where
%       G1 is Gaussian with sigma = 0.71
%       G2 is Gaussian with sigma = 1.14
% Author:
%     Clinton Fernandes
%     UU
%     Spring 2016
%

G1 = fspecial('gaussian',11,0.71);
G2 = fspecial('gaussian',11,1.14);
S2 = G1 - G2;