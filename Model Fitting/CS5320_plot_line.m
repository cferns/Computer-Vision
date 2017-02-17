function CS5320_plot_line(p,x1,x2,y1,y2)
% CS5320_plot_line - plots line given parameters
% On input:
%    p (1x3 vector): line parameters (p(1)x + p(2)y + p(3) = 0)
%     x1 (float): first x value
%    x2 (float): second x value
%      if x1 ˜= x2, then plot line from x1 to x2 (calculate y1 and
%      y2)
%    y1 (float): first y value
%    y2 (float): second y value
%      if x1==x2, then plot line from y1 to y2 (calculate x1 and x2)
% On output:
%    plot line
% Call:
%     CS5320_plot_line(p1,0,7,0,0);
% Author:
%    Clinton Fernandes
%    UU
%    Spring 2016
%

if x1 == x2
    x = [];
    y = [];
    for y_tmp = y1:y2
        x_tmp = (-p(1,2)*y_tmp - p(1,3))/p(1,1);
        x = [x;x_tmp];
        y = [y;y_tmp];
        plot(x_tmp,y_tmp,'b*-');
    end
else
    x = [];
    y = [];
    for x_tmp = x1:x2
        y_tmp = (-p(1,1)*x_tmp - p(1,3))/p(1,2);
        x = [x;x_tmp];
        y = [y;y_tmp];
    end
end

%hold on;
plot(x,y,'LineWidth',1);
hold off;

