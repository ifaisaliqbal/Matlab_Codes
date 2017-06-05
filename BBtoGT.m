function BBtoGT(imgpath,gtpath)
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
    xy = [x1 y1 x2 y2];
if(l<=9) 
gtFileName = [gtpath,src(l).name(1:end-4),'_mugs.groundtruth'];
elseif(l<=99)
gtFileName = [gtpath,src(l).name(1:end-4),'_mugs.groundtruth'];   
else
gtFileName = [gtpath,src(l).name(1:end-4),'_mugs.groundtruth'];
end

%Write to file
fid = fopen(gtFileName,'w');
fprintf(fid,'%i %i %i %i',x1,y1,x2,y2);
fclose(fid);
  
   else
       disp('Error occured');
       disp(sprintf('%i',l));
   end 
   
end