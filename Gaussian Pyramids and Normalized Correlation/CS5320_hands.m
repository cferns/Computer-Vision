function hands = CS5320_hands(im)
% CS5320_hands - find hands of surrender in image
% On input:
%     im (mxn array): image
% On output:
%     hands (mxnx3 array): rgb image of original with hands outlined
%     in red
% Call:
%     hands = CS5320_hands('s1.jpg');
% Author:
%     Clinton Fernandes
%     UU
%     Spring 2016
%
tic
im = imread(im);
cim = im;
img = rgb2gray(im);

T = zeros(23,15);
T(6:23,6:10) = 1;

G = fspecial('gaussian',7,2);
Lap = fspecial('laplacian',1);
LoG = filter2(Lap,G);
img =filter2(LoG, double(img));

Ipyr = CS5320_G_pyramid(img,1,1);
Tpyr = CS5320_G_pyramid(T,1,1);

for imNUM = 1:size(Ipyr,3);
    
    unpad_im = Ipyr(:,:,imNUM);
    if imNUM > 1
        unpad_im = unpad_im(1 : size(unpad_im,1) / 2^(imNUM-1),...
            1 : size(unpad_im,2) / 2^(imNUM-1));
    end
    
    unpad_T = Tpyr(:,:,imNUM);
    if imNUM > 1
        unpad_T = unpad_T(1 : size(unpad_T,1) / 2^(imNUM-1),...
            1 : size(unpad_T,2) / 2^(imNUM-1));
    end
    
    C = CS5320_normcorr(unpad_T,unpad_im);
    
    correct = 1;
    if imNUM>1
        correct = 2*(imNUM-1);
    end
    
    ct = C(:);
    ct = sort(ct);
    numX = round(0.9975*size(ct,1));
    threshold = ct(numX);
    [rows, cols] = size(C);
    for i = 1:rows
        for j = 1: cols
            if (C(i,j)>threshold) & unpad_im(i,j)<150 & i<size(unpad_im,1)/2
                m= correct*i;
                n= correct*j;
                %cim(m-3:m+3,n+3:n+3,1)=255;
                %cim(m+3:m+3,n-3:n+3,1)=255;
                %cim(m-3:m+3,n-3:n-3,1)=255;
                %cim(m-3:m-3,n-3:n+3,1)=255;
                cim(m,n,1) = uint8(255);% cim(m,n,2) = uint8(0); cim(m,n,3) = uint8(0);
                cim(m-2:m+2,n-2:n+2,1)=255;cim(m-2:m+2,n-2:n+2,2)=cim(m,n,2)/2;cim(m-2:m+2,n-2:n+1,3)=cim(m,n,3)/2;
            end
        end
    end
    hands = cim;
end
clocked = toc