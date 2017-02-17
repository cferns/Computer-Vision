function CS5320_change_in_sigma()
% CS5320_run_test_in - get statistics on intrinsic parameters
% On output:
%       plot of mean error in paraameter vs varying sigma
% Call:
%     change_in_sigma();
% Author:
%     Clinton Fernandes
%     UU
%     Spring 2016
%

a=[];
b=[];
c=[];
d=[];
e=[];
f=[];
g=[];
for i = 0:0.1:0.9
    [results,error] = CS5320_run_test_in((i),100);
    a=[a results(1,1)];
    b=[b results(2,1)];
    c=[c results(3,1)];
    d=[d results(4,1)];
    e=[e results(5,1)];
    f=[f results(6,1)];
    g=[g results(7,1)];
end
figure
hold on;
plot(a,'-.k');
plot(b,'-*b');
plot(c,'r-*');
plot(d,'-+k');
plot(e,'g-*');
plot(f,'bo-');
plot(g),'b[]-';
hold off;