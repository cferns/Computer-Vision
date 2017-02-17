function v = CS5320_extract_data(im,r1,c1,r2,c2,channels)
% CS5320_extract_data - pulls segment of data from image
% On input:
%      im (mxnxp array): p-dimensional array
%      r1 (int): row value of first pixel
%      c1 (int): col value of first pixel
%      r2 (int): row value of second pixel
%      c2 (int): col value of second pixel
%      channels (1xk vector): channel indexes to extract
% On output:
%      v (qxs array): extracted data from channels on the segment
%        from [r1,c1] to [r2,c2]
%        q is the number of pixels from [r1,c1] to [r2,c2]
%        s is the number of channels extracted
% Call:
%      ht_im_pts = CS5320_range2pts(ht_im);
%      v = CS5320_extract_data(ht_im_pts,51,21,51,27,[1:3]);

% Author:
%      Clinton Fernandes
%      UU
%      Spring 2016
%

s = size(channels,2);

STEP = 0.1;

temp_im = zeros(max(r1,r2),max(c1,c2));%to track visited rows, columns 

for ch = 1:s
	v(1,ch) = im(r1,c1,channels(1,ch));
end

breakLoop = 0;
r = r1;
c = c1;
temp_im(r1,c1) = 1;%set check_image r1,c1 value to 1
theta = posori(atan2(r2-r1,c2-c1));%angle of r1,c1 to r2,c2
d_row = STEP*sin(theta);%set step increment for row direction
d_col = STEP*cos(theta);%set step increment for column direction
dist_1_2 = norm([r1;c1]-[r2;c2]);%distance betn r1c1 and r2c2
while breakLoop==0%to break loop when required
    r = r + d_row;%new row to check
    c = c + d_col;%new column to check
    d = norm([r1;c1]-[r;c]);%distance between new rc to r1c1
    if d>dist_1_2%if distance betn current rc and r1c1 is more than max_dist
        breakLoop = 1;%here, break the loop
    else
        ri = max(1,floor(r));%lowest integer for row
        ci = max(1,floor(c));%lowest integer for column
        if temp_im(ri,ci)==0%if image rc position havn't been checked
            temp_im(ri,ci) = 1;%set image check position to 1
            temp_v = zeros(1,s);
            for ch = 1:s
                temp_v(1,ch) = im(ri,ci,channels(1,ch));
            end
            v = [v;temp_v];
        end
    end
end
if temp_im(r2,c2)==0%if r2c2 position of temp_im  is not checked
	temp_v = zeros(1,s);
	for ch = 1:s
        temp_v(1,ch) = im(r2,c2,channels(1,ch));
	end
	v = [v;temp_v];
end