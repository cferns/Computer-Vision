function patches = CS5320_corner_patches(im,k,w)
% CS5320_corner_patches - produce patches (see Alg. 5.2 text)
% On input:
%     im (mxn array): input image
%     k (float): scale parameter in Alg. 5.2
%     w (int): window size parameter for Harris function (called k)
% On output:
%   patches (px4 array): patch parameters
%     col 1: row center of patch (called x_c in text)
%     col 2: col center of patch (called y_c in text)
%     col 3: patch radius (called r in text)
%     col 4: orientation of patch (called theta in text)
% Call:
%     p = CS5320_corner_patches(im,4,2);
% Author:
%     Clinton Fernandes
%     UU
%     Spring 2016
%

tic
[rows,cols] = size(im);
angles = [20:20:180];
%Use harris Corner detector
R = CS5320_Harris(im,w);
% Find the corners or use all the points for R>threshold value from the
%   above function.
[rowsR,colsR] = size(R);
tempR = zeros(rowsR,colsR);
max_R_val = max(max(R))/5;

for i = 1:rowsR
    for j = 1:colsR
        if R(i,j)>max_R_val
            tempR(i,j) = R(i,j);
        end
    end
end
interest_pts = double(imregionalmax(tempR));

%Initialize the list of patches    like patches = zeros(1,4)???
patches = zeros(1,4);

%For each corner, do the following

kt = 21;
kt_half = round(kt/2)-1;

for i = 1+kt_half:rows-kt_half
    for j = 1+kt_half:cols-kt_half
        if interest_pts(i,j) == 1
            %Write xc and yc  as the location of that point.
            %i.e., initialize xc = __ and yc = __
            xc = j;
            yc = i;
            %Compute radius for this patch by using simple argmax of
            %   Lap(G)*im(xc,yc) at every sigma from 0.6:0.01:3.
            temp_im = im(i-kt_half:i+kt_half, j-kt_half:j+kt_half); %temp_im = im(i-3:i+3, j-3:j+3);
            s = [0.6:0.01:3];
            vals = zeros(1,length(s));
            for s_ind = 1:241
                %G = fspecial('gaussian',7,s(s_ind));
                %Lap = fspecial('laplacian',1);
                %T = filter2(Lap,G);
                T = (fspecial('log',kt,s(s_ind)));   %%checkkkkk
                C = abs(filter2(T,temp_im));
                vals(s_ind) = C(4,4);
            end
            sigmax = imregionalmax(vals);
            max_sig_index = find(sigmax);
            max_radius = s(max_sig_index)*sqrt(2);
            max_radius = max(max_radius); % to prevent multiple local max
            
            %Compute the orientation histogrmam H(Q) for the gradient
            %orientations within a radius k*r of (xc,yc). i.e., for all 
            %pixels surrounding (xc,yc) find the histogram.
            h_radius = ceil(k*max_radius);
            H = CS5320_gradient_histogram(im,i,j,h_radius,0,0.1);
            if norm(H) ==0
                break;
            end
            %minimum thresh = 0.1
            %Compute orientation of the patch by using simple aragmax of H(Q)
            Hmax = max(max(H));
            max_Q_index = find(H == Hmax);
            num_patches = size(max_Q_index,1);
            %If there are multiple theta that maximizes the histogram then
            %store one theta for a patch in the list corresponding to
            %(xc,yc) and store other theta for same (xc,yc) as new patch.
            %
            %Now attach a patch to patch list with (xc,yc,r,Q)
            %if multiple theta, attch multiple patches.
            temp_patch = zeros(1,4);
            for p_num = 1:num_patches
                temp_patch(1,1) = xc;
                temp_patch(1,2) = yc;
                temp_patch(1,3) = max_radius;
                temp_patch(1,4) = angles(1,max_Q_index(p_num,1));
                patches = [patches;temp_patch];
            end
        end
    end
end
patches(1,:) = [];
clocked_at = toc
%END_of_code