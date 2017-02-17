
Q  =  CS5320_ps_sphere(60)
[num_rows,num_cols]=size(Q)
x=zeros(num_rows,num_rows);
    y=zeros(num_rows,num_rows);
    for i= 1:num_rows
        for j= 1:num_rows
            x(i,j)=i-num_rows/2;
            y(i,j)=j-num_rows/2;
        end
    end
    surf(x(:,:),y(:,:),Q(:,:,3),Q(:,:,7));colormap gray;axis equal
    
    
    
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