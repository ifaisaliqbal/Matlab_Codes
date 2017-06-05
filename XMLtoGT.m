function XMLtoGT(XMLpath,gtpath)
src = dir([XMLpath,'\*.xml']);
%src2 = dir('C:\Users\Faisal Iqbal\Desktop\original images\*.jpg');

for l=1: length(src)
    theSTRUCT = xml2struct([XMLpath,'\',src(l).name]);
     if(length(theSTRUCT.annotation.object)==1)
         xmi=theSTRUCT.annotation.object.bndbox.xmin; xmi = str2num(xmi.Text);
         xma=theSTRUCT.annotation.object.bndbox.xmax; xma = str2num(xma.Text);
         ymi=theSTRUCT.annotation.object.bndbox.ymin; ymi = str2num(ymi.Text);
         yma=theSTRUCT.annotation.object.bndbox.ymax; yma = str2num(yma.Text);
         src(l).name
     else
         xmi=theSTRUCT.annotation.object{1,1}.bndbox.xmin; xmi = str2num(xmi.Text);
         xma=theSTRUCT.annotation.object{1,1}.bndbox.xmax; xma = str2num(xma.Text);
         ymi=theSTRUCT.annotation.object{1,1}.bndbox.ymin; ymi = str2num(ymi.Text);
         yma=theSTRUCT.annotation.object{1,1}.bndbox.ymax; yma = str2num(yma.Text);
         
     end
    
gtFileName = [gtpath,'\',src(l).name(1:end-4),'_mugs.groundtruth'];


%Write to file
fid = fopen(gtFileName,'w');
fprintf(fid,'%i %i %i %i',xmi,ymi,xma,yma);
fclose(fid);
   end 
   