% load image package
pkg load image;

%% Setup
% Read images and convert to floating point format
image1 = im2single(imread('../data/img1_patch.png'));
image2 = im2single(imread('../data/img2_patch.png'));


imagens = ['img1', 'img2', 'img1_patch', 'img2_patch']

% separate the channels into RED, GREEN, BLUE, respectively
r_img1 = im2uint8(image1(:,:,1));
g_img1 = im2uint8(image1(:,:,2));
b_img1 = im2uint8(image1(:,:,3));
% the same for img2
r_img2 = im2uint8(image2(:,:,1));
g_img2 = im2uint8(image2(:,:,2));
b_img2 = im2uint8(image2(:,:,3));

s0 = [[5,2];[43,114]; [132,182];[250,250]];

%s0 = [[1,1];[128,128]; [128,128];[256,256]];

histfinal = simulated_annealing(s0, 256, 0.0001, r_img2, r_img1);
histfinal2 = simulated_annealing(s0, 256, 0.0001, g_img2, g_img1);
histfinal3 = simulated_annealing(s0, 256, 0.0001, b_img2, b_img1);

r_2 = xau(histfinal, r_img2);
g_2 = xau(histfinal2, g_img2);
b_2 = xau(histfinal3, b_img2);

img = cat(3, r_2, g_2, b_2);
imwrite(img, "finalpatch.png");


final = im2single(imread('../data/img2.png'));

r_final = im2uint8(final(:,:,1));
g_final = im2uint8(final(:,:,2));
b_final = im2uint8(final(:,:,3));


x_2 = xau(histfinal, r_final);
y_2 = xau(histfinal2, g_final);
z_2 = xau(histfinal3, b_final);

resultfinal = cat(3, x_2, y_2, z_2);

imwrite(resultfinal, "finalimg.png");

