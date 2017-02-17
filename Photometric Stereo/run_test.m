function res = run_test()

size = 60;
Q  =  CS5320_ps_sphere(size);
[I,S] = CS5320_createImages(size);
[rho,N,g,f]  =  CS5320_pms(I,S);

[num_rows]  =  length(Q(:,:,1));
errorMat =  zeros(num_rows,num_rows);

    im_or  =  Q(:,:,3);
    im_md  =  f(:,:);
    err  =  0;
    for i =  1:num_rows
        for j =  1:num_rows
            tempEr = norm(im_or(i,j)-im_md(i,j));
            errorMat(i,j) = tempEr;
            err  =  err + tempEr;
        end
    end
    error  =  err/(num_rows*num_rows);
     results(1,1) = error;
     results(1,2) = var(error);
     results(1,3) = results(1,1) - 1.66*sqrt(results(1,2));
     results(1,4) = results(1,1) + 1.66*sqrt(results(1,2));
    res = results;
    %mesh(Q(:,:,1),Q(:,:,2),errorMat(:,:));axis equal;
    surf(Q(:,:,1),Q(:,:,2),f(:,:),Q(:,:,7));axis equal;
    %error  =  immse(im_or,im_md