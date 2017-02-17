
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