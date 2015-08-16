for i = 1: params.class_Num
    for j = 1:params.sample_Num
        for k = 1:params.info_Num
            MAT = data(i).sample(j).info(k).image;
            m_00 = sum(MAT(:));
            a = sum(MAT);
            b = sum(MAT');
            
            m_01 = 0;
            for p = 1:params.image_Size
                m_01 = m_01 + p*a(p);
            end
            
            m_10 = 0;
            for p = 1:params.image_Size
                m_10 = m_10 + p*b(p);
            end
            
            x_c = m_10/m_00;
            y_c = m_01/m_00;
            
            M = [];
            index = 1;
            for ii = 1:6
                for jj = 1:7-ii
                    M(index) = cen_mon(ii,jj,x_c,y_c,MAT,params);
                    index = index + 1;
                end
            end
            data(i).sample(j).info(k).cen_mon = M(1:end-1);
        end
    end
end

res = zeros(1,20);
for i = 1: params.class_Num
    for k = 1:params.info_Num
        res = res + data(i).sample(1).info(k).cen_mon.^2;
    end
end
rms = (res/1000).^0.5;

for i = 1: params.class_Num
    for j = 1:params.sample_Num
        for k = 1:params.info_Num
            data(i).sample(j).info(k).cen_mon_norm = data(i).sample(j).info(k).cen_mon./rms;
        end
    end
end

clearvars -except data params