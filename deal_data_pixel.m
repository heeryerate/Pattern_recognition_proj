for i = 1: params.class_Num
    for j = 1:params.sample_Num
        for k = 1:params.info_Num
            data(i).sample(j).info(k).pixel = reshape(data(i).sample(j).info(k).image,[1,256]);
        end
    end
end

clearvars -except data params