cube = CS5320_gen_cube([0;0;-1],0.01,1);
imOrig = CS5320_camera(cube,1,1,pi/2,0,0,eye(3,3),[0;0;0]);
[dummy,count] = size(imOrig)

imX = [];
imY = [];

numSamples = 100;
mu = 0;
sigma = 0.2;
noise = mu + sigma.*randn(numSamples, 1)
noise(100)

alpha=1;
beta=1;
theta=pi/2;
x0=0;
y0=0;
R=eye(3,3);
t=[0;0;0];

Error = [];
for i  =  1:100
    %%%%un-comment to add noise to required parameter 
    %alpha = alpha + noise(i);
    %beta = beta + noise(i);
    %theta = theta + noise(i);
    %x0 = x0 + noise(i);
    %y0 = y0 + noise(i);
    im  =  CS5320_camera(cube,alpha,beta,theta,x0,y0,R,t);
    imX = [imX;im(1,:)];
    imY = [imY;im(2,:)];
    diffX =  [];
    diffY =  [];
    NormRow = [];
    for k  =  1:count
        diffX =  imOrig(1,k)-imX(i,k);
        diffY =  imOrig(2,k)-imY(i,k);
        temp  =  sqrt(diffX*diffX+diffY*diffY);
        NormRow = [NormRow,[temp];];
    end
    Error = [Error;NormRow];
end
