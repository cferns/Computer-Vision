function data_threshold(im_seq)

rows = size(im_seq(1).cdata,1);
numIm = size(im_seq,2);
ty =[];
min = []

for i =1:numIm
   [r,c,mind] = CS5320_detect_red_ball(im_seq(i).cdata,[250,0,0]);
   x=c;
   y =rows -r+1;
   ty = [ty;[x,y]];
   min = [[min];mind];
end