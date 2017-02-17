function lines = CS5320_Hough_lines2(im,H,thresh)
% CS5320_Hough_lines2 - produce mask with lines
% On input:
%     im (mxn array): gray level image
%     H (rxt array): Hough accumulator (from CS5320_Hough)
%     thresh (int): minumum number of votes for line
% On output:
%     lines (mxn array): lines mask (gray is line number)
% Call:
%     lines = CS5320_Hough_lines2(hall4g,H4,70);
% Author:
%     T. Henderson
%     UU
%     Spring 2016
%

ZERO_THRESH = 0.001;
MAX_DIST = 0.6;

[num_rows,num_cols] = size(im);
lines = zeros(num_rows,num_cols);

[rhos,thetas] = find(H>=thresh);
max_val = ceil(sqrt(num_rows^2+num_cols^2));
rho_vals = [-max_val:max_val];
num_lines = length(rhos);
params = zeros(num_lines,3);

for l = 1:num_lines
    theta = (thetas(l)-1)*pi/180;
    params(l,1) = cos(theta);
    params(l,2) = sin(theta);
    params(l,3) = rho_vals(rhos(l));
end
wb = waitbar(0,'lines');
for r = 1:num_rows
    waitbar(r/num_rows);
    for c = 1:num_cols
        pt = [c,num_rows-r+1,1]';
        for p = 1:num_lines
            d = abs(params(p,:)*pt);
            if d<=MAX_DIST
                lines(r,c) = 1;
            end
        end
    end
end
close(wb);