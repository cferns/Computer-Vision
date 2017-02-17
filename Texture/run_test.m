close all

load A7_tex
im = im_tex;

%im = rgb2gray(imread('test.jpg'));
p_im = CS5320_texture_params(im);

num_of_clusters = 2
[cl,el] = CS5320_k_means_texture(p_im,num_of_clusters);

% to show all the clusters in different colors
imagesc(el)
colormap jet;

for class = 1:num_of_clusters
    figure;
    combo(im_tex, el~=class);
end