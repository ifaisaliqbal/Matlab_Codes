clear;
im = imread('4.jpg');
imm = double(im);
free(:,:,1) = imm(:,:,1)./(sum(sum(imm(:,:,1)))/prod(size(im)));
free(:,:,2) = imm(:,:,2)./(sum(sum(imm(:,:,2)))/prod(size(im)));
free(:,:,3) = imm(:,:,3)./(sum(sum(imm(:,:,3)))/prod(size(im)));
for j=1:3
k=uint8(free(:,:,j));
g(:,:,j)= histeq(k);
end
% g=im;
% g=histeq(free)
% g=hist_eq(free)
% g=hist_eq(uint8(free))
% g=hist_eq(uint8(free));
imshow(im)
figure
imshow(g)
% gg = rgb2ycbcr(g);
% ymean = sum(sum(gg(:,:,1)))/numel(gg(:,:,1));
% cbmean = sum(sum(gg(:,:,2)))/numel(gg(:,:,2));
% crmean = sum(sum(gg(:,:,3)))/numel(gg(:,:,3));
% res1 = (gg(:,:,1)>ymean)&(gg(:,:,2)<cbmean)&(gg(:,:,3)>crmean);
% res2 = abs(gg(:,:,3)-gg(:,:,2))>70;
% imshow(double(res2))