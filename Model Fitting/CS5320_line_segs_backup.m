function segments = CS5320_line_segs(ime,Hpts,min_len,hall4g)
% CS5320_line_segs - extract line segments from Hough info
% On input:
%    ime (mxn array): edge image (e.g., output of edge)
%    Hpts (txr array): Hough points array (see Cs5320_Hough)
%    min_len (int): minimum segment length
% On output:
%    segments (struct vector): segment info
%      (s).pts (kx2 array): row,col points in segment
%      (s).rho (int): rho parameter of line
%      (s).theta (float): theta parameter of line
%      (s).endpt1 (1x2 vector): one endpt of segment
%      (s).endpt2 (1x2 vector): other endpt of segment
% Call:
%    As = CS5320_line_segs(ime,H4pts,20);
% Author:
%     Clinton Fernandes
%     UU
%     Spring 2016
%

[rows,cols] = size(ime);
segments.pts = [];
segments.rho = [];
segments.theta = [];
segments.endpt1 = [];
segments.endpt2 = [];
s = 0;

[rowsH,colsH] = size(Hpts);
H = zeros(rowsH,colsH);

for i = 1:rowsH
    for j = 1:colsH
        H(i,j) = size(Hpts(i,j).pts,1);
    end
end

for i = 1:rowsH
    for j = 1:colsH
        if H(i,j) >= min_len
            s = s+1; %structure count
            segments(s).rho = (rowsH-1)/2+1-i;
            segments(s).theta = j-1;
            imTemp = zeros(rows,cols);
            for k = 1:H(i,j)
                imTemp(Hpts(i,j).pts(k,1),Hpts(i,j).pts(k,2)) = 1;
            end
            imDilate = imdilate(imTemp,ones(10));
            imErode = imerode(imDilate,ones(9));
            imThin = bwmorph(imErode,'thin');
            close all;
            
            CC = bwconncomp(imThin);
            maxSize=0;
            for i = 1:CC.NumObjects
                currSize = size(CC.PixelIdxList{1, i},1);
                if currSize >= maxSize
                    maxSize = currSize;
                    maxInd = i;
                end
            end
            line = CC.PixelIdxList{1, maxInd};
            
            im2tmp = zeros(rows,cols);
            for j = 1:maxSize
                ep = line(j);
                epC = ceil(ep/rows);
                epR = mod(ep,rows);
                if epR == 0
                    epR = rows;
                end
                %segments(s).pts = [segments(s).pts;[epR,epC]];
                im2tmp(epR,epC) = 1;
            end
            close all;%%%%
            combo(hall4g,im2tmp);%%%%%%%%%%
            endpointIm = bwmorph(im2tmp,'endpoints');
            hold on;%%%%%%%%%
            [rowE,colE] = find(endpointIm==1);
            plot(colE(1),rowE(1),'g*');%%%%%%%
            plot(colE(end),rowE(end),'g*');%%%%
            segments(s).endpt1 = [rowE(1),colE(1)];
            segments(s).endpt2 = [rowE(end),colE(end)];
            
            [ptsRows,ptsCols] = CS5320_line_between([rowE(1),colE(1)],[rowE(end),colE(end)]);
            segments(s).pts = [segments(s).pts;[ptsRows',ptsCols']];
        end
    end
end