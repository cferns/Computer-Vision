%function topo_data_analysis
clear all;
load ht_im

[rows,cols,dummy] = size(ht_im);

for sigma = 0.0001:0.00001:0.01
    
    ht_im_noise = ht_im + randn(rows,cols)*sigma;
    ht_im_pts = CS5320_range2pts(ht_im_noise);
    ht_im_normals = CS5320_normals(ht_im_pts,2);
    ht_im_planes = CS5320_planes(ht_im_pts,ht_im_normals,2);
    %ht_im_planes = CS5320_planes_LS(ht_im_pts,ht_im_normals,2);
        
    topo = CS5320_topo(ht_im_pts,ht_im_normals,ht_im_planes,2);
    %topo = CS5320_topo_fromfitplanes(ht_im_pts,ht_im_normals,ht_im_planes,2);

    for i = 1:7
        close all;
        figure; imagesc(gt == i); colormap gray;
        xlabel (['imagesc(gt == ' num2str(i) ' )']);
        figure;imagesc(topo(:,:,i)); colormap gray
        xlabel (['imagesc(topo(:,:, ' num2str(i) ' ))']);
    end
end



endLine = 0;
