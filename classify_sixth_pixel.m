global sample_Set;
global class_Set;

svmStruct = {};
for i = 1:params.class_Num
    for j = i+1:params.class_Num
        trainingData = [];
        group = [];
        for k = 1:params.info_Num
            trainingData = [trainingData;data(i).sample(1).info(k).pixel];
            group = [group;i];
            trainingData = [trainingData;data(j).sample(1).info(k).pixel];
            group = [group;j];
        end
        svmStruct{i,j} = svmtrain(trainingData,group);
    end
end

SVM_error = zeros(params.class_Num+1,params.class_Num+1);

for i = 1:params.sample_Num
       SVM_error_test = zeros(params.class_Num+1,params.class_Num+1);
    for j = 1:params.class_Num
        for k = 1:params.info_Num
            testResult = [];
            for ii = 1:params.class_Num
                for jj = ii+1:params.class_Num
                    testResult = [testResult,svmclassify(svmStruct{ii,jj},data(j).sample(i).info(k).pixel)];
                end
            end
            index = mode(testResult);
            SVM_error_test(j,index) = SVM_error_test(j,index) + 1;
        end
    end
    
    sum_type = sum(SVM_error_test(1:params.class_Num,1:params.class_Num));
    for p = 1:params.class_Num
        SVM_error_test(p,params.class_Num+1) = params.info_Num-SVM_error_test(p,p);
        SVM_error_test(params.class_Num+1,p) = sum_type(p) - SVM_error_test(p,p);
    end
    
    sum_total = sum(SVM_error_test');
    SVM_error_test(params.class_Num+1,params.class_Num+1) = sum_total(params.class_Num+1);
    
    SVM_error = SVM_error + SVM_error_test;
    fprintf('%d\t',sum_total(params.class_Num+1));  
end

 fprintf('\n\n\n\n                ******************    Method 6: SVM in pixel space     ******************\n');
print(SVM_error)

clearvars -except data params






