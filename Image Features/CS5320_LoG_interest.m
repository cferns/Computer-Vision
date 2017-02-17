function [interest_pts,scale] = CS5320_LoG_interest(im,p)
% CS5320_LoG_interest - interest points from LoG scale-position maxima
% On input:
%     im (mxn array) gray level input image
%     p (float): percentage of max response to return
% On output:
%     interest_pts (mxn array): interest point response
%     scale (mxn array): max sigma scale at location
% Call:
%     [A_IP,A_scale] = CS5320_LoG_interest(A,0.9);
% Author:
%     T. Henderson
%     UU
%     Spring 2016
%

tic
[rows,cols] = size(im);
s = [0.6:0.01:3];
interest_pts = zeros(rows,cols);
old_scale = zeros(rows,cols);
scale = zeros(rows,cols);
temp_scale = zeros(rows,cols);
vals = zeros(rows,cols,length(s));
max_response = zeros(rows,cols);
new_max_response = zeros(rows,cols);

for s_ind = 1:length(s)
    T = fspecial('log', 21, s(s_ind));
    vals(:,:,s_ind) = abs(filter2(T,im));
end

for i = 1:rows
	for j = 1:cols
        max_response(i,j) = max(max(vals(i,j,:)));
        max_index = find(vals(i,j,:)== max_response(i,j));
        max_scale = s(max_index);
        if (max_scale == s(1) | max_scale == s(length(s)))
            max_response(i,j) = max_response(i,j)-1000; %neglect this point
            continue;
        end
        temp_scale(i,j) = max_scale*sqrt(2);
	end
end

MAX_RESP = max(max(max_response));

for i = 1:rows
	for j = 1:cols
        if max_response(i,j) > MAX_RESP*p
            old_scale(i,j) = temp_scale(i,j);
            new_max_response(i,j) = max_response(i,j);
        end
	end
end       

logic_scale = double(imregionalmax(new_max_response));

for i = 1:rows
	for j = 1:cols
        if logic_scale(i,j) ==1
            scale(i,j)=old_scale(i,j) ;
            interest_pts(i,j) = 1;
        end
	end
end
l=0
