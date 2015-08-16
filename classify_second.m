global sample_Set;

train_mean = cell(20,1);
coviance_class = zeros(20,20);
for i = 1:params.class_Num
    res = zeros(1,20);
    Mat = zeros(params.info_Num,20);
    for j = 1:params.info_Num
        Mat(j,:) = data(i).sample(1).info(j).cen_mon_norm;
        res = res + data(i).sample(1).info(j).cen_mon_norm;
    end
    train_mean{i,1} = res/params.info_Num;
    coviance_class = coviance_class + cov(Mat);
end

sigma = coviance_class/params.class_Num;

second_error = zeros(params.class_Num+1,params.class_Num+1);

for i = 1:params.sample_Num               
    second_error_test = zeros(params.class_Num+1,params.class_Num+1);
    for j = 1:params.class_Num
        for k = 1:params.info_Num
            dist = [];
            for jj = 1:params.class_Num
                distance(jj) = 0.5*(data(j).sample(i).info(k).cen_mon_norm-train_mean{jj,1}) ...
                    / sigma * (data(j).sample(i).info(k).cen_mon_norm-train_mean{jj,1})';
            end
            min_dist = min(distance);
            index = find(distance == min_dist);
            second_error_test(j,index) = second_error_test(j,index) + 1;
        end
    end
    
    sum_type = sum(second_error_test(1:params.class_Num,1:params.class_Num));
    for p = 1:params.class_Num
        second_error_test(p,params.class_Num+1) = params.info_Num-second_error_test(p,p);
        second_error_test(params.class_Num+1,p) = sum_type(p) - second_error_test(p,p);
    end
    
    sum_total = sum(second_error_test');
    second_error_test(params.class_Num+1,params.class_Num+1) = sum_total(params.class_Num+1);
    
    second_error = second_error + second_error_test;
    fprintf('%d\t',sum_total(params.class_Num+1));  
end

fprintf('\n\n\n\n                **    Method 2: Moment-space classifier with identical covariances    ***\n');
print(second_error)

clearvars -except data params