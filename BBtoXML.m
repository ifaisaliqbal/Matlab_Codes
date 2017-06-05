function BBtoXML(imgpath,xmlpath)
src = dir([imgpath,'*.jpg']);
%src2 = dir('C:\Users\Faisal Iqbal\Desktop\original images\*.jpg');

for l=1: length(src)
   im = imread(strcat(imgpath,src(l).name));
   %imshow(strcat('C:\Users\Faisal Iqbal\Desktop\original images\',src2(l).name));
   %hold on;
   im_bin = im(:,:,1)>250;
   
   if (sum(sum(any(im_bin)>0)))
   col = sum(im_bin,1); % This gives me Col for bbox
   row = sum(im_bin,2); % This gives me row number
   col = find(col>0);
   row = find(row>0);
   y1 = row(1);
   x1 = col(1);
   y2 = row(size(row,1));
   x2 = col(size(col,2));
   %rectangle('Position', [x1, y1, x2-x1, y2-y1],'EdgeColor','r', 'LineWidth', 3);

  
docNode = com.mathworks.xml.XMLUtils.createDocument ('annotation');
docRootNode = docNode.getDocumentElement;

ele = docNode.createElement('folder');
docRootNode.appendChild(ele);
ele.appendChild(docNode.createTextNode(sprintf('VOC2007')));


ele = docNode.createElement('filename');
docRootNode.appendChild(ele);
ele.appendChild(docNode.createTextNode(sprintf(src(l).name)));


ele = docNode.createElement('source');
docRootNode.appendChild(ele);
ele1 = docNode.createElement('database');
ele.appendChild(ele1);
ele1.appendChild(docNode.createTextNode(sprintf('The VOC2007 Database')));
ele2 = docNode.createElement('annotation');
ele.appendChild(ele2);
ele2.appendChild(docNode.createTextNode(sprintf('PASCAL VOC2007')));
ele3 = docNode.createElement('image');
ele.appendChild(ele3);
ele3.appendChild(docNode.createTextNode(sprintf('flickr')));
ele4 = docNode.createElement('flickrid');
ele.appendChild(ele4);
ele4.appendChild(docNode.createTextNode(sprintf('325991873')));


ele = docNode.createElement('owner');
docRootNode.appendChild(ele);
ele1 = docNode.createElement('flickrid');
ele.appendChild(ele1);
ele1.appendChild(docNode.createTextNode(sprintf('archintent louisville')));
ele2 = docNode.createElement('name');
ele.appendChild(ele2);
ele2.appendChild(docNode.createTextNode(sprintf('?')));


ele = docNode.createElement('size'); 
docRootNode.appendChild(ele);
ele1 = docNode.createElement('width');
ele.appendChild(ele1);
ele1.appendChild(docNode.createTextNode(sprintf('%i',size(im,2))));
ele2 = docNode.createElement('height');
ele.appendChild(ele2);
ele2.appendChild(docNode.createTextNode(sprintf('%i',size(im,1))));
ele3 = docNode.createElement('depth');
ele.appendChild(ele3);
ele3.appendChild(docNode.createTextNode(sprintf('%i',size(im,3))));


ele = docNode.createElement('segmented'); 
docRootNode.appendChild(ele);
ele.appendChild(docNode.createTextNode(sprintf('%i',0)));


ele = docNode.createElement('object'); 
docRootNode.appendChild(ele);
ele1 = docNode.createElement('name');
ele.appendChild(ele1);
ele1.appendChild(docNode.createTextNode(sprintf('cup')));
ele2 = docNode.createElement('pose');
ele.appendChild(ele2);
ele2.appendChild(docNode.createTextNode(sprintf('quarter')));
ele3 = docNode.createElement('truncated');
ele.appendChild(ele3);
ele3.appendChild(docNode.createTextNode(sprintf('0')));
ele4 = docNode.createElement('difficult');
ele.appendChild(ele4);
ele4.appendChild(docNode.createTextNode(sprintf('0')));
ele5 = docNode.createElement('bndbox');
ele.appendChild(ele5);
subele1 = docNode.createElement('xmin');
ele5.appendChild(subele1);
subele1.appendChild(docNode.createTextNode(sprintf('%i',x1)));
subele2 = docNode.createElement('ymin');
ele5.appendChild(subele2);
subele2.appendChild(docNode.createTextNode(sprintf('%i',y1)));
subele3 = docNode.createElement('xmax');
ele5.appendChild(subele3);
subele3.appendChild(docNode.createTextNode(sprintf('%i',x2)));
subele4 = docNode.createElement('ymax');
ele5.appendChild(subele4);
subele4.appendChild(docNode.createTextNode(sprintf('%i',y2)));


if(l<=9) 
xmlFileName = [xmlpath,src(l).name(1:end-4),'.xml'];
elseif(l<=99)
xmlFileName = [xmlpath,src(l).name(1:end-4),'.xml'];   
else
xmlFileName = [xmlpath,src(l).name(1:end-4),'.xml'];
end
xmlwrite(xmlFileName,docNode);

XML_string = xmlwrite(docNode); %XML as string
XML_string = strrep(XML_string, '<?xml version="1.0" encoding="utf-8"?>','');
XML_string = regexprep(XML_string,'         ','\t\t\t'); %removes extra tabs, spaces and extra lines
XML_string = regexprep(XML_string,'      ','\t\t'); %removes extra tabs, spaces and extra lines
XML_string = regexprep(XML_string,'   ','\t'); %removes extra tabs, spaces and extra lines

%Write to file
fid = fopen(xmlFileName,'w');
fprintf(fid,'%s\n',XML_string);
fclose(fid);
  
   else
       disp('Error occured');
       disp(sprintf('%i',l));
   end 
   
end