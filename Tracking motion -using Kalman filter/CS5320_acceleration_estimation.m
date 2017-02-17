function [te_rc,ty_rc] = CS5320_acceleration_estimation()

load A10_data;

ay1 = -5;
ay2 = -20;
error_in_ty_te = 5;
R = 0.0001*eye(6,6);
R(5:6,5:6) = 0;
Q = eye(2,2);

while (1)
    ay=(ay1+ay2)/2;
    
    [ty,te] = CS5320_red_ball_Kalman( Falling_Ball, 0, ay, 1/30, R, Q);% use ay = -17.64575
    %te is in meters: multiply by 6
    te_pix=6*te;
    %now convert from xy -> rows and columns
    te_rc = zeros(size(te,1),2);
    te_rc(:,1) = te_pix(:,1);
    te_rc(:,2) = 347*ones(size(te,1),1) - te_pix(:,2) + ones(size(te,1),1);
    % similarly sensor
    ty_pix=6*ty;
    %now convert from xy -> rows and columns
    ty_rc = zeros(size(ty,1),2);
    ty_rc(:,1) = ty_pix(:,1);
    ty_rc(:,2) = 347*ones(size(ty,1),1) - ty_pix(:,2) + ones(size(ty,1),1);

    error_in_ty_te = ty_rc(70,2)-te_rc(70,2);
    if error_in_ty_te>0
        ay1 = ay;
    else
        ay2=ay;
    end
    if abs(error_in_ty_te) < 1e-7
        break;
    end
end

error_in_ty_te
close all;
imshow(Falling_Ball(1).cdata);
hold on;plot(te_rc(:,1),te_rc(:,2),'b');
hold on;plot(ty_rc(:,1),ty_rc(:,2),'r.');