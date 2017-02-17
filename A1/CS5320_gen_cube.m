function cube = CS5320_gen_cube(C,del_x,S)

%center offsets from (0,0,0)
d = C(1,1);
e = C(2,1);
f = C(3,1);

cube = [];
l = -S/2;
r  =  S/2;
length = 0;
count = 0;

while length < S
    length = del_x * count;
    if length <= S
        cube = [cube,[d+l+length;e+l;f+l;1]];
        cube = [cube,[d+l+length;e+l;f+r;1]];
        cube = [cube,[d+l+length;e+r;f+l;1]];
        cube = [cube,[d+l+length;e+r;f+r;1]];
        
        cube = [cube,[d+l;e+l+length;f+l;1]];
        cube = [cube,[d+l;e+l+length;f+r;1]];
        cube = [cube,[d+r;e+l+length;f+l;1]];
        cube = [cube,[d+r;e+l+length;f+r;1]];
        
        cube = [cube,[d+l;e+l;f+l+length;1]];
        cube = [cube,[d+l;e+r;f+l+length;1]];
        cube = [cube,[d+r;e+l;f+l+length;1]];
        cube = [cube,[d+r;e+r;f+l+length;1]];     
     end
    count = count + 1;
end