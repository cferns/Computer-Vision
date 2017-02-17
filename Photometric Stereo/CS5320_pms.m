function [rho,N,g,f] = CS5320_pms(I,S)
% CS5320_pms - recover surface properties using photometric stereo
% On input:
% I (nxnxk array): k nxn images of surface
% S (nx3 array): light source vectors
% On output:
% rho (nxn array): albedo values of surface
% N (nxnx3 array): surface normals
% g (nxnx3 array): surface description ( =  rho*N)
% f (xnx array): height map
% Call:
% Q  =  CS5320_ps_sphere(60);
% S1  =  [0,0,1];
% I1  =  CS5320_ps_render(Q,S1);
% S2  =  [0.7,0.7,1];
% S2  =  S2/norm(S2);
% I2  =  CS5320_ps_render(Q,S2);
% S3  =  [-0.7,-0.7,1];
% S3  =  S3/norm(S3);
% I3  =  CS5320_ps_render(Q,S3);
% S4  =  [0.7,-0.7,1];
% S4  =  S4/norm(S4);
% I4  =  CS5320_ps_render(Q,S4);
% S5  =  [-0.7,0.7,1];
% S5  =  S5/norm(S5);
% I5  =  CS5320_ps_render(Q,S5);
% S  =  [S1;S2;S3;S4;S5];
% I(:,:,1)  =  I1;
% I(:,:,2)  =  I2;
% I(:,:,3)  =  I3;
% I(:,:,4)  =  I4;
% I(:,:,5)  =  I5;
% [rho,N,G,f]  =  CS5320_pms(I,S);
% Author:
% <Clinton_Fernandes>
% UU
% Spring 2016


MIN_INTENSITY = 0.01;
[num_rows,num_cols,num_planes] = size(I);
HEIGHT = num_cols/2;
MID_ROW = round(num_rows/2);
MID_COL = round(num_cols/2);
g = zeros(num_rows,num_cols,3);
N = zeros(num_rows,num_cols,3);
rho = zeros(num_rows,num_cols);
f = zeros(num_rows,num_cols);
f_temp = zeros(num_rows,num_cols);
p = zeros(num_rows,num_cols);
q = zeros(num_rows,num_cols);

for i = 1:num_rows
    for j = 1:num_cols
        i_temp = [];
        S_temp = [];
        for k = 1:num_planes
            if I(i,j,k) > MIN_INTENSITY
                i_temp = [i_temp,I(i,j,k)];
                S_temp = [S_temp;S(k,:)];
            end
        end
        if length(i_temp) >= 3
            g_temp = S_temp\i_temp';
            g(i,j,1) = g_temp(1,1);
            g(i,j,2) = g_temp(2,1);
            g(i,j,3) = g_temp(3,1);
        
            rho(i,j) = norm(g_temp);

            N(i,j,1) = g(i,j,1)/rho(i,j);
            N(i,j,2) = g(i,j,2)/rho(i,j);
            N(i,j,3) = g(i,j,3)/rho(i,j);
            
            p(i,j) = N(i,j,1)/N(i,j,3);
            q(i,j) = N(i,j,2)/N(i,j,3);
        end
    end
end

f(MID_ROW,MID_COL) = (max(max(p))+max(max(p)))/2;
for i  =  (MID_ROW-1):-1:1
    f(i,MID_COL) = f(i+1,MID_COL)-q(i,MID_COL);
end
for i  =  (MID_ROW+1):num_rows
    f(i,MID_COL) = f(i-1,MID_COL)+q(i,MID_COL);
end

for i  =  1:num_rows
    for j =  (MID_COL-1):-1:1
        f(i,j) = f(i,j+1)+p(i,j);
    end
    for j =  (MID_COL+1):num_rows
        f(i,j) = f(i,j-1)-p(i,j);
    end
end