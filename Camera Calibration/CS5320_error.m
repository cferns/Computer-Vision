function [results,error] = CS5320_error(sigma2,num_trials)
% CS5320_run_test_in - get statistics on intrinsic parameters
% On input:
%     sigma2 (float) variance for test
%     num_trials (int): number of trials to run
% On output:
%     error (100x7 array): error for parameters, for 100 trials
%       row 1 to 100 : trials
%       col 1: error in alpha
%       col 2: error in beta
%       col 3: error in theta
%       col 4: error in x0
%       col 5: error in y0
%       col 6: error in Rotation matrix
%       col 7: error in translation matrix
%     results (7x4 array): means, variances, and confidence intervals
%       row 1: alpha
%       row 2: beta
%       row 3: theta
%       row 4: x0
%       row 5: y0
%       row 6: Rotation matrix
%       row 7: translation matrix
%       col 1: mean
%       col 2: variance
%       col 3: lower value of confidence interval
%       col 4: upper value of confidence interval
% Call:
%     [results,error] = CS5320_error(0.2,100);
% Author:
%     Clinton Fernandes
%     UU
%     Spring 2016
%

% Set base values

load 'A35Fernandes';
[im_rows,im_cols] = size(pts_im);
[alpha,beta,theta,x0,y0,R,t] = CS5320_calibrate(pts_im,pts_world);

num_pts=length(pts_im(1,:));
results = zeros(7,4);
error = zeros(num_trials,7);

x=[];
for n = 1:num_trials
    dummy_pts=pts_im
    for p=1:num_pts
        dummy_pts(1,p)=dummy_pts(1,p) + sqrt(sigma2)*randn;
        x=[x;dummy_pts(1,p)];
        dummy_pts(2,p) = dummy_pts(2,p) + sqrt(sigma2)*randn;
    end
    %temp=[randn(1,im_cols);randn(1,im_cols);ones(1,im_cols)];
    %dummy_pts=pts_im+sqrt(sigma2)*temp;
    [alphaN,betaN,thetaN,x0N,y0N,RN,tN] = CS5320_calibrate(dummy_pts,pts_world);

    error(n,1) = (alpha-alphaN);
    error(n,2) = (beta-betaN);
    error(n,3) = (theta-thetaN);
    error(n,4) = (x0-x0N);
    error(n,5) = (y0-y0N);
    error(n,6) = norm(R-RN);
    error(n,7) = norm(t-tN);
end

for r = 1:7
     results(r,1) = mean(error(:,r));
     results(r,2) = var(error(:,r));
     results(r,3) = results(r,1) - 1.66*sqrt(results(r,2)/num_trials);
     results(r,4) = results(r,1) + 1.66*sqrt(results(r,2)/num_trials);
end
