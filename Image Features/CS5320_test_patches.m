function CS5320_test_patches(im,p)
% Call: CS5320_test_patches(im,p)

drawArrow = @(x,y) quiver( x(1),y(1),x(2)-x(1),y(2)-y(1),'r' ) ;
imshow(im);
hold on
[rows,cols] = size(im);
for i = 1:size(p)
	plot(p(i,1),p(i,2),'go')

    a = p(i,1) + p(i,3)*cosd(p(i,4));
    b = p(i,2) + p(i,3)*sind(p(i,4));
    x1 = [p(i,1) a];
    y1 = [p(i,2) b];
    drawArrow(x1,y1);
end