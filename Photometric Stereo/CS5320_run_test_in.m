function results = CS5320_run_test_in(sigma2,num_trials)
% CS5320_run_test_in - get statistics on intrinsic parameters
% On input:
%     sigma2 (float) variance for test
%     num_trials (int): number of trials to run
% On output:
%     results (5x4 array): means, variances, and confidence intervals
%       row 1: alpha
%       row 2: beta
%       row 3: theta
%       row 4: x0
%       row 5: y0
%       col 1: mean
%       col 2: variance
%       col 3: lower value of confidence interval
%       col 4: upper value of confidence interval
% Call:
%     res = CS5320_run_test_in(0.2,100);
% Author:
%     T. Henderson
%     UU
%     Spring 2016
%

% Set base values
alpha = 1;
beta = 1;
theta = pi/2;
x0 = 0;
y0 = 0;
R = eye(3,3);
t = [0;0;0];
[cal,cal2] = CS5320_cal;
im = CS5320_camera(cal2,alpha,beta,theta,x0,y0,R,t);
num_pts = length(im(1,:));

results = zeros(4,4);
error = zeros(num_trials,4);

real=Q(:,:,3);
calc=f(:,:);
err = 0;
for i = 1:num_rows
    for j = 1:num_cols
        err = err + norm(real(i,j)-calc(i,j));
    end
end
error(n,1) = err/num_pts;

real=Q(:,:,7);
calc=rho(:,:);
err = 0;
for i = 1:num_rows
    for j = 1:num_cols
        err = err + norm(real(i,j)-calc(i,j));
    end
end
error(n,1) = err/num_pts;

for n = 1:num_trials
    alphan = alpha + sqrt(sigma2)*randn;
    im_a = CS5320_camera(cal2,alphan,beta,theta,x0,y0,R,t);
    err = 0;
    for p = 1:num_pts
        err = err + norm(im(:,p)-im_a(:,p));
    end
    error(n,1) = err/num_pts;
    error(n,1) = immse(im,im_a);
    betan = beta + sqrt(sigma2)*randn;
    im_b = CS5320_camera(cal2,alpha,betan,theta,x0,y0,R,t);
    err = 0;
    for p = 1:num_pts
        err = err + norm(im(:,p)-im_b(:,p));
    end
    error(n,2) = err/num_pts;
    thetan = theta + sqrt(sigma2)*randn;
    im_t = CS5320_camera(cal2,alpha,beta,thetan,x0,y0,R,t);
    err = 0;
    for p = 1:num_pts
        err = err + norm(im(:,p)-im_t(:,p));
    end
    error(n,3) = err/num_pts;
    x0n = x0 + sqrt(sigma2)*randn;
    im_x = CS5320_camera(cal2,alpha,beta,theta,x0n,y0,R,t);
    err = 0;
    for p = 1:num_pts
        err = err + norm(im(:,p)-im_x(:,p));
    end
    error(n,4) = err/num_pts;
    y0n = y0 + sqrt(sigma2)*randn;
    im_y = CS5320_camera(cal2,alpha,beta,theta,x0,y0n,R,t);
    err = 0;
    for p = 1:num_pts
        err = err + norm(im(:,p)-im_y(:,p));
    end
    error(n,5) = err/num_pts;
end

for r = 1:5
     results(r,1) = mean(error(:,r));
     results(r,2) = var(error(:,r));
     results(r,3) = results(r,1) - 1.66*sqrt(results(r,2)/num_trials);
     results(r,4) = results(r,1) + 1.66*sqrt(results(r,2)/num_trials);
end
