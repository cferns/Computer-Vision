function lines = CS5320_Hough_lines(im,H,thresh)
% CS5320_Hough_lines - produce mask with lines
% On input:
%     im (mxn array): gray level image
%     H (rxt array): Hough accumulator (from CS5320_Hough)
%     thresh (int): minumum number of votes for line
% On output:
%     lines (mxn array): lines mask (gray is line number)
% Call:
%     lines = CS5320_Hough_lines(hall4g,H4,70);
% Author:
%     T. Henderson
%     UU
%     Spring 2016
%

MIN_THETA = 45*pi/180;

[num_rows,num_cols] = size(im);
lines = zeros(num_rows,num_cols);

[rhos,thetas] = find(H>thresh);
[num_rhos,num_thetas] = size(H);
offset = ceil((num_rhos+1)/2);

if isempty(rhos)
    return
end

num_lines = length(rhos);

for l = 1:num_lines
    rho = rhos(l) - offset + 1;
    theta = (thetas(l)-1)*pi/180;
    sin_t = sin(theta);
    cos_t = cos(theta);
    if abs(theta)>MIN_THETA&abs(theta)<MIN_THETA+pi/2
        x1 = 0;
        done = 0;
        while done==0
            x1 = x1 + 1;
            y1 = round((rho-x1*cos_t)/sin_t);
            if y1>0&y1<=num_rows|x1==num_cols
                done = 1;
            end
        end
        x2 = num_cols+1;
        done = 0;
        while done==0
            x2 = x2 - 1;
            y2 = round((rho-x2*cos_t)/sin_t);
            if y2>0&y2<=num_rows|x2==1
                done = 1;
            end
        end
    else
        y1 = 0;
        done = 0;
        while done==0
            y1 = y1 + 1;
            x1 = round((rho-y1*sin_t)/cos_t);
            if x1>0&x1<=num_cols|y1==num_rows
                done = 1;
            end
        end
        y2 = num_rows+1;
        done = 0;
        while done==0
            y2 = y2 - 1;
            x2 = round((rho-y2*sin_t)/cos_t);
            if x2>0&x2<=num_cols|y2==1
                done = 1;
            end
        end
    end
    r1 = num_rows - y1 +1;
    c1 = x1;
    r2 = num_rows - y2 + 1;
    c2 = x2;
    try
    [lrows,lcols] = CS5320_line_between([r1,c1],[r2,c2]);
    catch err
        tch = 0;
    end
    lpts = [lrows',lcols'];
    pts = [];
    if ~isempty(lpts)
        indexes = find(lpts(:,1)>0&lpts(:,1)<=num_rows...
            &lpts(:,2)>0&lpts(:,2)<=num_cols);
        if ~isempty(indexes)
            pts(:,1) = lpts(indexes,1);
            pts(:,2) = lpts(indexes,2);
            if ~isempty(pts)
                num_pts = length(pts(:,1));
                for p = 1:num_pts
                    lines(pts(p,1),pts(p,2)) = l;
                end
            end
        end
    end
    tch = 0;
end
