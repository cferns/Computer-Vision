function [ta,ty,te] = CS5320_const_acc_Kalman(x0,y0,vx0,vy0,ax0,ay0,...
del_t,max_t,R,Q)
% CS5320_const_acc_Kalman - simulation of constant acceleration
% scenario
% On input:
%     x0 (float): initial x locaiton
%     y0 (float): initial y location
%     vx0 (float): initial x speed
%     vy0 (float): initial y speed
%     ax0 (float): x acceleration
%     ay0 (float): y acceleration
%     del_t (float): time step
%     max_t (float): max time for simulation
%     R (6x6 array): process covariance matrix
%     Q (2x2 array): observation covariance matrix
% On output:
%     ta (px6 array): actual state values for p steps
%     ty (px2 array): observation values for p steps
%     te (px6 array): estimated state values for p steps
% Call:
%     [ta,ty,te] = CS5320_const_acc_Kalman(0,0,0,0,0,-9.8,0.1,3,R,Q);
% Author:
%     Clinton Fernandes
%     UU
%     Spring 2016
%

%find the actual states by using acceleration simulation
ta = CS5320_const_acc(x0,y0,vx0,vy0,ax0,ay0,del_t,max_t,R);

%sensor states
ty = [x0, y0];
M = [1 0 0 0 0 0;0 1 0 0 0 0];
index = 1;
for t = del_t:del_t:max_t
    index = index + 1;
    %Call: temp = CS5320_observe(ta(index,:)',M,Q);
    temp = M*ta(index,:)' + mvnrnd(zeros(1,size(Q,2)),Q)';
    ty = [ty;temp'];
end

%estimate states
te = [x0, y0, vx0, vy0, ax0, ay0];
x_im1 = [x0;y0;vx0;vy0;ax0;ay0];
Sigma_im1 = zeros(6);
index = 1;

for t = del_t:del_t:max_t
    index = index + 1;
    D = [1 0 del_t 0 0.5*del_t^2 0; 0 1 0 del_t 0 0.5*del_t^2;...
        0 0 1 0 del_t 0; 0 0 0 1 0 del_t; 0 0 0 0 1 0; 0 0 0 0 0 1];
    y = ty(index,:)';
    
    [x_i_plus,Sigma_i_plus] = CS5320_Kalman_step(x_im1,Sigma_im1,D,R,M,Q,y);
    te = [te; x_i_plus'];
    x_im1 = x_i_plus;
    Sigma_im1 = Sigma_i_plus;
end