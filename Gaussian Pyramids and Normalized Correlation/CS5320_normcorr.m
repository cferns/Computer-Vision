function C = CS5320_normcorr(T,im)
% CS5320_normcorr - normalized correlation
% On input:
%     T (pxq array): template T
%     im (nxm array): image
% On output:
%     C (nxm array): correlation coefficients in [-1,1]
% Call:
%     C = CS5320_normcorr(T,s1g);
% Author:
%     Clinton Fernandes
%     UU
%     Spring 2016
%

[rowsT, colsT] = size(T);
if mod(rowsT,2)==0
    T = [zeros(1,colsT);T];
end
[rowsT, colsT] = size(T);
if mod(colsT,2)==0
    T = [T,zeros(rowsT,1);];
end
[rowsT, colsT] = size(T);
[rows,cols] = size(im);
kr = round(rowsT/2)-1;
kc = round(colsT/2)-1;

big_im = zeros((rows+2*kr),(cols+2*kc));
[temp_rows,temp_cols]=size(big_im);
big_im(1+kr:rows+kr,1+kc:cols+kc)=im;
C_temp=zeros(temp_rows,temp_cols);
C = zeros(rows,cols);

T = double(T);
T = T - mean(T(:));

for i = 1+kr: temp_rows-kr
    	for j= 1+kc: temp_cols-kc
        temp_im = [];
        temp_im = big_im((i-kr):(i+kr),(j-kc):(j+kc));
        temp_im = double(temp_im);
        temp_im = temp_im - mean(temp_im(:));
        T = double(T);
        numerator = sum(sum(temp_im.*T));
        denominator = sqrt(sum(sum(temp_im.*temp_im))*sum(sum(T.*T)));
        if denominator == 0
            C_temp(i,j) = 0;
            continue;
        end
        C_temp(i,j) = numerator / denominator;
    end
end
C = C_temp(1+kr:temp_rows-kr,1+kc: temp_cols-kc);

clf=0;