%
[x] = [1;2;4;4;5;4;6;5;8;7;9];
[y] = [1;3;3;4;5;6;5;6;7;9;9];
[p1,s1] = CV_total_LS(x,y);
CS5320_plot_line(p1,0,10,0,10);
hold on;
for i = 1:size(x,1)
    plot(x(i),y(i),'ro');
end
grid on;
hold off;
%

[x] = [1;2;4;4;5;4;6;5;8;7;9];
[y] = [1;3;3;4;5;6;5;6;7;9;9];
sMat = [];
for sigma = 0.1:0.1:1
    [x] = [x] + randn(size(x))*sigma;
    [y] = [y] + randn(size(y))*sigma;
    [p1,s1] = CV_total_LS([x],[y]);
    sMat = [sMat;s1];
end
close all;
hold on;
plot(sMat);