function Q = CS5320_ps_sphere(size)
% CS5320_ps_sphere - generates photometric stereo data for checker sphere
%    on pp. 48-49 Forsythe and Ponce
% On input:
%     size (int): size of hieght image (pixels) [sphere radius is size/2]
% On output:
%     Q (sizexsizex7 array): complete info set for photometric stereo
%       (:,:,1): x values for height function
%       (:,:,2): y values for height function
%       (:,:,3): z values for height function
%       (:,:,4): x normal values for surface
%       (:,:,5): y normal values for surface
%       (:,:,6): z normal values for surface
%       (:,:,7): albedo value for forface
% Call:
%     Q = CS5320_ps_sphere(60);
% Author:
%     T. Henderson
%     UU
%     Spring 2016
%

radius = (size-1)/2;
Q = zeros(size,size,7);

for r = 1:size
    y = ((size-1)/2)-(r-1);
    for c = 1:size
        x = -((size-1)/2)+(c-1);
        if norm([x,y])<=radius
            Q(r,c,1) = x;
            Q(r,c,2) = y;
            z = sqrt(radius^2 - x^2 -y^2);
            Q(r,c,3) = z;
            rc_nor = [x,y,z]/norm([x,y,z]);
            Q(r,c,4) = rc_nor(1);
            Q(r,c,5) = rc_nor(2);
            Q(r,c,6) = rc_nor(3);
            if (x>=0 & y>=0) | (x<0 & y<0)
                Q(r,c,7) = 0.5;
            else
                Q(r,c,7) = 1.0;
            end
        end
    end
end
