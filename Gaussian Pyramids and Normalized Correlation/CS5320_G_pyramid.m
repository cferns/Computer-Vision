function G_pyramid = CS5320_G_pyramid(I, k, sigma)

% CS5320_G_pyramid - Gaussian pyramid image
% On input:
%     I (mxn array): input image
%     k (int): size of smoothing window (2k+1 by 2k+1 window)
%     sigma (float): sigma for Gaussian function (scale parameter)
% On output:
%     G_pyramid (mxnx5 array): 5 images (stored in upper left corner)
%     comprising Gaussian pyramid
% Call:
%     pyr = CS5320_G_pyramid(s1g,4,2); % 9x9 window with variance 2
% Method:
%     See Forsyth and Ponce, Chapter 5
% Author:
%     Clinton Fernandes
%     UU
%     Spring 2016
%

kernel_size = 2*k+1;
[rows,cols] = size(I);
big_im = zeros((rows+2*k),(cols+2*k));
[temp_rows,temp_cols]=size(big_im);
T = fspecial('gaussian', kernel_size, sigma);

G_pyramid = zeros(rows,cols,5);
G_pyramid(:,:,1)= I;

for plane = 2:5
    filter_big_im = zeros(temp_rows,temp_cols);
    big_im = zeros((rows+2*k),(cols+2*k));
    big_im(1+k:rows+k,1+k:cols+k)=I;
    for i = 1+k: temp_rows-k
        for j= 1+k: temp_cols-k
            temp_im = [];
            temp_im = big_im((i-k):(i+k),(j-k):(j+k));
            filter_big_im(i,j) = sum(sum(temp_im.*T));
        end
    end
    
    filter_im = filter_big_im(1+k:temp_rows-k,1+k: temp_cols-k);
    sampled_im = zeros(rows,cols);
    for i = 2:2:rows
        for j= 2:2:cols
            sampled_im(i/2,j/2)=filter_im(i,j);
        end
    end
    I=sampled_im;
    G_pyramid(:,:,plane)= sampled_im;
end 
    
clf = 0;