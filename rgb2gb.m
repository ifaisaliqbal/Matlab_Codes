function rgb2gb(path)
src = dir([path,'*.jpg']);

%Making red channel go zero altogether and saving in another folder

for l=1: length(src)
   im = imread(strcat(path,src(l).name));
   %im = imresize(im,2);
   im(:,:,1) = 0;%im(:,:,1)-10;
   if(l<10)
        imwrite(im,strcat('C:\Users\Faisal Iqbal\Desktop\Thesis\rgb2gb\',src(l).name),'jpg');
   elseif (l<100) 
        imwrite(im,strcat('C:\Users\Faisal Iqbal\Desktop\Thesis\rgb2gb\',src(l).name),'jpg'); 
   elseif(l>99)
        imwrite(im,strcat('C:\Users\Faisal Iqbal\Desktop\Thesis\rgb2gb\',src(l).name),'jpg');
   end
   
end

% I checked if any of the images have red channel greater than 250

src = dir('C:\Users\Faisal Iqbal\Desktop\Thesis\rgb2gb\*.jpg');
count = 0;
for l=1: length(src)
   im = imread(strcat('C:\Users\Faisal Iqbal\Desktop\Thesis\rgb2gb\',src(l).name));
  aa = im(:,:,1)>250;
  if(sum(sum(aa))>0)
      count = count + 1;
  end
end

sprintf('No.of Red pixels found in all images = %i',count)

