function [ty_rc, te_rc, error_in_ty_te] = test_red_ball_Kalman(Rfact, Qfact)
%test_red_ball_Kalman(0.0001, 1);

load A10_data;
R = Rfact*eye(6,6);
R(5:6,5:6) = 0;
Q = Qfact*eye(2,2);
[ty,te] = CS5320_red_ball_Kalman(Falling_Ball,0,-17.5391,1/30,R,Q);% use g = -17??
%te is in meters: multiply by 6
te_met=te;
te_pix=6*te;
%now convert from xy -> rows and columns
te_rc = zeros(size(te,1),2);
te_rc(:,1) = te_pix(:,1);
te_rc(:,2) = 347*ones(size(te,1),1) - te_pix(:,2) + ones(size(te,1),1);
% similarly sensor
ty_met=ty;
ty_pix=6*ty;
%now convert from xy -> rows and columns
ty_rc = zeros(size(ty,1),2);
ty_rc(:,1) = ty_pix(:,1);
ty_rc(:,2) = 347*ones(size(ty,1),1) - ty_pix(:,2) + ones(size(ty,1),1);
%plot image with the ball motion trace
close all;
imshow(Falling_Ball(1).cdata);
hold on;plot(te_rc(:,1),te_rc(:,2),'b');
hold on;plot(ty_rc(:,1),ty_rc(:,2),'g.');
%below line to adjust the final position of ball te==ty, by adjusting ay0
error_in_ty_te = ty_rc(70,2)-te_rc(70,2)