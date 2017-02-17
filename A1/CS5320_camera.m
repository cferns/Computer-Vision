function im = CS5320_camera(scene,alpha,beta,theta,x0,y0,R,t)
% CS5320_camera - produce camera model perspective projection
% On input:
%   scene (4xk array): 3D homogeneous coordinate world points
%   alpha (float): pixel scale parameter in x (intrinsic)
%   beta (float): pixel scale parameter in y (intrinsic)
%   theta (float): image frame skew angle (intrinsic)
%   x0 (float): image plane center offset (intrinsic)
%   y0 (float): image plane center offset (intrinsic)
%   R (3x3 array): rotation array (extrinsic)
%   t (3x1 vector): translation vector world origin to camera
%   (extrinsic)
% On output:
%   im (3xk array): homogeneous coordinates for points on image
%   plane
%   row 1: X values
%   row 2: Y values
%   row 3: 1’s (homogeneous coordinate)
% Call:
%   im = CS5320_camera(cube,1,1,pi/2,0,0,eye(3,3),[0;0;0]);
% Author:
%   Rajiv Mantena     | u1007484
%   UU
%   Spring 2016
%

T = [R t];          %Form the transformation matrix T from R and t.
K = [alpha,-alpha*cot(theta),x0;0,beta/sin(theta),y0;0,0,1];
img = K*T*scene;
im = [];
[m,n] = size(img);  
for i=1:n
    if img(3,i) < 0
        if (img(1,i)/img(3,i))<10 && (img(1,i)/img(3,i))>-10 && ...
                (img(2,i)/img(3,i))<10 && (img(2,i)/img(3,i))>-10
            im = [im;img(1,i)/img(3,i),img(2,i)/img(3,i),img(3,i)/img(3,i)];
        end
    end
end
im = im';