function move_xml(source,destination,file_names)

for i = 3:length(file_names)
   nam = [file_names(i).name(1:end-4),'.xml']; 
   movefile([source,'\',nam],destination) 
end
