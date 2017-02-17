function F = CS5320_oriented_Gaussian(a,b,c,d,sigma1,sigma2,x0,y0,...
    xmin,xmax,ymin,ymax,delx)
% CS5320_oriented_Gaussian - produce oriented 2D Gaussian filter
% On input:
%     a (float): x-coord of direction 1
%     b (float): y-coord of direction 1
%     c (float): x-coord of direction 2
%     d (float): y-coord of direction 2
%     sigma1 (float): variance of direction 1
%     sigma2 (float): variance of direction 2
%     x0 (float): x coord of center of filter
%     y0 (float): y coord of center of filter
%     xmin (float): xmin for filter values
%     xmax (float): xmax for filter values
%     ymin (float): ymin for filter values
%     ymax (float): ymax for filter values
%     delx (float): step size for filter values
% On output:
%     F (mxn array): oriented Gaussian filter; size depends on x and y
%        dimensions and delx
% Call:
%     G1 = CS5320_oriented_Gaussian(a,b,c,d,2,1,0,1,xmi,xma,ymi,yma,0.1);
% Author:
%     T. Henderson
%     UU
%     Spring 2016
%

xv = xmin:delx:xmax;
yv = ymin:delx:ymax;
numx = length(xv);
numy = length(yv);
p = zeros(numx,numy);

term1 = -1/(2*sigma1^2);
term2 = -1/(2*sigma2^2);

for xi = 1:numx
    x = xv(xi) - x0;
    for yi = 1:numy
        y = yv(yi) - y0;
        p(xi,yi) = exp(term1*(a*x+b*y)^2+term2*(c*x+d*y)^2);
    end
end

F = p;