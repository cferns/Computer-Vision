for imN = 1:10
    for pln = 1:3
        Bead(imN).cdata(:,:,pln) = double(Bead(imN).cdata(:,:,pln))+ randn(575,814)*50;
    end
end


