function topo = CS5320_topo_fromfitplanes(points,normals,planes,k)
% CS5320_topo - determine topo classes of range image
% On input:
%      points (mxnx3 array): x, y, and z channel range image
%      normals (mxnm3 array): normals at each point
%      planes (mxnx5 array): plane info at each point (a,b,c,d,err)
%      k (int): uses 2k+1 by 2k+1 window
% On output:
%      topo (mxnx7 array): topo class likelihoods (in range [0,1])
%        channel 1: FLAT
%        channel 2: PEAK
%        channel 3: PIT
%        channel 4: RIDGE
%        channel 5: RAVINE
%        channel 6: HILLSIDE
%        channel 7: JUMP_EDGE
% Call:
%      topo = CS5320_topo(ht_im_pts,ht_im_normals,ht_im_planes,2);
% Author:
%      Clinton Fernandes
%      UU
%      Spring 2016
%

[rows,cols,dummy] = size(planes);
topo = zeros(rows,cols,7);
sz = 2*k+1;
temp_im = zeros(rows,cols);


depth = zeros(rows,cols);
for x = 1:cols
    for y = 1:rows
        rw = rows - y+1;
        cl = x;
        a = planes(rw,cl,1);
        b = planes(rw,cl,2);
        c = planes(rw,cl,3);
        d = planes(rw,cl,4);
        z = -(a*x + b*y + d)/c;
        if isnan(z)
            continue; 
        end
        depth(rw,cl) = z;
    end
end

topo(:,:,7) = edge(depth,'canny');


for i = 1+k:rows-k
    for j = 1+k:cols-k
        
        %JUMP_EDGEs are found, skip these pixels
        if topo(i,j,7) == 1
            continue;
        end
        
        %to extract 4 lines at 0,90,45,135;can also use CS5320_extract_data
        h90 = depth(i-k:i+k,j)';
        h0 = depth(i,j-k:j+k);
        temp_mat = depth(i-k:i+k,j-k:j+k);
        h135 = diag(temp_mat)';
        h45 = temp_mat(sz:sz-1:end-1);
        
        %FLAT
        [p0,s0] = polyfit([1:length(h0)],h0,1);
        [p90,s90] = polyfit([1:length(h90)],h90,1);
        [p45,s45] = polyfit([1:length(h45)],h45,1);
        [p135,s135] = polyfit([1:length(h135)],h135,1);   
        er = 1e-5;
        if (s0.normr < er) && (s90.normr < er) && (s45.normr < er)...
                && (s135.normr < er)
            topo(i,j,1) = 1;
            continue;
        end
        
        %PEAK
        if h90(k+1)>h90(end) && h90(k+1)> h90(1) && ...
                h45(k+1)>h45(end) && h45(k+1)> h45(1) && ...
                h135(k+1)>h135(end) && h135(k+1)> h135(1) && ...
                h0(k+1)>h0(end) && h0(k+1)> h0(1)
            topo(i,j,2) = 1;
            continue;
        end
        
        %PIT
        if h90(k+1)<h90(end) && h90(k+1)<h90(1) && ...
                h45(k+1)<h45(end) && h45(k+1)<h45(1) && ...
                h135(k+1)<h135(end) && h135(k+1)<h135(1) && ...
                h0(k+1)<h0(end) && h0(k+1)<h0(1)
            topo(i,j,3) = 1;
            continue;
        end
        
        %RIDGE
        if (s0.normr < er) && h90(k+1)>h90(end) && h90(k+1)>h90(1) && ...
                h45(k+1)>h45(end) && h45(k+1)>h45(1) && ...
                h135(k+1)>h135(end) && h135(k+1)>h135(1)
            topo(i,j,4) = 1;
            continue;
        end
        
        if (s90.normr < er) && h45(k+1)>h45(end) && h45(k+1)>h45(1) && ...
                h135(k+1)>h135(end) && h135(k+1)>h135(1) && ...
                h0(k+1)>h0(end) && h0(k+1)> h0(1)
            topo(i,j,4) = 1;
            continue;
        end
        
        if (s45.normr < er) && h90(k+1)>h90(end) && h90(k+1)>h90(1) && ...
                h135(k+1)>h135(end) && h135(k+1)>h135(1) && ...
                h0(k+1)>h0(end) && h0(k+1)>h0(1)
            topo(i,j,4) = 1;
            continue;
        end
        
        if (s135.normr < er) && h90(k+1)>h90(end) && h90(k+1)>h90(1) && ...
                h45(k+1)>h45(end) && h45(k+1)>h45(1) && ...
                h0(k+1)>h0(end) && h0(k+1)>h0(1)
            topo(i,j,4) = 1;
            continue;
        end
        
        %RAVINE
        if (s0.normr < er) && h90(k+1)<h90(end) && h90(k+1)<h90(1) && ...
                h45(k+1)<h45(end) && h45(k+1)<h45(1) && ...
                h135(k+1)<h135(end) && h135(k+1)<h135(1)
            topo(i,j,5) = 1;
            continue;
        end
        
        if (s90.normr < er) && h45(k+1)<h45(end) && h45(k+1)< h45(1) && ...
                h135(k+1)<h135(end) && h135(k+1)< h135(1) && ...
                h0(k+1)<h0(end) && h0(k+1)< h0(1)
            topo(i,j,5) = 1;
            continue;
        end
        
        if (s45.normr < er) && h90(k+1)<h90(end) && h90(k+1)<h90(1) && ...
                h135(k+1)<h135(end) && h135(k+1)<h135(1) && ...
                h0(k+1)<h0(end) && h0(k+1)<h0(1)
            topo(i,j,5) = 1;
            continue;
        end
        
        if (s135.normr < er) && h90(k+1)<h90(end) && h90(k+1)<h90(1) && ...
                h45(k+1)<h45(end) && h45(k+1)<h45(1) && ...
                h0(k+1)<h0(end) && h0(k+1)<h0(1)
            topo(i,j,5) = 1;
            continue;
        end
               
        %HILLSIDE
        topo(i,j,6) = 1;

    end
end
