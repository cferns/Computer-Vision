function MP = CS5320_movie_trans(P,z_start,del_z,z_end)
% CS5320_movie_trans - generate a translation of camera movie
% On input:
%     P (4xk array): world points (homogeneous coordinates)
%     z_start (float): start point on z axis
%     del_z (float): step in translation direction
%       positive if z_start <= z_end, else negative
%     z_end (float): last point on z axis
% On output:
%     MP (movie data structure): movie of points during translation
% Call:
%     cube = CS5320_gen_cube([0;0;0],0.01,1);
%     MP = CS5320_movie_trans(cube,1,0.1,2);
%     movie2avi(MP,'A1_trans');
%     MP = CS5320_movie_trans(cube,2,-0.1,-1);
%     movie2avi(MP,'A1_trans');
% Author:
%     T. Henderson
%     UU
%     Spring 2016
%

% Set intrinsic camera paramters
alpha = 1;
beta = 1;
theta = pi/2;
x0 = 0;
y0 = 0;

% Set extrinsic rotation to identity
R = eye(3,3);

clf
hold on
f = 0;
for z = z_start:del_z:z_end
    f = f + 1;
    t = [0;0;z];
    im = CS5320_camera(P,alpha,beta,theta,x0,y0,R,t);
    clf
    plot(-11,-11,'w.');
    hold on
    plot(11,11,'w.');
    if ~isempty(im)
        plot(im(1,:),im(2,:),'k.');
    end
    MP(f) = getframe;
end