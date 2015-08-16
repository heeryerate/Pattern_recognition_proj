global sample_Set;
global class_Set;

third_error = zeros(params.class_Num+1,params.class_Num+1);

for i = 1:params.sample_Num                   
    third_error_test = zeros(params.class_Num+1,params.class_Num+1);
    for j = 1:params.class_Num
        for k = 1:params.info_Num
            dist = [];
            for jj = 1:params.class_Num
                for kk = 1:params.info_Num
                    dist(jj,kk) = norm(data(j).sample(i).info(k).cen_mon_norm-...
                                       data(jj).sample(1).info(kk).cen_mon_norm,2);
                end
            end
            min_dist = min(min(dist));
            [index, datasample] = find(dist == min_dist);
            index = min(index);
            third_error_test(j,index) = third_error_test(j,index) + 1;
        end
    end
    
    sum_type = sum(third_error_test(1:params.class_Num,1:params.class_Num));
    for p = 1:params.class_Num
        third_error_test(p,params.class_Num+1) = params.info_Num-third_error_test(p,p);
        third_error_test(params.class_Num+1,p) = sum_type(p) - third_error_test(p,p);
    end
    
    sum_total = sum(third_error_test');
    third_error_test(params.class_Num+1,params.class_Num+1) = sum_total(params.class_Num+1);
    
    third_error = third_error + third_error_test;
    fprintf('%d\t',sum_total(params.class_Num+1));  
end

 fprintf('\n\n\n\n                ******************    Method 3: 1NN in moment space    ******************\n');
 print(third_error)

clearvars -except data params