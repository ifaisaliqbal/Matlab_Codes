clear;close all;
tic;
%im1=imread('page.png');
I=imread('32.jpg');
h = fspecial('gaussian',[11 11],4);
if (size(I,3)==3)
I2=rgb2gray(I);
else
    I2=I;
end
I2 = imfilter(I2,h);
im1 = medfilt2(I2);
bwim1=adaptivethreshold(im1,11,0.03,0);
toc;
%bwim2=adaptivethreshold(im2,15,0.02,0);
%subplot(1,2,1);
%imshow(im1);
%subplot(1,2,2);
%figure;
%imshow(bwim1);
%subplot(2,2,3);
%imshow(im2);
%subplot(2,2,4);
%imshow(bwim2);