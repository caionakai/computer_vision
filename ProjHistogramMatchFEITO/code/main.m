% load image package
pkg load image;

%% Setup
% Read images and convert to floating point format
image1 = im2single(imread('../data/img1_patch.png'));
image2 = im2single(imread('../data/img2_patch.png'));

final = im2single(imread('../data/img2.png'));

% separate the channels into RED, GREEN, BLUE, respectively
r_img1 = im2uint8(image1(:,:,1));
g_img1 = im2uint8(image1(:,:,2));
b_img1 = im2uint8(image1(:,:,3));
% the same for img2
r_img2 = im2uint8(image2(:,:,1));
g_img2 = im2uint8(image2(:,:,2));
b_img2 = im2uint8(image2(:,:,3));

r_final = im2uint8(final(:,:,1));
g_final = im2uint8(final(:,:,2));
b_final = im2uint8(final(:,:,3));


s0 = [[5,2];[128,128];[250,250]];
#figure, plot(imhist(r_img1), c="r");
histfinal = simulated_annealing(s0, 0.1, 0.00001, r_img2, r_img1);
histfinal2 = simulated_annealing(s0, 0.1, 0.00001, g_img2, g_img1);
histfinal3 = simulated_annealing(s0, 0.1, 0.00001, b_img2, b_img1);

#figure, plot(imhist(r_img2), c="g");
r_2 = xau(histfinal, r_img2);
g_2 = xau(histfinal2, g_img2);
b_2 = xau(histfinal3, b_img2);

img = cat(3, r_2, g_2, b_2);

#r_2 = xau(histfinal, r_final);
#g_2 = xau(histfinal2, g_final);
#b_2 = xau(histfinal3, b_final);
%g_2 = calculatesTable(histfinal2, g_img1);
%b_2 = calculatesTable(histfinal3, b_img1);

#resultfinal = cat(3, r_2, g_2, b_2);

imwrite(img, "DEMONIODOGASOCULTO.png");



