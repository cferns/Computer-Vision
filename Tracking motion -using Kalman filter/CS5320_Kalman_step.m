function [x_i_plus,Sigma_i_plus] = CS5320_Kalman_step(x_im1,Sigma_im1,...
D,R,M,Q,y)
% CS5320_Kalman_step - one step in Kalman filter update
% On input:
%     x_im1 (nx1 vector): state vector at step i-1
%     Sigma_im1 (nxn array): state covariance array
%     D (nxn array): linear process matrix
%     R (nxn array): process covariance matrix
%     M (kxn arraay): linear observation matrix
%     Q (kxk array): observation covariance array
%     y (kx1 vector): observation vector
% On output:
%     x_i_plus (nx1 vector): updated state vector
%     Sigma_i_plus (nxn array): state covariance matrix
% Call:
%     [x,Sigma] = CS5320_Kalman_step(x,Sigma,D,R,M,Q,y);
% Author:
%     Clinton Fernandes
%     UU
%     Spring 2016
%

I = eye(size(x_im1,1));

x_i_bar = D*x_im1 + 0; % what to add for control vector? 0?
Sigma_i_bar = D*Sigma_im1*D' + R;
K = Sigma_i_bar*M'*(M*Sigma_i_bar*M' + Q)^(-1);
x_i_plus = x_i_bar + K*(y - M*x_i_bar);
Sigma_i_plus = (I - K*M)*Sigma_i_bar;