function pr = print(M)

    global class_Set;
    fprintf('Classified as:\tB\tC\tD\tE\tI\tJ\tO\tR\tU\tV\tErrorTypeI\n')
    fprintf('True class\n')
    for i = 1:10
        fprintf('\t%s\t',class_Set(i));
        for j = 1:11
            if M(i,j) ~= 0
                fprintf('%d\t',M(i,j))
            else
                fprintf('\t')
            end
        end    
        fprintf('\n')
    end
    
    fprintf('ErrorTypeII\t')
    for j = 1:10
        if M(11,j) ~= 0
            fprintf('%d\t',M(11,j))
        else
            fprintf('\t')
        end
    end
    fprintf('%d(Total Error)\n\n\n\n',M(11,11))
end

