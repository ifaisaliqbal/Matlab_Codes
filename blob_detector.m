clc;
clear;
I = imread('3.jpg');
if (size(I,3)==3)
I2=rgb2gray(I);
else
    I2=I;
end
imshow(I2);
%%
% % This is code for SURF point detector
% h = fspecial('gaussian',[7 7],4);
% I2 = imfilter(I2,h);
% I2 = medfilt2(I2);
% %imwrite(imresize(I2, 0.25),'333.jpg');
% figure;
% imshow(I2);
% hold on;
% points = detectSURFFeatures(I2);
% plot(points.selectStrongest(1000));
%%
%This is code for multithreshold
% level = multithresh(I2);
% seg_I = imquantize(I2,level);
% figure
% imshow(seg_I,[])

%%
%This is the code for adaptive thresholding
T = adaptthresh(I2);
BW = imbinarize(I,T);
figure;
imshowpair(I, BW, 'montage');
