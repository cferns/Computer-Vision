function test_all_functions

%Veifying CS5320_background_sub_tracking
clear all
load Bead_data% All 10 images of Bead motion  are stored in Bead_data
t_im = CS5320_background_sub_tracking(Bead);
imagesc(t_im(:,:,1)); colormap gray;
title 'Background Subtraction';
imagesc(t_im(:,:,4)); colormap gray;
title 'Background Subtraction'

% Verifying bead_tracking
track = CS5320_bead_tracking(t_im);
close all;imagesc(Bead(1).cdata);
hold on;
plot(track(:,2),track(:,1),'ro-');


%
load A10_data;
ims = Falling_Ball;






%Verifying constant velocity with zeros(4) and 3 different R
R = zeros(4);
R(3:4,3:4)=0;
tr = CS5320_const_vel(0,0,1,1,0.1,2,R);
close all;plot(tr(:,1),tr(:,2),'r.');

R = 0.001*eye(4);
R(3:4,3:4)=0;
tr = CS5320_const_vel(0,0,1,1,0.1,2,R);
hold on;plot(tr(:,1),tr(:,2),'k-*');

R = 0.01*eye(4);
R(3:4,3:4)=0;
tr = CS5320_const_vel(0,0,1,1,0.1,2,R);
hold on;plot(tr(:,1),tr(:,2),'b-o');

R = 0.1*eye(4);
R(3:4,3:4)=0;
tr = CS5320_const_vel(0,0,1,1,0.1,2,R);
hold on;plot(tr(:,1),tr(:,2),'b');
title 'variation of R'

%Verifying constant acceleration with 3 different R
R = 0.0000*eye(6);
R(5:6,5:6) = 0;
tr = CS5320_const_acc(0,0,0,0,9.8,9.8,0.1,2,R);
close all;plot(tr(:,1),tr(:,2),'r.');

R = 0.001*eye(6);
R(5:6,5:6) = 0;
tr = CS5320_const_acc(0,0,0,0,9.8,9.8,0.1,2,R);
hold on;plot(tr(:,1),tr(:,2),'k-*');

R = 0.01*eye(6);
R(5:6,5:6) = 0;
tr = CS5320_const_acc(0,0,0,0,9.8,9.8,0.1,2,R);
hold on;plot(tr(:,1),tr(:,2),'b-o');

R = 0.1*eye(6);
R(5:6,5:6) = 0;
tr = CS5320_const_acc(0,0,0,0,9.8,9.8,0.1,2,R);
hold on;plot(tr(:,1),tr(:,2),'b');


%Verifying kalman acceleration

%Verifying CS5320_const_acc_Kalman
clear all;
R = 0.0001*eye(6);
R(5:6,5:6) = 0;
Q = 0.0001*eye(2);
[ta,ty,te] = CS5320_const_acc_Kalman(0,0,0,0,0,-9.8,1/30,2.34,R,Q);
close all;plot(ta(:,1),ta(:,2),'r-o');
hold on;plot(ty(:,1),ty(:,2),'k-.');
hold on;plot(te(:,1),te(:,2),'b-*');
xlabel 'R = 0.0001, Q = 0.0001'
title 'Constant Acc. Kalman'
legend 'ta' 'ty' 'te'

R = 0.0001*eye(6);
R(5:6,5:6)=0;
Q = eye(2);
[ta,ty,te] = CS5320_const_acc_Kalman(0,0,0,0,0,-9.8,0.1,3,R,Q);
close all;plot(ta(:,1),ta(:,2),'r-o');
hold on;plot(ty(:,1),ty(:,2),'k-.');
hold on;plot(te(:,1),te(:,2),'b-*');
xlabel 'R = 0.0001, Q = 1'
title 'Constant Acc. Kalman'
legend 'ta' 'ty' 'te'

R = 0.1*eye(6);
R(5:6,5:6)=0;
Q = 0.0001*eye(2);
[ta,ty,te] = CS5320_const_acc_Kalman(0,0,0,0,0,-9.8,0.1,3,R,Q);
close all;plot(ta(:,1),ta(:,2),'r-o');
hold on;plot(ty(:,1),ty(:,2),'k-.');
hold on;plot(te(:,1),te(:,2),'b-*');
xlabel 'R = 0.1, Q = 0.0001'
title 'Constant Acc. Kalman'
legend 'ta' 'ty' 'te'

%Data analysis for CS5320_const_acc_Kalman
R = 0.0001*eye(6);
meanEr = [];
for k = 0:0.010:1 
    Q = k*eye(2);
    [ta,ty,te] = CS5320_const_acc_Kalman(0,0,0,0,0,-9.8,0.1,3,R,Q);
    dx = ta(:,1) - te(:,1);
    dy = ta(:,2) - te(:,2);
    %dist = sqrt(dx.^2 + dy.^2);
    %meanEr = [meanEr;norm(dist)];
    meanEr = [meanEr;mean(sqrt(dx.^2+dy.^2))];
end
close all; plot(meanEr);

Q = 0.01*eye(2);
meanEr = [];
for k = 0:0.010:1 
    R = k*eye(6);
    [ta,ty,te] = CS5320_const_acc_Kalman(0,0,0,0,0,-9.8,0.1,3,R,Q);
    dx = ta(:,1) - te(:,1);
    dy = ta(:,2) - te(:,2);
    %dist = sqrt(dx.^2 + dy.^2);
    %meanEr = [meanEr;norm(dist)];
    meanEr = [meanEr;mean(sqrt(dx.^2+dy.^2))];
end
close all; plot(meanEr);

%Verifying CS5320_red_ball_Kalman
R = 0.0001*eye(6,6);
R(5:6,5:6) = 0;
Q = eye(2,2);
[ty,te] = CS5320_red_ball_Kalman(Falling_Ball,0,-9.8,1/30,R,Q);
close all;
hold on;plot(ty(:,1),ty(:,2),'r');
hold on;plot(te(:,1),te(:,2),'b');