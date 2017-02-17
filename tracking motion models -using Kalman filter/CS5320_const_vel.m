function trace = CS5320_const_vel(x0,y0,vx0,vy0,del_t,max_t,R)
% CS5320_const_vel - constant velocity forward simulation
% On input:
%     x0 (float): initial x location
%     y0 (float): initial y location
%     vx0 (float): x speed
%     vy0 (float): y speed
%     del_t (float): time step
%     max_t (float): maximum time for simulation
%     R (4x4 array): covariance of process
% On output:
%     trace (kx4 array): state trace
%       trace(i,:): state vector at step i
% Call:
%     tr = CS5320_const_vel(0,0,1,0,0.1,2,0.0001*eye(4));
% Author:
%     Clinton Fernandes
%     UU
%     Spring 2016
%

trace = [x0, y0, vx0, vy0];

for t = del_t:del_t:max_t
    A = [1 0 del_t 0; 0 1 0 del_t;0 0 1 0; 0 0 0 1];
    temp = A*[x0; y0; vx0; vy0] + mvnrnd(zeros(1,size(R,2)),R)';
    trace = [trace; temp'];
    
    x0 = temp(1);
    y0 = temp(2);
    vx0 = temp(3);
    vy0 = temp(4);
end