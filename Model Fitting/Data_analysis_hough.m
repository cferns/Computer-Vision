img = double(rgb2gray(imread('test_line.jpg')));
[H4,H4pts] = CS5320_Hough(double(img));
[rOr,cOr]  = find(H4==max(max(H4)));

sMat = [];
for sigma = 0:10:100
    img = img + randn(size(img))*sigma;
    [H4,H4pts] = CS5320_Hough(double(img));
    [r,c]  = find(H4==max(max(H4)));
    s1 = abs(cOr-c);
    sMat = [sMat;s1];
end
close all;
hold on;
plot(sMat);


