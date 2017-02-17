function R = CS5320_Harris(im,k)
% CS5320_Harris - corner detector
% On input:
%     im (mxn array): input gray level image
%     k (int): determines window side as 2*k+1
% On output:
%     R (mxn array): corner response
%     <=0: homogeneous
%     >0 and small: edge
%     large: corner
% Call:
%     R = CS5320_Harris(im,1);
% Author:
%     T. Henderson
%     UU
%     Spring 2016
%

k_par = 0.05;
[rows,cols] = size(im);
[dx,dy] = gradient(double(im));
I = zeros(2,1);
R = zeros(rows,cols);

for i = 1+k:rows-k
    for j = 1+k:cols-k
        H = zeros(2,2);
        for m = i-k:i+k
            for n = j-k:j+k
                I = [dx(m,n);dy(m,n)];
                M = I*I';
                H = H+M;
            end
        end
        R(i,j) = det(H)- k_par*(trace(H)/2)^2;
    end
end




