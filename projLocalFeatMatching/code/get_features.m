% Local Feature Stencil Code
% Written by James Hays for CS 143 @ Brown / CS 4476/6476 @ Georgia Tech

% Returns a set of feature descriptors for a given set of interest points. 

% 'image' can be grayscale or color, your choice.
% 'x' and 'y' are nx1 vectors of x and y coordinates of interest points.
%   The local features should be centered at x and y.
% 'descriptor_window_image_width', in pixels, is the local feature descriptor width. 
%   You can assume that descriptor_window_image_width will be a multiple of 4 
%   (i.e., every cell of your local SIFT-like feature will have an integer width and height).
% If you want to detect and describe features at multiple scales or
% particular orientations, then you can add input arguments.

% 'features' is the array of computed features. It should have the
%   following size: [length(x) x feature dimensionality] (e.g. 128 for
%   standard SIFT)

function [features] = get_features(image, x, y, descriptor_window_image_width)
% To start with, you might want to simply use normalized patches as your
% local feature. This is very simple to code and works OK. However, to get
% full credit you will need to implement the more effective SIFT descriptor
% (See Szeliski 4.1.2 or the original publications at
% http://www.cs.ubc.ca/~lowe/keypoints/)

% Your implementation does not need to exactly match the SIFT reference.
% Here are the key properties your (baseline) descriptor should have:
%  (1) a 4x4 grid of cells, each descriptor_window_image_width/4. 'cell' in this context
%    nothing to do with the Matlab data structue of cell(). It is simply
%    the terminology used in the feature literature to describe the spatial
%    bins where gradient distributions will be described.
%  (2) each cell should have a histogram of the local distribution of
%    gradients in 8 orientations. Appending these histograms together will
%    give you 4x4 x 8 = 128 dimensions.
%  (3) Each feature should be normalized to unit length
%
% You do not need to perform the interpolation in which each gradient
% measurement contributes to multiple orientation bins in multiple cells
% As described in Szeliski, a single gradient measurement creates a
% weighted contribution to the 4 nearest cells and the 2 nearest
% orientation bins within each cell, for 8 total contributions. This type
% of interpolation probably will help, though.

% You do not have to explicitly compute the gradient orientation at each
% pixel (although you are free to do so). You can instead filter with
% oriented filters (e.g. a filter that responds to edges with a specific
% orientation). All of your SIFT-like feature can be constructed entirely
% from filtering fairly quickly in this way.

% You do not need to do the normalize -> threshold -> normalize again
% operation as detailed in Szeliski and the SIFT paper. It can help, though.

% Another simple trick which can help is to raise each element of the final
% feature vector to some power that is less than one.

dwiw = int32(descriptor_window_image_width/2);


tamanho = length(x);
count = 1;
for i = 1:tamanho
  ax = x(i);
  ay = y(i);
  
  % teoricamente pega a janela 16x16 deslocado com o centro deslocado pra direita
  submatrix(:,:,count) = image(int32(ay-dwiw-1):int32(ay+dwiw), int32(ax-dwiw-1):int32(ax+dwiw));
  count++;
endfor

% pega a quantidade de submatrix 16x16
j = size(submatrix,3);
% itera sobre as submatrix 16x16 para calcular as 4x4
% as milhares de matrizes 16x16 estao em dezesseis_matrices(:,:,:, {1,2,3,...})

for w = 1:j
  temp = submatrix(:,:,w);  
  dezesseis_matrices(:,:,:,w) = asd(temp);
  a128 = [];
  for p=1:16
    quatro=dezesseis_matrices(:,:,p,w);
    [grad, direc] = calcula_gradient_direction(quatro);
    a128 = [a128, histogram_8bin(grad,direc)];
  endfor
  features(w,:) = a128;
endfor
size(features)

% esse tam tem que ter 16 
%tam = size(dezesseis_matrices, 3)


%Placeholder that you can delete. Empty features.
%features = zeros(size(x,1), 128, 'single');


end








