function planes = CS5320_planes_LS(points,normals,k)
% CS5320_planes - find best plane fit at each pixel
% On input:
%      points (mxnx3 array): x,y,z points
%      normals (mxnx3 array): surface normal at each point
%      k (int): uses 2k+1 by 2k+1 window to fit plane
% On output:
%      planes (mxnm5 array): plane parameters and error of fit
%        channels 1-4: a,b,c,d plane parameters
%        channel 5: mean error of fit in window
% Call:
%      im_pl = CS5320_planes_LS(im_xyz,im_nor,2);
% Author:
%      Clinton Fernandes
%      UU
%      Spring 2016
%

[rows, cols, planes] = size(points);
n = (2*k+1)^2;
planes = zeros(rows,cols,5);

for i = 8+125+1+k:rows-k
    for j = 11+1+k:cols-k
        %initialize to zeros
        x = zeros((2*k+1)^2,1);
        y = zeros((2*k+1)^2,1);
        z = zeros((2*k+1)^2,1);
        
        %get xyz values of neighbourhood
        x_mat = points(i-k:i+k,j-k:j+k,1);
        x = x_mat(:);
        y_mat = points(i-k:i+k,j-k:j+k,2);
        y = y_mat(:);
        z_mat = points(i-k:i+k,j-k:j+k,3);
        z = z_mat(:);
        
        %find A matrix
        A11 = mean(x.^2) - mean(x)^2;
        A12 = mean(x.*y) - mean(x)*mean(y);
        A13 = mean(x.*z) - mean(x)*mean(z);
        A21 = A12;
        A22 = mean(y.^2) - mean(y)^2;
        A23 = mean(y.*z) - mean(y)*mean(z);
        A31 = A13;
        A32 = A23;
        A33 = mean(z.^2) - mean(z)^2;
        A = [A11 A12 A13; A21 A22 A23; A31 A32 A33];
        
        %solve eigen value problem
        [V,D] = eigs(A);
        
        %minimum Eigenvalues/vectors
        d_tid = [D(1,1) D(2,2) D(3,3)];
        id  = find(d_tid == min(d_tid));
        if size(id,2) ~= 1
            id = id(1,1);
        end
        
        %abcd coeficients of xyz plane equation
        planes(i,j,1) = V(1,id);
        planes(i,j,2) = V(2,id);
        planes(i,j,3) = V(3,id);
        planes(i,j,4) = -planes(i,j,1)*mean(x) - planes(i,j,2)*mean(y)...
            - planes(i,j,3)*mean(z);
        
        s = 0;
        for iC = 1:n;
            s = s + (planes(i,j,1)*x(iC) + planes(i,j,2)*y(iC)...
                + planes(i,j,3)*z(iC) + planes(i,j,4))^2;
        end
        planes(i,j,5) = s;
        
    end
end