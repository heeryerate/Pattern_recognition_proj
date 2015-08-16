f = dir('./C-II');

% Define constants
params.sample_Num = 4;
params.class_Num = 10;
params.info_Num = 100;
params.image_Size = 16;

data = struct();
global sample_Set;
sample_Set = ['A','B','C','D'];
global class_Set;
class_Set = ['B','C','D','E','I','J','O','R','U','V'];


for i = 3:length(f)
    name = f(i).name;
    class_Index = find(class_Set == name(3));
    sample_Index = find(sample_Set == name(1));
    data(class_Index).sample(sample_Index).name = name;
end

for j = 1:params.class_Num
    for k = 1:params.sample_Num
        
        sample_Data = ['./C-II/',data(j).sample(k).name];
        fid = fopen(sample_Data);
        
        tline = fgetl(fid);
        t = 1;
        p = struct();
        
        while ischar(tline)
            if tline ~= -1 & tline(1) == 'C'
                h = strfind(tline, 'h');
                w = strfind(tline, 'w');
                b = strfind(tline, 'b');
                m = str2num(tline(h+1:w-1));
                n = str2num(tline(w+1:b-1));
                
                MAT = char(ones(params.image_Size,params.image_Size)*'.');
                toprow = floor((params.image_Size-m)/2)+1;
                bottomrow = toprow + m - 1;
                leftcolumn = floor((params.image_Size-n)/2)+1;
                rightcolumn = leftcolumn + n - 1;
                MAT(toprow:bottomrow,leftcolumn:rightcolumn) = reshape(fscanf(fid,'%s',[m,1]),n,m)';
                
                p(t).num = t;
                p(t).image = floor(double(MAT)/120);
                p(t).dimension = [m,n];
                t = t+1;
            end
            tline = fgetl(fid);
        end
        fclose('all');
        data(j).sample(k).info = p;
    end
end

clearvars -except data params