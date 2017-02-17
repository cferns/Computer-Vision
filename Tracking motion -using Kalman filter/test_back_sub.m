for nImageCnt = 1 : 70
    imagesc(t_im(:,:,nImageCnt)==max(max(t_im(:,:,nImageCnt)))); colormap gray;
    %imagesc(Falling_Ball(nImageCnt).cdata)
    pause(0.02);
end