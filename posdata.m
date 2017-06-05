function pos = posdata(path)
clear;
clc;

src = dir(strcat(path,'/*.jpg'));                   % Chnage address according to requirements
    pos = [];
for l=1: length(src)
   im = imread(strcat(path,src(l).name));
   im_bin = im(:,:,1)>250;
   
   if (any(im_bin)>0)
   col = sum(im_bin,1); % This gives me Col for bbox
   row = sum(im_bin,2); % This gives me row number
   col = find(col>0);
   row = find(row>0);
   y1 = row(1);
   x1 = col(1);
   y2 = row(size(row,1));
   x2 = col(size(col,2));
  
   pos(l).im = strcat(path,src(l).name);
   pos(l).x1 = x1;
   pos(l).y1 = y1;
   pos(l).x2 = x2;
   pos(l).y2 = y2;
   
   end
   
end
end