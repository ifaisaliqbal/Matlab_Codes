src = dir('D:\dataset\training');
fileID = fopen('cup_trainval.txt','w');
for l=3:length(src)
    fprintf(fileID,'%6s %s\n',src(l).name(1:end-4),'1');
end
src = dir('D:\dataset\validation');
for l=3:length(src)
    fprintf(fileID,'%6s %s\n',src(l).name(1:end-4),'1');
end
fclose(fileID);