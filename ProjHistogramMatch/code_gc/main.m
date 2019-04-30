clc;
clear;
close all;
warning('off', 'all');
pkg load image;
imagens = ['img1_patch.png';'img2_patch.png';'img1.png';'img2.png'];
input_path = '../data';
output_path = '../data_out';
name1= sprintf("%s/%s",input_path,imagens(1,:))
name2= sprintf("%s/%s",input_path,imagens(2,:))
img1 = imread(name1);
img2 = imread(name2);

start_point = [[1,1];[128,128];[256,256]];

p1 =simulate(start_point,img2(:,:,1),img1(:,:,1));
p2 =simulate(start_point,img2(:,:,2),img1(:,:,2));
p3 =simulate(start_point,img2(:,:,3),img1(:,:,3));
for i=1:4
  name_in = sprintf("%s/%s",input_path,imagens(i,:))
  img = imread(name_in);
  r = transform(p1,img(:,:,1));
  g = transform(p2,img(:,:,2));
  b = transform(p3,img(:,:,3));
  name_out = sprintf("%s/%s",output_path,imagens(i,:))
  imwrite(cat(3,r,g,b),name_out);
end