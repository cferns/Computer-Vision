x=zeros(60,60);
y=zeros(60,60);
for i= 1:60
    for j= 1:60
        x(i,j)=i;
        y(i,j)=j;
    end
end
surf(x(:,:),y(:,:),Q(:,:,3),Q(:,:,7));axis equal


for i = 2:num_rows
    f(i,1)=f(i-1,1)-q(i,1);
end
for i = 1:num_rows
    for j = 2:num_cols
        f(i,j)=f(i,j-1)-p(i,j);
    end
end

for j = 2:num_cols
    ft(1,j)=ft(1,j-1)+p(1,j);
end
for j = 1:num_cols
    for i = 2:num_rows
        ft(i,j)=ft(i-1,j)+q(i,j);
    end
end

for i = 1:num_rows
    for j = 1:num_cols
        f(i,j)=(f(i,j)+ft(i,j))/2;
    end
end









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




