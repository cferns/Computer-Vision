function p_i = CS5320_process_step(p_im1,D,R)
% CS5320_process_step - one step in linear process
% On input:
%     p_im1 (nx1 vector): state vector at (i-1)_th step
%     D (nxn array): linear process matrix
%     R (nxn array): covariance matrix for process
% On output:
%     p_i (nx1 vector): state vector at i_th step
% Call:
%     p = CS5320_process_step(p,D,R);
% Author:
%     Clinton Fernandes
%     UU
%     spring 2016
%

p_i = D*p_im1 + mvnrnd(zeros(1,size(R,2)),R)';