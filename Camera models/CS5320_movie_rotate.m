function MP = CS5320_movie_rotate(P,t,del_theta,max_theta)
% CS5320_movie_rotate - generate a z axis rotation of camera movie
% On input:
%     P (4xk array): world points (homogeneous coordinates)
%     t (3x1 vector): camera origin (in world coordinates)
%     del_theta (float): step in rotation direction
%     max_theta (float): extreme value in rotation
% On output:
%     MP (movie data structure): movie of points during rotation
% Call:
%     cube = CS5320_gen_cube([0;0;0],0.01,1);
%     MP = CS5320_movie_rotate(cube,[0;0;2],0.1,pi);
%     movie2avi(MP,'A1_rotate');
% Author:
%     T. Henderson
%     UU
%     Spring 2016
%

% Set intrinsic camera parameters
alpha = 1;
beta = 1;
theta = pi/2;
x0 = 0;
y0 = 0;

% Set initial rotation matrix to identity
R = eye(3,3);

clf
hold on
f = 0;
theta_vals = [0:del_theta:max_theta];
if theta_vals(end)~=max_theta
    theta_vals = [theta_vals,max_theta];
end
for thetap = theta_vals
    f = f + 1;
    R = CS5320_gen_R([0;0;1],thetap);
    im = CS5320_camera(P,alpha,beta,theta,x0,y0,R,t);
    clf
    plot(-11,-11,'w.');
    hold on
    plot(11,11,'w.');
    plot(im(1,:),im(2,:),'k.');
    MP(f) = getframe;
end