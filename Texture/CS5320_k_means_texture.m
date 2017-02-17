function [clusters,elements] = CS5320_k_means_texture(params,k)

% CS5320_k_means_texture - classifies textures into k clusters
% On input:
%     im (mxnxp array): texture parameter images (p mxn images)
%     k (int): number of clusters desired
% On output:
%     clusters (kxp array): k cluster center vectors
%     elements (mxn array): cluster index image
%       elements(r,c) is cluster number
% Call:
%     [cl,el] = CS5320_k_means_texture(p_im,20);
% Author:
%     Clinton Fernandes
%     UU
%     Spring 2016
%

[rows,cols,planes] = size(params);
[IDX,C] = kmeans(reshape(params,[rows*cols,planes]),k);
IDX_im = reshape(IDX,[rows,cols]);
clusters = C;
elements = IDX_im;