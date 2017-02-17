function [p,s] = CV_total_LS(x,y)
%
%CV_total_LS - total least squares method to fit best line to points
%    (Forsyth and Ponce page 295
%On input:
%    x (nx1 vector): x coordinates of points
%    y (nx1 vector): y coordinates of points
%On output:
%    p (1x3 vector): coefficients of best fit line ax + by + c = 0
%    s (float): error measure (sum of squares of distances
%    of points to line)
%Call:
%     do not use >> [p1,s1] = CV_total_LS([1,2,3],[1,2,3]);
%     [p1,s1] = CV_total_LS([1;2;3],[1;2;3]);
%Author:
%    Clinton Fernandes
%    UU
%    Spring 2016
%

n = size(x,1);

A11 = mean(x.^2) - mean(x)^2;
A12 = mean(x.*y) - mean(x)*mean(y);
A21 = A12;
A22 = mean(y.^2) - mean(y)^2;
A = [A11 A12; A21 A22];

[V,D] = eigs(A);

if D(1,1)<D(2,2)
   p(1,1) = V(1,1);
   p(1,2) = V(2,1);
else
   p(1,1) = V(1,2);
   p(1,2) = V(2,2);
end

p(1,3) = -p(1,1)*mean(x) - p(1,2)*mean(y);

s = 0;
for i = 1:n;
	s = s + (p(1,1)*x(i) + p(1,2)*y(i) + p(1,3))^2;
end
