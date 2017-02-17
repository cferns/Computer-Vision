function [ty,te] = CS5320_red_ball_Kalman(im_seq,ax,ay,del_t,R,Q)
% CS5320_red_ball_Kalman - track falling red ball
% On input:
%     im_seg (struct vector): image sequence of falling ball (p
%     images)
%     ax (float): acceleration in x
%     ay (float): acceleration in y
%     del_t (float): time step
%     R (6x6 array): process covariance matrix
%     Q (2x2 array): observation covariance matrix
% On output:
%     ty (px6 array): observation values for p steps
%     te (px6 array): estimated state values for p steps
% Call:
%     R = 0.0001*eye(6,6);
%     R(5:6,5:6) = 0;
%     Q = eye(2,2);
%     [ty,te] = CS5320_red_ball_Kalman(Falling_Ball,0,-9.8,1/30,R,Q);
% Author:
%     Clinton Fernandes
%     UU
%     Spring 2016
%

rows = size(im_seq(1).cdata,1);
numIm = size(im_seq,2);
ty =[];

for i =1:numIm
   [r,c] = CS5320_detect_red_ball(im_seq(i).cdata,[250,0,0]);%[230,30,30]
   x=c;
   y =rows -r+1;
   ty = [ty;[x,y]];
end

%pixel to meters conversion: each pixel is 1/6 m in height
ty  = ty/6;

x0 = ty(1,1);
y0 = ty(1,2);
vx0 = 0;
vy0 = 0;
ax0 = ax;
ay0 = ay;

M = [1 0 0 0 0 0;0 1 0 0 0 0];

te = [x0,y0,vx0,vy0,ax0,ay0];
x_im1 = [x0;y0;vx0;vy0;ax0;ay0];
Sigma_im1 = zeros(6);

for index = 2:70
    D = [1 0 del_t 0 0.5*del_t^2 0; 0 1 0 del_t 0 0.5*del_t^2;...
        0 0 1 0 del_t 0; 0 0 0 1 0 del_t; 0 0 0 0 1 0; 0 0 0 0 0 1];
    y = ty(index,:)';
    
    [x_i_plus,Sigma_i_plus] = CS5320_Kalman_step(x_im1,Sigma_im1,D,R,M,Q,y);
    te = [te; x_i_plus'];
    x_im1 = x_i_plus;
    Sigma_im1 = Sigma_i_plus;
end