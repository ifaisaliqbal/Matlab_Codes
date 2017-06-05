function dataset2XML(imgsavepath,xmlsavepath)
Imgslocation = ('D:\dataset\validation 25');
src2 = dir([Imgslocation,'\*.jpg']); 
%src2 = dir(['D:\dataset\correction','\*.jpg']);
%load ('D:\trainvaltest.mat');
field1 = 'originalname';
field2 = 'newname';
value2 = {'',''};
value1 = {'',''};
s = struct(field1,value1,field2,value2);

l = 1;
while l<=length(src2)

img = src2(l);
img_name = img.name;
im = imread([Imgslocation,'\',img_name]);


cc=strsplit(img_name,'_');
docNode = com.mathworks.xml.XMLUtils.createDocument ('annotation');
docRootNode = docNode.getDocumentElement;

ele = docNode.createElement('folder');
docRootNode.appendChild(ele);
ele.appendChild(docNode.createTextNode(sprintf('VOC2007')));


ele = docNode.createElement('filename');
docRootNode.appendChild(ele);
ele.appendChild(docNode.createTextNode(sprintf(src2(l).name)));


ele = docNode.createElement('source');
docRootNode.appendChild(ele);
ele1 = docNode.createElement('database');
ele.appendChild(ele1);
ele1.appendChild(docNode.createTextNode(sprintf('The Mug Database')));
ele2 = docNode.createElement('annotation');
ele.appendChild(ele2);
ele2.appendChild(docNode.createTextNode(sprintf('My Thesis 2016')));
ele3 = docNode.createElement('image');
ele.appendChild(ele3);
ele3.appendChild(docNode.createTextNode(sprintf('flickr')));
ele4 = docNode.createElement('flickrid');
ele.appendChild(ele4);
ele4.appendChild(docNode.createTextNode('not known'));


ele = docNode.createElement('owner');
docRootNode.appendChild(ele);
ele1 = docNode.createElement('flickrid');
ele.appendChild(ele1);
ele1.appendChild(docNode.createTextNode('Not Known'));
ele2 = docNode.createElement('name');
ele.appendChild(ele2);
ele2.appendChild(docNode.createTextNode(sprintf('Search by Flickr id')));


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

    imshow(im);
    title('Press f to flip the photo');
    k = waitforbuttonpress;
    if k==1
         im = flipdim(im,2); 
         imshow(im);
    end
    pp = 1;
    close all;
   while true
            imshow(im);
            title(['Select the region',sprintf('%i',pp)]);

            k = waitforbuttonpress;
        if k==1
             break;
        end
            point1 = get(gca,'CurrentPoint');  %button down detected
            rectregion = rbbox;  %%%return figure units
            point2 = get(gca,'CurrentPoint');%%%%button up detected
            point1 = point1(1,1:2); %%% extract col/row min and maxs
            point2 = point2(1,1:2);
            lowerleft = min(point1, point2);
            upperright = max(point1, point2); 
            xmin = round(lowerleft(1)); %%% arrondissement aux nombrs les plus proches
            xmax = round(upperright(1));
            ymin = round(lowerleft(2));
            ymax = round(upperright(2));
        if(xmin == xmax || ymin == ymax)
         continue   
        end
            pp = pp+1;
            rectangle('position',[xmin ymin xmax-xmin ymax-ymin])
            k = waitforbuttonpress;

            ele = docNode.createElement('object'); 
            docRootNode.appendChild(ele);
            ele1 = docNode.createElement('name');
            ele.appendChild(ele1);
            ele1.appendChild(docNode.createTextNode(sprintf('cup')));
            ele2 = docNode.createElement('pose');
            ele.appendChild(ele2);
            ele2.appendChild(docNode.createTextNode(sprintf('unknown')));
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
            subele1.appendChild(docNode.createTextNode(sprintf('%i',xmin)));
            subele2 = docNode.createElement('ymin');
            ele5.appendChild(subele2);
            subele2.appendChild(docNode.createTextNode(sprintf('%i',ymin)));
            subele3 = docNode.createElement('xmax');
            ele5.appendChild(subele3);
            subele3.appendChild(docNode.createTextNode(sprintf('%i',xmax)));
            subele4 = docNode.createElement('ymax');
            ele5.appendChild(subele4);
            subele4.appendChild(docNode.createTextNode(sprintf('%i',ymax)));
        break;
    end
imwrite(im,[imgsavepath,'\',src2(l).name]);
s(l).newname = [img.name(1:end-4)];
%     if l<10
%     imwrite(im,[imgsavepath,'\00000',sprintf('%i',l),'.jpg']);  %look for zeros from annotation file
%     s(l).newname = ['00000',sprintf('%i',l)];
%     elseif l<100
%         imwrite(im,[imgsavepath,'\0000',sprintf('%i',l),'.jpg']);
%         s(l).newname = ['0000',sprintf('%i',l)];
%     elseif l<1000
%         imwrite(im,[imgsavepath,'\000',sprintf('%i',l),'.jpg']);
%         s(l).newname = ['000',sprintf('%i',l)];
%     else
%         imwrite(im,[imgsavepath,'\00',sprintf('%i',l),'.jpg']);
%         s(l).newname = ['00',sprintf('%i',l)];
%     end
    s(l).originalname = img.name;
    
    xmlFileName = [xmlsavepath,'\',s(l).newname,'.xml'];
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
    
%     theSTRUCT = xml2struct([xmlFileName]);
%     xmi=theSTRUCT.annotation.object.bndbox.xmin; xmi = str2num(xmi.Text);
%     xma=theSTRUCT.annotation.object.bndbox.xmax; xma = str2num(xma.Text);
%     ymi=theSTRUCT.annotation.object.bndbox.ymin; ymi = str2num(ymi.Text);
%     yma=theSTRUCT.annotation.object.bndbox.ymax; yma = str2num(yma.Text);
%     if (xmi == xma || ymi == yma)
%        disp(['wrong box XML found',src2(l).name])
%       % copyfile(['D:\dataset\training 50\',src2(l).name(1:end-4),'.jpg'],'D:\dataset\correction\');
%        l = l-1;
%        k = waitforbuttonpress;
%     end
    l = l+1;
     
end
% save ('D:\var.mat')
