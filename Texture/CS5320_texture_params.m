function params = CS5320_texture_params(im)
% CS5320_texture_params - compute texture parameters
% On input:
%     im (mxnx3 array): input image
% On output:
%     params (mxnx16 array): texture parameter image
%       channel 1: spot1 summarized positive
%       channel 2: spot1 summarized negative
%       channel 3: spot2 summarized positive
%       channel 4: spot2 summarized negative
%       channel 5: bar (0) summarized positive
%       channel 6: bar (0) summarized negative
%       channel 7: bar (45) summarized positive
%       channel 8: bar (45) summarized negative
%       channel 9: bar (90) summarized positive
%       channel 10: bar (90) summarized negative
%       channel 11: bar (135) summarized positive
%       channel 12: bar (135) summarized negative
%       channel 13: mean summarized positive
%       channel 14: mean summarized negative
%       channel 15: variance summarized positive
%       channel 16: variance summarized negative
% Call:
%     p_im = CS5320_texture_params(im_tex);
% Author:
%     Clinton Fernandes
%     UU
%     Spring 2016
%

[rows,cols] = size(im);
params = zeros(rows,cols,16);

%filters
S1 = CS5320_spot1;
S2 = CS5320_spot2;

B90 = CS5320_bar(1,0,0,-1);
B90 = imresize(B90,[101,101]);
B0 = imrotate(B90,90,'crop');
B45 = imrotate(B90,45,'crop');
B135 = imrotate(B45,90,'crop');

B90 = imresize(B90,[11,11]);
B0 = imresize(B0,[11,11]);
B45 = imresize(B45,[11,11]);
B135 = imresize(B135,[11,11]);
MN = fspecial('average', 11);

%response maps
TS1 = filter2(double(S1),im);
TS2 = filter2(S2,im);
TB0 = filter2(B0,im);
TB45 = filter2(B45,im);
TB90 = filter2(B90,im);
TB135 = filter2(B135,im);
TMN = filter2(MN,im);

TStDev = stdfilt(im, ones(11));
TVR = TStDev.^2;

%rectification
RS1_1 = max(0,TS1);
RS1_2 = max(0,-TS1);
RS2_1 = max(0,TS2);
RS2_2 = max(0,-TS2);
RB0_1 = max(0,TB0);
RB0_2 = max(0,-TB0);
RB45_1 = max(0,TB45);
RB45_2 = max(0,-TB45);
RB90_1 = max(0,TB90);
RB90_2 = max(0,-TB90);
RB135_1 = max(0,TB135);
RB135_2 = max(0,-TB135);
RMN_1 = max(0,TMN);
RMN_2 = max(0,-TMN);
RVR_1 = max(0,TVR);
RVR_2 = max(0,-TVR);

%summarize
G = fspecial('gaussian',22,6);
params(:,:,1) = filter2(G,RS1_1);
params(:,:,2) = filter2(G,RS1_2);
params(:,:,3) = filter2(G,RS2_1);
params(:,:,4) = filter2(G,RS2_2);
params(:,:,5) = filter2(G,RB0_1);
params(:,:,6) = filter2(G,RB0_2);
params(:,:,7) = filter2(G,RB45_1);
params(:,:,8) = filter2(G,RB45_2);
params(:,:,9) = filter2(G,RB90_1);
params(:,:,10) = filter2(G,RB90_2);
params(:,:,11) = filter2(G,RB135_1);
params(:,:,12) = filter2(G,RB135_2);
params(:,:,13) = filter2(G,RMN_1);
params(:,:,14) = filter2(G,RMN_2);
params(:,:,15) = filter2(G,RVR_1);
params(:,:,16) = filter2(G,RVR_2);