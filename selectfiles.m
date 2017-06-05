
path='C:\Users\Faisal\Desktop\testset';
save_path='C:\Users\Faisal\Desktop\testset\75';
src= dir ([path,'\*.jpg']);

for l = 1:length(src)
   if strcmp((src(l).name(8:end-4)),'75')
       movefile([path,'\',src(l).name],[save_path,'\',src(l).name(1:end-7),'.jpg']);
   end
end