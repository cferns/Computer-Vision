function lines = CS5320_Hough_draw_pts(im,H,pts,n,dr)
% CS5320_Hough_draw_pts - draws points which contributed to line
% On input:
%    im (mxn array): original image (or edge image)
%    H (rxt array): Hough accumulator array (see CS5320_Hough)
%    pts (rxt struct): record of points in Hough accumulator
%    n (int): number of lines to show (sorted by most points)
%    dr (Boolean): 1 means draw, 0 don’t
% On output:
%    lines (mxn array): mask of n lines
% Call:
%    linesp = CS5320_Hough_draw_pts(hall4g,H4,H4pts,10,1);
% Author:
%    T. Henderson
%    UU
%    Spring 2016
%

lines = zeros(size(im));

[rhos,thetas] = find(H>=0.0);

HsizeMat = zeros(size(rhos,1),1);
for i = 1:size(rhos,1);
	HsizeMat(i,1) = size(pts(rhos(i),thetas(i)).pts,1);
end

Hmaxval = max(HsizeMat);
linesDrawn = 0;

while(1)
    currHMaxLocns = find(HsizeMat == Hmaxval);
    if isempty(currHMaxLocns) == 1
        Hmaxval = Hmaxval-1;
        continue;
    end
    
    for k = 1: size(currHMaxLocns);
        currLinePts = pts(rhos(currHMaxLocns(k)),thetas(currHMaxLocns(k)));
        linesDrawn = linesDrawn+1;
        for m = 1:size(currLinePts.pts,1)
            lines(currLinePts.pts(m,1),currLinePts.pts(m,2)) = linesDrawn;
        end
        
        if linesDrawn == n
            break;
        end
    end
    
    if linesDrawn == n
        break;
    end
    
    Hmaxval = Hmaxval-1;
end

%to draw or not
if dr ==1
    for lview = 1:n
        prompt = '**Press Enter key to draw points of next line';
        dummy = input(prompt);
        combo(im,lines==lview);
    end
    
end