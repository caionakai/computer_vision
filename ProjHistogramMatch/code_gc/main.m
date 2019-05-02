clc;
clear;
close all;
warning('off', 'all');
pkg load image;
input_path = '../data';
output_path = '../data_out';
name1= sprintf("%s/img1_patch.png",input_path)
name2= sprintf("%s/img2_patch.png",input_path)
img1 = imread(name1);
img2 = imread(name2);

start_point = [[1,1];[128,128];[256,256]];

p1 =simulate(start_point,img2(:,:,1),img1(:,:,1));
p2 =simulate(start_point,img2(:,:,2),img1(:,:,2));
p3 =simulate(start_point,img2(:,:,3),img1(:,:,3));


r = transform(p1,img2(:,:,1));
g = transform(p2,img2(:,:,2));
b = transform(p3,img2(:,:,3));
name_out = sprintf("%s/img2_patch.png",output_path)
imwrite(cat(3,r,g,b),name_out);

name2= sprintf("%s/img2.png",input_path)
img2 = imread(name2);
r = transform(p1,img2(:,:,1));
g = transform(p2,img2(:,:,2));
b = transform(p3,img2(:,:,3));
name_out = sprintf("%s/img2.png",output_path)
imwrite(cat(3,r,g,b),name_out);