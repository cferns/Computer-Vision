function [meanRGB, covarRGB, RGBstore] = mean_covar_of_pixels()

load A10_data;

% imagesc(Falling_Ball(50).cdata);
% [piXcol, piXrow] = ginput;
% piXcol = round(piXcol);
% piXrow = round(piXrow);

%[rows,cols,planes] = size(Falling_Ball(50).cdata);

piXcol=[158;159;160;160;159;158;158;159;160];
piXrow=[162;162;162;163;163;163;164;164;164];
sumImg = zeros(1,3);
meanRGB = zeros(1,3);
covarRGB = zeros(1,3);
RGBstore = zeros(size(piXcol,1),3);

for i = 1:size(piXcol,1)
    for k = 1:3
        a = sumImg(1,k);
        b = double(Falling_Ball(50).cdata(piXrow(i),piXcol(i),k));
        sumImg(1,k) =  a+b;
        RGBstore(i,k) = double(Falling_Ball(50).cdata(piXrow(i),piXcol(i),k));
    end
end

meanRGB = sumImg/size(piXcol,1);
% covarRGB(1,1) = cov(RGBstore(:,1));
% covarRGB(1,2) = cov(RGBstore(:,2));
% covarRGB(1,3) = cov(RGBstore(:,3));
covarRGB = cov(RGBstore);