global sample_Set;
global class_Set;

train_mean = cell(params.class_Num,1);
for i = 1:params.class_Num
    res = zeros(1,20);
    for j = 1:params.info_Num
        res = res + data(i).sample(1).info(j).cen_mon_norm;
    end
    train_mean{i,1} = res/params.info_Num;
end

first_error = zeros(params.class_Num+1,params.class_Num+1);

for i = 1:params.sample_Num
    first_error_test = zeros(params.class_Num+1,params.class_Num+1);
    for j = 1:params.class_Num
        for k = 1:params.info_Num
            dist = [];
            for jj = 1:params.class_Num
                dist(jj) = norm(train_mean{jj,1}-data(j).sample(i).info(k).cen_mon_norm,2);
            end
            min_dist = min(dist);
            index = find(dist == min_dist);
            first_error_test(j,index) = first_error_test(j,index) + 1;
        end
    end
    
    sum_type = sum(first_error_test(1:params.class_Num,1:params.class_Num));
    for p = 1:params.class_Num
        first_error_test(p,params.class_Num+1) = params.info_Num-first_error_test(p,p);
        first_error_test(params.class_Num+1,p) = sum_type(p) - first_error_test(p,p);
    end
    
    sum_total = sum(first_error_test');
    first_error_test(params.class_Num+1,params.class_Num+1) = sum_total(params.class_Num+1);
    
    first_error = first_error + first_error_test;
    fprintf('%d\t',sum_total(params.class_Num+1));  
end

fprintf('\n\n\n\n                ********    Method 1: Moment-space minimum-distance classifier    *******\n');
print(first_error)

clearvars -except data params