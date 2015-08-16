function cen_mom = cen_mon(p,q,x_c,y_c,mat,params)
    
    N = params.image_Size;
    cen_mom = 0;
    for i = 1:N
        for j = 1:N
            cen_mom = cen_mom+(i-x_c)^p*(j-y_c)^q*mat(i,j);
        end
    end
end

