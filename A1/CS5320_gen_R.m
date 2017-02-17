function R = CS5320_gen_R(u,theta)
%R = CS5320_gen_R([0;0;1],pi/2);

ux = u(1,1);
uy = u(2,1);
uz = u(3,1);
C = cos(theta);
S = sin(theta);
t = 1-C;

R =[t*ux*ux+C,t*ux*uy-S*uz , t*ux*uz+S*uy;
    t*ux*uy+S*uz,t*uy*uy+C , t*uy*uz-S*ux;
    t*ux*uz-S*uy,t*uy*uz+S*ux , t*uz*uz+C];

