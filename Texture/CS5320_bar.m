function B = CS5320_bar(a,b,c,d)
% CS5320_bar - texture feature: bar
% On input:
%     a (float): see below
%     b (float): see below
%     c (float): see below
%     d (float): see below
%  These parameters appear in the equation:
%  G_{s1,s2}(x,y) = exp(-(ax+by)ˆ2/(2s1ˆ2)-(cx+dy)ˆ2/(2s2ˆ2)
%   with s1 and s2 the sigmas in x and y, respectively
% On output:
%     B (11x11 array): bar filter
% Call:
%     B = CS5320_bar(1,0,0,-1);
% Method:
%     uses combination of 3 oriented Gaussian filters:
%     B = -G1 + 2G2 - G3
%     where
%       G1: oriented Gaussian from:
%       a,b,c,d,2,1,0,1,xmin,xmax,ymin,ymax,0.1
%       G2: oriented Gaussian from:
%       a,b,c,d,2,1,0,0,xmin,xmax,ymin,ymax,0.1
%       G3: oriented Gaussian from:
%       a,b,c,d,2,1,0,-1,xmin,xmax,ymin,ymax,0.1
% Author:
%     Clinton Fernandes
%     UU
%     Spring 2016
%

val = 3;
xmin = -val;
xmax = val;
ymin = -val;
ymax = val;

G1 = CS5320_oriented_Gaussian(a,b,c,d,2,1,0,1,xmin,xmax,ymin,ymax,0.1);
G2 = CS5320_oriented_Gaussian(a,b,c,d,2,1,0,0,xmin,xmax,ymin,ymax,0.1);
G3 = CS5320_oriented_Gaussian(a,b,c,d,2,1,0,-1,xmin,xmax,ymin,ymax,0.1);
B = -G1 + 2*G2 - G3;
B = imresize(B,[11,11]);