close all;
hall4g = rgb2gray(imread('test.jpg'));
[H4,H4pts] = CS5320_Hough(double(hall4g));
ime = edge(hall4g,'canny');
segs = CS5320_line_segs(ime,H4pts,30);

%Verify CS5320_shapes
minDist = 1;
shapes.segs = [];
lineStore = [];
numLines = size(segs,2);
for i = 1:numLines;
   for j = 1:numLines
      if j == i
          continue;
      end
      xi1 = (segs(i).endpt1(2));
      yi1 = (segs(i).endpt1(1));
      xi2 = (segs(i).endpt2(2));
      yi2 = (segs(i).endpt2(1));
      xj1 = (segs(j).endpt1(2));
      yj1 = (segs(j).endpt1(1));
      xj2 = (segs(j).endpt2(2));
      yj2 = (segs(j).endpt2(1));
      
      di1j1 = sqrt((xi1-xj1)^2+(yi1-yj1)^2);
      di1j2 = sqrt((xi1-xj2)^2+(yi1-yj2)^2);
      di2j1 = sqrt((xi2-xj1)^2+(yi2-yj1)^2);
      di2j2 = sqrt((xi2-xj2)^2+(yi2-yj2)^2);
      
      if di1j1<=minDist || di1j2<=minDist || di2j1<=minDist || di2j2<=minDist
          lineStore = [lineStore; [i,j]];
      end
   end
end

for i = 1:numLines
    tmp = find(lineStore==i);
    for j = 1:size(tmp)
        for k = 1:size(tmp)
            if k == j
                continue;
            end
            r1 = i+size(lineStore,1);
            if r1>2*size(lineStore,1)
                r1 = r1 - 2*size(lineStore,1);
            end
            r2 = j+size(lineStore,1);
            if r2>2*size(lineStore,1)
                r2 = r2 - 2*size(lineStore,1);
            end
            if lineStore(r1)==lineStore(r2)
               %found a triangle
               shapes(s).segs = [i,j,lineStrore(r1)];
            end
        end
    end
end
      

%now check the lineStore, and try to combine points having similar lines
c=0;