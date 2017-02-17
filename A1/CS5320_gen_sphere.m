function sphere = CS5320_gen_sphere(C,radius,del_x,del_p)

%center offsets
d = C(1,1);
e = C(2,1);
f = C(3,1);

sphere = [];
x = -radius+d;
temp_x = -radius;

while x <= radius+d
    theta = (acos(abs(temp_x)/radius));
    
    r_temp = abs(temp_x)*tan(theta);
    if r_temp > radius
        r_temp = radius;
    end
    
    angleCount = 0;
    thetaX = 2*asin(del_p/(2*r_temp));
    while angleCount < (2*pi)
        if (r_temp <= 0 | r_temp >= 2*radius)
            sphere = [sphere,[x;e;f;1];];
            break;
        end
        y = e+r_temp*sin(angleCount);
        z = f+r_temp*cos(angleCount);
        sphere = [sphere,[x;y;z;1];];
        angleCount = angleCount+thetaX;
    end
    
    x = x+del_x;
    temp_x = temp_x+del_x;
end

sphere = [sphere,[radius+d;e;f;1];];