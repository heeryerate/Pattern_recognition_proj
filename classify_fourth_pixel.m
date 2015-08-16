global sample_Set;
global class_Set;

for i = 1:params.sample_Num
    fprintf('                ******************    Method 4: 5NN in pixel space     ******************\n');
    fourth_error_test = zeros(params.class_Num+1,params.class_Num+1);
    for j = 1:params.class_Num
        for k = 1:params.info_Num
            dist = [];
            for jj = 1:params.class_Num
                for kk = 1:params.info_Num
                    dist(jj,kk) = norm(data(j).sample(i).info(k).pixel-...
                                       data(jj).sample(1).info(kk).pixel,2);
                end
            end
            [value,indice] = sort(dist(:),'ascend');
            [index, datasample] = find(dist <= value(5));
            index = min(index);
            fourth_error_test(j,index) = fourth_error_test(j,index) + 1;
        end
    end
    
    sum_type = sum(fourth_error_test(1:params.class_Num,1:params.class_Num));
    for p = 1:params.class_Num
        fourth_error_test(p,params.class_Num+1) = params.info_Num-fourth_error_test(p,p);
        fourth_error_test(params.class_Num+1,p) = sum_type(p) - fourth_error_test(p,p);
    end
    
    sum_total = sum(fourth_error_test');
    fourth_error_test(params.class_Num+1,params.class_Num+1) = sum_total(params.class_Num+1);
    
    print(fourth_error_test)
    fprintf('                *************    Training set: A_set, Testing set: %s_set    *************\n\n\n',sample_Set(i));
end

clearvars -except data params