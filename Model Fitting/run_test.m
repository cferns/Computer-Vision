%Verify for CV_total_LS and CS5320_plot_line
%[x,y] = ginput();
x=0;y=0;
[p1,s1] = CV_total_LS(x,y);
CS5320_plot_line(p1,0,7,0,0);
hold on;
for i = 1:size(x,1)
    plot(x(i),y(i),'ro');
end
grid on;
hold off;

%Verify CS5320_Hough_lines
close all;
lineIm = rgb2gray(imread('test_line.jpg'));
[HL,HLpts] = CS5320_Hough(double(lineIm));
lines = CS5320_Hough_lines(lineIm,HL,0.6*max(max(HL)));
figure; combo(lineIm,lines);

%Verify CS5320_Hough_lines
close all;
square = rgb2gray(imread('testSquare.jpg'));
[H4,H4pts] = CS5320_Hough(double(square));
lines = CS5320_Hough_lines(square,H4,0.6*max(max(H4)));
figure; combo(square,lines);

%Verify CS5320_Hough_lines
close all;
hall4g = rgb2gray(imread('hall4.jpg'));
[H4,H4pts] = CS5320_Hough(double(hall4g));
lines = CS5320_Hough_lines(hall4g,H4,0.6*max(max(H4)));
figure; combo(hall4g,lines);

%Verify CS5320_Hough_draw_pts
testIm = zeros(50,50);
testIm(11:40,11:40) = 1;
[H2,H2pts] = CS5320_Hough(double(testIm));
linesp = CS5320_Hough_draw_pts(testIm,H2,H2pts,4,0);
figure; combo(testIm,linesp);

%Verify CS5320_Hough_draw_pts on hall
linesp = CS5320_Hough_draw_pts(hall4g,H4,H4pts,10,0);
figure; combo(hall4g,linesp);

%Verify CS5320_line_segs
img = rgb2gray(imread('test.jpg'));
ime = edge(img,'canny');
[Himg,Himgpts] = CS5320_Hough(double(img));
As = CS5320_line_segs(ime,Himgpts,0.3*max(max(Himg)));

[rows,cols] = size(img);
for i = 1:size(As,2)
    close all
    imDisp = zeros(rows,cols);
    for j = 1:size(As(i).pts,1);
        imDisp(As(i).pts(j,1),As(i).pts(j,2))=1;
        hold on;
    end
    combo(img,imDisp);
    hold on;
    plot(As(i).endpt1(2),As(i).endpt1(1),'g*');
    plot(As(i).endpt2(2),As(i).endpt2(1),'g*');
    hold off;
end

%Verify CS5320_line_segs
ime = edge(hall4g,'canny');
As = CS5320_line_segs(ime,H4pts,70);

[rows,cols] = size(hall4g);
for i = 1:size(As,2)
    close all
    imDisp = zeros(rows,cols);
    for j = 1:size(As(i).pts,1);
        imDisp(As(i).pts(j,1),As(i).pts(j,2))=1;
        hold on;
    end
    combo(hall4g,imDisp);
    hold off;
end

%Verify shapes
close all;
img = rgb2gray(imread('test.jpg'));
[H4,H4pts] = CS5320_Hough(double(img));
ime = edge(img,'canny');
segs = CS5320_line_segs(ime,H4pts,30);
Tt = CS5320_shapes(img);