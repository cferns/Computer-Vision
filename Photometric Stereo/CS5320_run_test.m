function res = CS5320_run_test(sizes)

Q =  CS5320_ps_sphere(sizes);
[I,S] = CS5320_createImages(sizes);
[rho,N,g,f] = CS5320_pms(I,S);

[num_rows,num_cols,num_planes]=size(Q);
%num_rows = length(Q);
num_trials = num_rows*num_rows;
results = zeros(4,4);


g_Q=zeros(num_rows,num_rows,3);
for i = 1: num_rows
    for j = 1: num_rows
        g_Q(i,j,1)= Q(i,j,7)*Q(i,j,4);
        g_Q(i,j,2)= Q(i,j,7)*Q(i,j,5);
        g_Q(i,j,3)= Q(i,j,7)*Q(i,j,6);
    end
end

error = [];

%heightmap
real = Q(:,:,3);
calc = f(:,:);
err = 0;
errMat = 0;
for i = 1:num_rows
    for j = 1:num_rows
        err = norm(real(i,j)-calc(i,j));
        errMat = [errMat;err];
    end
end
error = [error,errMat];

%rho
real = Q(:,:,7);
calc = rho(:,:);
err  =  0;
errMat = 0;
for i = 1:num_rows
    for j = 1:num_rows
        err = norm(real(i,j)-calc(i,j));
        errMat = [errMat;err];
    end
end
error = [error,errMat];

%N
err  =  0;
errMat = 0;
for i = 1:num_rows
    for j = 1:num_rows
        a = [0;0;0];b = [0;0;0];
        for k  =  1:3
            a(k,1) = Q(i,j,3+k);
            b(k,1) = N(i,j,k);
        end
        err = norm(a-b);
        errMat = [errMat;err];
    end
end
error = [error,errMat];

%g
err  =  0;
errMat = 0;
for i = 1:num_rows
    for j = 1:num_rows
        a = [0;0;0];b = [0;0;0];
        for k  =  1:3
            a(k,1) = g_Q(i,j,k);
            b(k,1) = g(i,j,k);
        end
        err = norm(a-b);
        errMat = [errMat;err];
    end
end
error = [error,errMat];

for r = 1:4
     results(r,1) = mean(error(:,r));
     results(r,2) = var(error(:,r));
     results(r,3) = results(r,1) - 1.66*sqrt(results(r,2)/num_trials);
     results(r,4) = results(r,1) + 1.66*sqrt(results(r,2)/num_trials);
end

res = results;

%plot3(Q(:,:,1),Q(:,:,2),f(:,:),'o');axis equal;

diff = 1;
if diff == 1;
    x = zeros(num_rows,num_rows);
    y = zeros(num_rows,num_rows);
    for i =  1:num_rows
        for j =  1:num_rows
            x(i,j) = i-num_rows/2;
            y(i,j) = j-num_rows/2;
        end
    end
    surf(x(:,:),y(:,:),f(:,:),Q(:,:,7));colormap gray;
    axis equal;
end

