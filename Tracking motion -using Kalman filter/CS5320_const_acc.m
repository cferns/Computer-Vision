function trace = CS5320_const_acc(x0,y0,vx0,vy0,ax0,ay0,del_t,max_t,R)
% CS5320_const_acc - constant acceleration forward simulation
% On input:
%      x0 (float): initial x location
%      y0 (float): initial y location
%      vx0 (float): initial x speed
%      vy0 (float): initial y speed
%      ax0 (float): x acceleration
%      ay0 (float): y acceleration
%      del_t (float): time step
%      max_t (float): maximum time for simulation
%      R (6x6 array): covariance of process
% On output:
%      trace (kx4 array): state trace
%        trace(i,:): state vector at step i
% Call:
%      tr = CS5320_const_acc(0,0,0,0,0,-9.8,0.1,2,0.0001*eye(6));
% Author:
%      Clinton Fernandes
%      UU
%      Spring 2016
%

trace = [x0, y0, vx0, vy0, ax0, ay0];

for t = del_t:del_t:max_t
    A = [1 0 del_t 0 0.5*del_t^2 0; 0 1 0 del_t 0 0.5*del_t^2;...
        0 0 1 0 del_t 0; 0 0 0 1 0 del_t; 0 0 0 0 1 0; 0 0 0 0 0 1];
    p_im1 = [x0; y0; vx0; vy0; ax0; ay0];
    %Call: temp = CS5320_process_step(p_im1,A,R);
    temp = A*p_im1 + mvnrnd(zeros(1,size(R,2)),R)';
    trace = [trace; temp'];
    
    x0 = temp(1);
    y0 = temp(2);
    vx0 = temp(3);
    vy0 = temp(4);
    ax0 = temp(5);
    ay0 = temp(6);
end