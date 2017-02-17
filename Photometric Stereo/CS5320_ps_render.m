function im = CS5320_ps_render(Q,S)
% CS5320_ps_render - render images from surface model
% On input:
% Q (nxnx7 array): photometric stereo data (from CS5320_ps_sphere)
% S (3x1 vector): light source direction
% On output:
% im (nxn array): gray level image of surface with light source S
% Call:
% Q = CS5320_ps_sphere(60);
% I2 = CS5320_ps_render(Q,[0.8,0.8,1])
% Author:
% <Your name>
% UU
% Spring 2016

[num_rows,num_cols,num_planes] = size(Q);
im = zeros(num_rows,num_cols);
for i = 1: num_rows
    for j = 1: num_cols
        im(i,j) = Q(i,j,7)*[S(1,1),S(1,2),S(1,3)]*[Q(i,j,4);Q(i,j,5);Q(i,j,6)];
    end
end