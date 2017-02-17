size=5;Q = CS5320_ps_sphere(size);[I,S]=CS5320_createImages(size);[rho,N,g,f] = CS5320_pms(I,S);surf(Q(:,:,1),Q(:,:,2),f(:,:),Q(:,:,7));axis equal

%left to right integrate
for i = 2:num_rows
    f(i,1)=f(i-1,1)+q(i,1);
end
for i = 1:num_rows
    for j = 2:num_cols
        f(i,j)=f(i,j-1)+p(i,j);
    end
end


%middle to side integrate
%%%
f(MID_ROW,MID_COL) = (max(max(p))+max(max(p)))/2;
for i  =  (MID_ROW-1):-1:1
    f(i,MID_COL) = f(i+1,MID_COL)-q(i,MID_COL);
end
for i  =  (MID_ROW+1):num_rows
    f(i,MID_COL) = f(i-1,MID_COL)+q(i,MID_COL);
end

for i  =  1:num_rows
    for j =  (MID_COL-1):-1:1
        f(i,j) = f(i,j+1)+p(i,j);
    end
    for j =  (MID_COL+1):num_rows
        f(i,j) = f(i,j-1)-p(i,j);
    end
end
%%%

f_temp(MID_ROW,MID_COL) = (max(max(p))+max(max(p)))/2;
for j  =  (MID_COL-1):-1:1
    f_temp(MID_ROW,j) = f_temp(MID_ROW,j+1)+p(MID_ROW,j);
end
for j  =  (MID_COL+1):num_cols
    f_temp(MID_ROW,j) = f_temp(MID_ROW,j-1)-p(MID_ROW,j);
end

for j  =  1:num_cols
    for i =  (MID_ROW-1):-1:1
        f_temp(i,j) = f_temp(i+1,j)-q(i,j);
    end
    for i =  (MID_ROW+1):num_rows
        f_temp(i,j) = f_temp(i-1,j)+q(i,j);
    end
end

for i  =  1:num_rows
    for j = 1:num_cols
        f(i,j)=(f(i,j)+f_temp(i,j))/2;
    end
end