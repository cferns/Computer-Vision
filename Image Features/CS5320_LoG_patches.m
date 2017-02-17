function patches = CS5320_LoG_patches(im,k,p)
% CS5320_LoG_patches - produce patches (see Alg. 5.3 text)
% On input:
%     im (mxn array): input image
%     k (float): scale parameter in Alg. 5.2
%     p (float): p parameter from LoG interest function
% On output:
%   patches (px4 array): patch parameters
%     col 1: row center of patch (called x_c in text)
%     col 2: col center of patch (called y_c in text)
%     col 3: patch radius (called r in text)
%     col 4: orientation of patch (called theta in text)
% Call:
%     p = CS5320_LoG_patches(im,4,2);
% Author:
%     <Your name>
%     UU
%     Spring 2016
%

tic
[rows,cols] = size(im);
angles = [20:20:180];
%Use LoG_interest
[interest_pts,scale] = CS5320_LoG_interest(im,p);
%Initialize the list of patches    like patches = zeros(1,4)???
patches = zeros(1,4);

for i = 1:rows
    for j = 1:cols
        if interest_pts(i,j) == 1
            %Compute the orientation histogrmam H(Q) for the gradient
            %orientations within a radius k*r of (xc,yc). i.e., for all 
            %pixels surrounding (xc,yc) find the histogram.
            h_radius = ceil(k*scale(i,j));
            H = CS5320_gradient_histogram(im,i,j,h_radius,1,0.1);
            if norm(H) ==0
                break;
            end
            %minimum thresh = 0.1
            %Compute orientation of the patch by using simple aragmax of H(Q)
            Qmax = CS5320_local_max(H);
            max_Q_index = find(Qmax);
            num_patches = size(max_Q_index,1);
            %If there are multiple theta that maximizes the histogram then
            %store one theta for a patch in the list corresponding to
            %(xc,yc) and store other theta for same (xc,yc) as new patch.
            %
            %Now attach a patch to patch list with (xc,yc,r,Q)
            %if multiple theta, attch multiple patches.
            temp_patch = zeros(1,4);
            for p_num = 1:num_patches
                temp_patch(1,1) = j;
                temp_patch(1,2) = i;
                temp_patch(1,3) = scale(i,j);
                temp_patch(1,4) = angles(1,max_Q_index(p_num,1));
                patches = [patches;temp_patch];
            end
        end
    end
end
patches(1,:) = [];
clocked_at = toc
%END_of_code