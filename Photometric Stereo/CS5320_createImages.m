function [I,S]=CS5320_createImages(size)
Q = CS5320_ps_sphere(size);

%for given sources, choice = 1, for random, choice = 2
choice=1;

if choice==1
    S1 = [0,00.6,0.8];
    I1 = CS5320_ps_render(Q,S1);
    S2 = [0.4,0.4,0.3];
    S2 = S2/norm(S2);
    I2 = CS5320_ps_render(Q,S2);
    S3 = [0.4,0.4,0.5];
    S3 = S3/norm(S3);
    I3 = CS5320_ps_render(Q,S3);
    S4 = [0.4,0.4,0.7];
    S4 = S4/norm(S4);
    I4 = CS5320_ps_render(Q,S4);
    S5 = [0.4,0.4,0.1];
    S5 = S5/norm(S5);
    I5 = CS5320_ps_render(Q,S5);
    S = [S1;S2;S3;S4;S5];
    I(:,:,1) = I1;
    I(:,:,2) = I2;
    I(:,:,3) = I3;
    I(:,:,4) = I4;
    I(:,:,5) = I5;
end

%%%more images
ifON = 0;
if ifON == 1
    S6 = [0,0.7,1];
    S6 = S6/norm(S6);
    I6 = CS5320_ps_render(Q,S6);
    S = [S;S6];
    I(:,:,6) = I6;
    
    S7  = [0.7,0,1];
    S7  = S7 /norm(S7 );
    I7 = CS5320_ps_render(Q,S7);
    S = [S;S7 ];
    I(:,:,7) = I7;
    
    S8  = [-0.7,0,1];
    S8  = S8 /norm(S8 );
    I8 = CS5320_ps_render(Q,S8);
    S = [S;S8 ];
    I(:,:,8) = I8;
    
    S9  = [0,-0.7,1];
    S9  = S9 /norm(S9 );
    I9 = CS5320_ps_render(Q,S9);
    S = [S;S9 ];
    I(:,:,9) = I9;
end

%number of sources

if choice==2
n=5;
S=[];
S_tem=[];
I_tem=[];
    for i= 1:n
        S_tem  = [randn,randn,randn];
        S_tem  = S_tem /norm((S_tem));
        I_tem = CS5320_ps_render(Q,S_tem);
        S = [S;S_tem];
        I(:,:,i) = I_tem;    
    end
end