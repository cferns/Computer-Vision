load ht_im

ht_im_pts = CS5320_range2pts(ht_im);
ht_im_normals = CS5320_normals(ht_im_pts,2);
ht_im_planes = CS5320_planes(ht_im_pts,ht_im_normals,2);
topo = CS5320_topo(ht_im_pts,ht_im_normals,ht_im_planes,2);

load gt
for i = 1:7
    close all;
    figure; imagesc(gt == i); colormap gray;
    xlabel (['imagesc(gt == ' num2str(i) ' )']);
    figure;imagesc(topo(:,:,i)); colormap gray
    xlabel (['imagesc(topo(:,:, ' num2str(i) ' ))']);
end

endLine = 0;
