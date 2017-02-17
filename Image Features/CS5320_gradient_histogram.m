function H = CS5320_gradient_histogram(im,r,c,radius,w,thresh)
% CS5320_gradient_histogram - get histogram of gradient orientations
% On input:
%     im (mxn array): image
%     r (int): row of center of patch
%     c (int): col of center of patch
%     radius (float): radius of pixels to consider
%     w (Boolean): use magnitude of gradient as weight in histogram
%     thresh (float): minimum gradient magnitude to consider
% On output:
%     H (9x1 vector): orientation counts in 20-degree bins
% Call:
%     H = CS5320_gradient_histogram(A,8,8,3,0,0.1);
% Author:
%     Clinton Fernandes
%     UU
%     Spring 2016
%

H = zeros(9,1);
angles = [20:20:180];

[rows,cols] = size(im);
top_r =r-radius;
down_r = r+radius;
left_c = c-radius;
rt_c = c+radius;
if (top_r<=0 || left_c<=0 || down_r>rows || rt_c>cols)
    return;
end

im_temp = im(top_r:down_r,left_c:rt_c); %(2*radius) or zeors(2*radius+1)
[rowst,colst] = size(im_temp);
[dx,dy] = gradient(double(im_temp));
ori = zeros(rowst,colst);
mag = zeros(rowst,colst);

for i = 1:rowst
    for j = 1:colst
        ori(i,j) = atan2d(dy(i,j),dx(i,j));
        if ori(i,j)<0
           ori(i,j) = ori(i,j) + 180; 
        end
        mag(i,j) = sqrt(dy(i,j)^2 + dx(i,j)^2);
    end
end

max_mag = max(max(mag));
for i = 1:rowst
    for j = 1:colst
        for k = 1:9
            curr_angle = angles(k);
            if ori(i,j) <= curr_angle
                if w == 1 & mag(i,j)>thresh*max_mag
                    H(k,1) = H(k,1)+mag(i,j);
                end
                if w == 0
                    H(k,1) = H(k,1)+1;
                end
                break;
            end
        end
	end
end


del= 0;
%[Gmag,Gdir] = imgradient(im_temp);