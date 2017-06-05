function move_file(source,destination,file_names)


for i = 1:length(file_names)
    if file_names(i)<10
        nam = ['00000',sprintf('%i',file_names(i)),'.jpg']; 
    elseif file_names(i)<100
        nam = ['0000',sprintf('%i',file_names(i)),'.jpg'];
    elseif file_names(i)<1000
        nam = ['000',sprintf('%i',file_names(i)),'.jpg'];
    else
        nam = ['00',sprintf('%i',file_names(i)),'.jpg'];
    end
   movefile([source,'\',nam],destination) 
end
