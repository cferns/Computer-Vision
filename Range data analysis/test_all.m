%function test_all

load ht_im
ht_im = ht_im(51:75,1:75); %use as test image

%CS5320_range2pts
ht_im_pts = CS5320_range2pts(ht_im);
%Verification for CS5320_range2pts
%d==1
rp_im1 = [1 2 3; 8 4 2; 5 3 2];
rp_im1_pts = CS5320_range2pts(rp_im1);
%d==3
rp_im3(:,:,1) = randn(3);
rp_im3(:,:,2) = randn(3);
rp_im3(:,:,3) = randn(3);
rp_im3_pts = CS5320_range2pts(rp_im3);

%CS5320_normals
ht_im_normals = CS5320_normals(ht_im_pts,2);
%Verify CS5320_normals
close all;
quiver3(ht_im_pts(:,:,1),ht_im_pts(:,:,2),ht_im_pts(:,:,3)...
    ,ht_im_normals(:,:,1),ht_im_normals(:,:,2),ht_im_normals(:,:,3));

%CS5320_extract_data
%v = CS5320_extract_data(ht_im_pts,51,21,51,27,[1:3]);
%Verification using test data
temp_im = round(randn(3)*10);
v = [];
v = CS5320_extract_data(temp_im,1,1,3,3,1);

%CS5320_planes
im_pl = CS5320_planes(ht_im_pts,ht_im_normals,2);
%CS5320_planes_LS
%im_pl = CS5320_planes_LS(ht_im_pts,ht_im_normals,2);
%verification of CS5320_planes
[rows,cols, planes] = size(ht_im_pts);
figure;hold on;
plot3(ht_im_pts(:,:,1),ht_im_pts(:,:,2),ht_im_pts(:,:,3),'g.');
for x = 1:cols
    for y = 1:rows
        rw = rows - y+1;
        cl = x;
        a = im_pl(rw,cl,1);
        b = im_pl(rw,cl,2);
        c = im_pl(rw,cl,3);
        d = im_pl(rw,cl,4);
        z = -(a*x + b*y + d)/c;
        if isnan(z)
            continue; 
        end
        plot3(x,y,z,'r.');
    end
end
axis equal;

endLine = 0;







