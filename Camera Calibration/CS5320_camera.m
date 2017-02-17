function im = CS5320_camera(pts,alpha,beta,theta,x0,y0,R,t)
% CS5320_camera - produce camera model perspective projection
% On input:
%     scene (4xk array): 3D homogeneous coordinate world points
%     alpha (float): pixel scale parameter in x (intrinsic)
%     beta (float): pixel scale parameter in y (intrinsic)
%     theta (float): image frame skew angle (intrinsic)
%     x0 (float): image plane center offset (intrinsic)
%     y0 (float): image plane center offset (intrinsic)
%     R (3x3 array): rotation array (extrinsic) (world to camera)
%     t (3x1 vector): translation vector world origin to camera (extrinsic)
% On output:
%     im (3xk array): homogeneous coordinates for points on image plane
%      row 1: X values
%      row 2: Y values
%      row 3: 1's (homogeneous coordinate)
% Call:
%     im = CS5320_camera(cube,1,1,pi/2,0,0,eye(3,3),[0;0;0]);
% Author:
%     T. Henderson
%     UU
%     Spring 2016
%

MIN_THRESH = -0.01;
LIMIT = 10;

T = [R,t; 0 0 0 1];
Ti = T^(-1);
Ri = Ti(1:3,1:3);
ti = Ti(1:3,4);

r1 = Ri(1,1:3)';
r2 = Ri(2,1:3)';
r3 = Ri(3,1:3)';
t1 = ti(1);
t2 = ti(2);
t3 = ti(3);

M = zeros(3,4);
M(1,1:3) = [alpha*r1'-alpha*cot(theta)*r2'+x0*r3'];
M(1,4) = alpha*t1-alpha*cot(theta)*t2+x0*t3;
M(2,1:3) = [(beta/sin(theta))*r2'+y0*r3'];
M(2,4) = (beta/sin(theta))*t2+y0*t3;
M(3,1:3) = r3';
M(3,4) = t3;

im = M*pts;
[dummy,num_pts] = size(pts);
im2 = [];
for p = 1:num_pts
    if im(3,p)<MIN_THRESH
        x2 = im(1,p)/im(3,p);
        y2 = im(2,p)/im(3,p);
%        if x2>-LIMIT&x2<LIMIT&y2>-LIMIT&y2<LIMIT
            im2 = [im2,[x2;y2;1]];
%        else
%            tch = 0;
%        end
    end
end
im = im2;