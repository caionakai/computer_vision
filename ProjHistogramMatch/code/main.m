% load image package
pkg load image;

%% Setup
% Read images and convert to floating point format
image1 = im2single(imread('../data/img1_patch.png'));
image2 = im2single(imread('../data/img2_patch.png'));

% separate the channels into RED, GREEN, BLUE, respectively
r_img1 = image1(:,:,1);
g_img1 = image1(:,:,2);
b_img1 = image1(:,:,3);
% the same for img2
r_img2 = image2(:,:,1);
g_img2 = image2(:,:,2);
b_img2 = image2(:,:,3);


s0 = [[5,2];[128,128];[250,250]];
#figure, plot(imhist(r_img1), c="r");
histfinal = simulated_annealing(s0, 256, 0.0001, r_img2, r_img1);
figure, plot(imhist(r_img2), c="g");
r_2 = calculatesTable(histfinal, r_img1);

img = cat(3, r_2, g_img1, b_img1);

figure, imshow(img);

%figure, plot(histfinal, c="b");

#alpha = calculatesTable(s0, imhist(r_img2));

