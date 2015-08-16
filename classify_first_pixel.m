global sample_Set;
global class_Set;

P = size(data(1).sample(1).info(1).pixel)
train_mean = cell(params.class_Num,1);
for i = 1:params.class_Num
    res = zeros(1,256);
    for j = 1:params.info_Num
        res = res + data(i).sample(1).info(j).pixel;
    end
    train_mean{i,1} = res/params.info_Num;
end

for i = 1:params.sample_Num
    fprintf('                ********    Method 1: Pixel-space minimum-distance classifier     *******\n');
    first_error_test = zeros(params.class_Num+1,params.class_Num+1);
    for j = 1:params.class_Num
        for k = 1:params.info_Num
            dist = [];
            for jj = 1:params.class_Num
                dist(jj) = norm(train_mean{jj,1}-data(j).sample(i).info(k).pixel,2);
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
    
    print(first_error_test)
    fprintf('                *************    Training set: A_set, Testing set: %s_set    *************\n\n\n',sample_Set(i));
end

clearvars -except data params