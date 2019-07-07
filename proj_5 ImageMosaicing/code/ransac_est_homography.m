function [H, inlier_ind] = ransac_est_homography(y1, x1, y2, x2, thresh, iter, im1, im2, verbose)
% RANSAC_EST_HOMOGRAPHY estimates the homography between two corresponding
% feature points through RANSAC. im2 is the source and im1 is the destination.

% INPUT
% y1,x1,y2,x2 = corresponding point coordinate vectors Nx1
% thresh      = threshold on distance to see if transformed points agree
% iter        = iteration number for multiple image stitching
% im1, im2    = images

% OUTPUT
% H           = the 3x3 matrix computed in final step of RANSAC
% inlier_ind  = nx1 vector with indices of points that were inliers


if nargin < 9
   verbose = false; 
end

% original feature matches


%% PUT YOUR CODE HERE %%
% declaracao da matriz de inliers para executar o if no primeiro caso
inlier_ind = [0,0];

% quantidade de pontos aleatorios que serao utilizados
sampled_points = 8;

% limite escolhido empiricamente
threshold = 5;

% quantidade maxima de matches para gerar indexes aleatorios até este
% valor
N = size(x1, 1);

% laço externo do RANSAC
for i = 1:10000
  % pega indexes aleatorios dentro do intervalo dos matches
  random_points = randperm(N, sampled_points);

  % pega os pontos aleatorios dos matches da imagem 1
  x1_random = x1(random_points);
  y1_random = y1(random_points);
  % pega os pontos aleatorios dos matches da imagem 2
  x2_random = x2(random_points);
  y2_random = y2(random_points);

  % estima a homografia com a amostra gerada randomicamente
  H_temp = est_homography(x1_random, y1_random, x2_random, y2_random);

  % função que aplica a homografia calculada anteriormente
  [x_correspondente, y_correspondente] = apply_homography(H_temp, x2, y2);


  % calcula o erro e verifica (para todos os pontos), se o erro é menor que o threshold definido 
  inliers = ((x_correspondente - x1).^2 +(y_correspondente - y1).^2 ) < threshold;
  
  % verifica se a quantidade de inliers calculada é maior que a
  % quantidade de inliers da iteração anterior
  if sum(inliers) > size(inlier_ind,1)
    % salva a melhor a homografia
    H = H_temp;

    % pega o indice dos inliers 
    inlier_ind = find(inliers);

  end
end
% recomputa a homografia
H = est_homography(x1(inlier_ind), y1(inlier_ind), x2(inlier_ind), y2(inlier_ind));
[x_correspondente, y_correspondente] = apply_homography(H, x2, y2);
inliers = ((x_correspondente - x1).^2 +(y_correspondente - y1).^2 ) < threshold;
inlier_ind = find(inliers);

%% PLACEHOLDER CODE TO PLOT ONLY THE INLIERS WHEN YOU WERE DONE
% inlier_ind = 1:min(size(y1,1),size(y2,1));
% H = est_homography(x1,y1,x2,y2);
%% DELETE THE ABOVE LINES WHEN YOU WERE DONE

% Plot the verbose details
if ~verbose
    return
end

dh1 = max(size(im2,1)-size(im1,1),0);
dh2 = max(size(im1,1)-size(im2,1),0);
close all;
h = figure(1)

% Original Matches
subplot(2,1,1);
imshow([padarray(im1,dh1,'post') padarray(im2,dh2,'post')]);
delta = size(im1,2);
line([x1'; x2' + delta], [y1'; y2']);
title(sprintf('%d Original matches', N));
axis image off;

% Inlier Matches
subplot(2,1,2);
imshow([padarray(im1,dh1,'post') padarray(im2,dh2,'post')]);
delta = size(im1,2);
line([x1(inlier_ind)'; x2(inlier_ind)' + delta], [y1(inlier_ind)'; y2(inlier_ind)']);
title(sprintf('%d (%.2f%%) inliner matches out of %d', size(inlier_ind,1), 100*size(inlier_ind,1)/N, N));
axis image off;
drawnow;

% Save the figures
p         = mfilename('fullpath');
rootDir = fileparts(fileparts(p));
outputDir = fullfile(rootDir, 'results/');
if ~exist(outputDir, 'dir')
    mkdir(outputDir);
end
fileString = fullfile(outputDir, ['matches', num2str(iter,'%02d')]);
fig_save(h, fileString, 'png');
end
% close(h);
