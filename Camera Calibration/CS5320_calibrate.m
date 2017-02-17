function [alpha,beta,theta,x0,y0,R,t] = CS5320_calibrate(im,P)
% CS5320_calibrate - determine camera parameters
% On input:
%     im (3xk array): image points (homogeneous coords)
%     im(1,:): x coords; im(2,:): y coords
%     P (4xk array): world coordinates (homogeneous coords)
%     P(1,:): x coords; P(2,:): y coords; P(3,:): z coords
% On output:
%     alpha (float): scale parameter in x
%     beta (float): scale parameter in y
%     theta (float): camera skew angle
%     x0 (float): x coord of optical center
%     y0 (float): y coord of optical center
%     R (3x3 array): rotation matrix
%     t (3x1 vector): translation vector
% Call:
%     load 'A35Fernandes';
%     [alpha,beta,theta,x0,y0,R,t] = CS5320_calibrate(pts_im,pts_world);
% Author:
%     Clinton Fernandes
%     UU
%     Spring 2016

[dummy,im_size] = size(im);
P_eqs=[];pwd

for i = 1:im_size
    temp_eq_x = zeros(1,12);
    temp_eq_y = zeros(1,12);
    temp_eq_x = [P(1,i),P(2,i),P(3,i),1,0,0,0,0,-im(1,i)*P(1,i),...
        -im(1,i)*P(2,i),-im(1,i)*P(3,i),-im(1,i)];
    temp_eq_y = [0,0,0,0,P(1,i),P(2,i),P(3,i),1,-im(2,i)*P(1,i),...
        -im(2,i)*P(2,i),-im(2,i)*P(3,i),-im(2,i)];
    P_eqs = [P_eqs;temp_eq_x;temp_eq_y];
end

[V,D] = eigs(P_eqs'*P_eqs,12);
[V_old,indexes] = sort(diag(D));
index=indexes(1);
M = [V(1:4,index)';V(5:8,index)';V(9:12,index)'];
M=M/norm(M(3,1:3));

p_temp=zeros(3,1);
p_temp=M*P(:,1);
if (p_temp(3,1))>0
    M=(-1)*M;
end
    
a = M(1:3,1:3);
b = M(1:3,4);

a1 = a(1,:);
a2 = a(2,:);
a3 = a(3,:);

eps=1;
rho = eps/norm(a3);
r3 = rho*a3;
x0 = rho^2*dot(a1,a3);
y0 = rho^2*dot(a2,a3);
theta = acos(-dot(cross(a1,a3),cross(a2,a3))/(norm(cross(a1,a3))*...
    norm(cross(a2,a3))));
alpha=rho^2*norm(cross(a1,a3))*sin(theta);
beta=rho^2*norm(cross(a2,a3))*sin(theta);
r1=cross(a2,a3)/norm(cross(a2,a3));
r2=cross(r3,r1);
K=[alpha,-alpha*cot(theta), x0; 0, beta/sin(theta),y0;0,0,1];
t=rho*K^(-1)*b;
R=[r1;r2;r3];
T=[R t; 0 0 0 1];
Tinv=T^(-1);
R=Tinv(1:3,1:3);
t=Tinv(1:3,4);