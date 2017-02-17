load scene1
ht_im = imaq_struct.depthImage;
% h = fspecial('gaussian', 5, 2);
% ht_im = filter2(h,ht_im);

ht_im_pts = CS5320_range2pts(ht_im);
ht_im_normals = CS5320_normals(ht_im_pts,2);
ht_im_planes = CS5320_planes_LS(ht_im_pts,ht_im_normals,2);
%ht_im_planes = CS5320_planes_LS(ht_im_pts,ht_im_normals,2);

tic
topo = CS5320_topo(ht_im_pts,ht_im_normals,ht_im_planes,2);
%topo = CS5320_topo_fromfitplanes(ht_im_pts,ht_im_normals,ht_im_planes,2);
clockedAt =  toc
for i = 1:7
    figure;imagesc(topo(:,:,i)); colormap gray
    xlabel (['imagesc(topo(:,:, ' num2str(i) ' ))']);
end

endLine = 0;
