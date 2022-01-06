% compE565 Homework 1
% Sept. 21, 2021
% Name: Elena Pérez-Ródenas Martínez
% ID: 827-22-2533
% email: eperezrodenasm3836@sdsu.edu
% YOU SHOULD EXECUTE THIS FILE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Problem 1: Read and display the image using Matlab
% Location of input image: C:\Users\Elena Pérez-Ródenas\Desktop\SDSU\
% MULTIMEDIA COMMUNICATIONSYSTEMS\Flooded_house.jpg (user should change this 
% according to the location of the file)
% output image: Figure 1, Original image
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc
clear all
close all
I=imread("C:\Users\Elena Pérez-Ródenas\Desktop\SDSU\MULTIMEDIA COMMUNICATION SYSTEMS\Flooded_house.jpg","jpg");
imshow(I);
title("Original image");
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Problem 2: Display each band (Red, Green and Blue) of the image file
% output image: Figures 2, 3 and 4 (red, green and blue bands)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Red=I(:,:,1);
Green=I(:,:,2);
Blue=I(:,:,3);
figure(2)
imshow(Red);
title("Red Band");
figure(3)
imshow(Green);
title("Green Band");
figure(4)
imshow(Blue);
title("Blue Band");
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Problem 3: Convert the image into YCbCr color space
% output image: figure 5, YCbCr image
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ycbcr=rgb2ycbcr(I);
figure(5)
imshow(ycbcr);
title("YCbCr Image");
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Problem 4: Display each band separately (Y, Cb and Cr bands)
% output image: Figures 6, 7 and 8 (Y, Cb and Cr bands)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Y=ycbcr(:,:,1);
Cb=ycbcr(:,:,2);
Cr=ycbcr(:,:,3);
figure(6)
imshow(Y);
title("Y Band");
figure(7)
imshow(Cb);
title("Cb Band");
figure(8)
imshow(Cr);
title("Cr Band");
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Problem 5: Subsample Cb and Cr bands using 4:2:0 and display both bands
% output image: Figures 9 and 10, subsamples Cb and Cr using 4:2:0
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Cb420=Cb(1:2:end, 1:2:end);
Cr420=Cr(1:2:end, 1:2:end);
figure(9)
imshow(Cb420);
title("Subsample Cb using 4:2:0");
figure(10)
imshow(Cr420);
title("Subsample Cr using 4:2:0");
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Problem 6: Upsample and display the Cb and Cr bands using
% Linear interpolation
% output image: Figure 11, Cb and Cr upsampling with linear interpolation
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ycbcrlin(:,:,1)=ycbcr(:,:,1);
ycbcrlin(1:2:end,1:2:end,2)=Cb420(:,:);
ycbcrlin(1:2:end,1:2:end,3)=Cr420(:,:);
ycbcrlin(1:2:end,2:2:end-1,2:3)=(double(ycbcrlin(1:2:end,1:2:end-2,2:3))+double(ycbcrlin(1:2:end,3:2:end,2:3)))/2;
ycbcrlin(2:2:end-1,:,2:3)=(double(ycbcrlin(1:2:end-2,:,2:3))+double(ycbcrlin(3:2:end,:,2:3)))/2;
cb420lin=ycbcrlin(:,:,2);
cr420lin=ycbcrlin(:,:,3);
figure(11)
imshow(cb420lin);
title("Cb Upsampling with linear interpolation");
figure(12)
imshow(cr420lin);
title("Cr Upsampling with linear interpolation");
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Simple row or column replication
% output image: Figures 13 and 14, Cb and Cr upsampling with row or column
% replication
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ycbcrrep=ycbcr;
ycbcrrep(1:2:end,2:2:end+1,2:3)=ycbcrrep(1:2:end,1:2:end,2:3);
ycbcrrep(2:2:end+1,:,2:3)=ycbcrrep(1:2:end,:,2:3);
figure(13)
imshow(ycbcrrep(:,:,2));
title("Cb Upsampling with row or column replication");
figure(14)
imshow(ycbcrrep(:,:,3));
title("Cr Upsampling with row or column replication");
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Problem 7: Convert the image into RGB format
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
rgblin=ycbcr2rgb(ycbcrlin);
rgbrep=ycbcr2rgb(ycbcrrep);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Problem 8: isplay the original and reconstructed images (the image 
% restoredfrom the YCbCr coordinate)
% output image: Figures 15 and 16, RGB images upsampled by linear
% interpolation and row or column replication
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(15)
imshow(rgblin);
title("RGB image upsampled by linear interpolation");
figure(16)
imshow(rgbrep);
title("RGB image upsampled by row or column replication");
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Problem 10: Measure MSE between the original and reconstructed images 
% (obtained using linear interpolation only). Comment on the results
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[m,n]=size(I);
n=n/3;
double MSECb;
double MSECr;
MSECb=0;
MSECr=0;
for i=1:1:m
        for j=1:1:n
                MSECb=MSECb+(double(I(i,j,2))-double(rgblin(i,j,2))).^2;
                MSECr=MSECr+(double(I(i,j,3))-double(rgblin(i,j,3))).^2;
        end
end
MSECb=MSECb/(m*n)
MSECr=MSECr/(m*n)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Problem 11: omment on the compression ratio achieved by subsampling Cband 
% Cr components for 4:2:0 approach. Please note that you donot send the 
% pixels which are made zero in the row and columnsduring subsampling
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
size1 = size(Y,1)*size(Y,2)+size(Cb,1)*size(Cb,2)+size(Cr,1)*size(Cr,2);
size2 = size(Y,1)*size(Y,2)+size(Cb420,1)*size(Cb420,2)+size(Cr420,1)*size(Cr420,2);
ratio=size1/size2