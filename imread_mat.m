src = dir('F:\English\Hnd\Img\Sample001\*.png');
im_mat = [];
for a=1:length(src)
   im = imread(['F:\English\Hnd\Img\Sample001\',src(a).name]);
   im = rgb2gray(im);
   im = imresize(im,0.1);
   %imshow(im);
   im_col = reshape(im,[],1);
   %im = reshape(im_col,[],1200);
   %imshow(im);
   im_mat = [im_mat im_col];    
end
X = mean(im_mat,2);
Xb = X * ones(1,size(im_mat,2));
im_mat = double(im_mat);
im_matt = im_mat-Xb;
[U,S,V] = svd(im_matt);