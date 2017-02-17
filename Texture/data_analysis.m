close all
load A7_tex
im = im_tex;

for cluster_num = 1:30
    p_im = CS5320_texture_params(im);
    [cl,el] = CS5320_k_means_texture(p_im,cluster_num);
    figure;
    imagesc(el);
    colormap prism;
    for class = 1:cluster_num
        combo(im_tex,el~=class);
        title(['Squares with similar textures for class' num2str(class) '.']) 
    end
end
