% Written by Henry Hu for CSCI 1430 @ Brown and CS 4495/6476 @ Georgia Tech

% Find the best fundamental matrix using RANSAC on potentially matching
% points

% 'matches_a' and 'matches_b' are the Nx2 coordinates of the possibly
% matching points from pic_a and pic_b. Each row is a correspondence (e.g.
% row 42 of matches_a is a point that corresponds to row 42 of matches_b.

% 'Best_Fmatrix' is the 3x3 fundamental matrix
% 'inliers_a' and 'inliers_b' are the Mx2 corresponding points (some subset
% of 'matches_a' and 'matches_b') that are inliers with respect to
% Best_Fmatrix.

% For this section, use RANSAC to find the best fundamental matrix by
% randomly sample interest points. You would reuse
% estimate_fundamental_matrix() from part 2 of this assignment.

% If you are trying to produce an uncluttered visualization of epipolar
% lines, you may want to return no more than 30 points for either left or
% right images.

function [ Best_Fmatrix, inliers_ind] = ransac_fundamental_matrix(matches_a, matches_b)    
    % declaracao da matriz de inliers para executar o if no primeiro caso
    inliers_ind = [0,0];
    
    % quantidade de pontos aleatorios que serao utilizados
    sampled_points = 4;
    
    % limite escolhido empiricamente
    threshold = 5;
    
    % quantidade maxima de matches para gerar indexes aleatorios até este
    % valor
    max_points_size = size(matches_a, 1);
    
    x_source = matches_a(:,1);
    y_source = matches_a(:,2);
    
    x2_source = matches_b(:,1);
    y2_source = matches_b(:,2);
    
    % laço externo do RANSAC, apesar da formula é utilizado uma quantidade
    % fixa de iterações, pois não sabemos a taxa de outliers de todas as
    % imagens
    for i = 1:10000
      % pega indexes aleatorios dentro do intervalo dos matches
      random_points = randperm(max_points_size, sampled_points);
      
      % pega os pontos aleatorios do matche a
      pr_a  = matches_a(random_points, :);
      
      % pega os pontos aleatorios do matche b
      pr_b  = matches_b(random_points, :);
      
      % estima a matriz fundamental com a amostra gerada randomicamente
      Temp_Fmatrix = est_homography(pr_a(:,1), pr_a(:,2), pr_b(:,1), pr_b(:,2));
      
      % declaração dos inliers preenchendo com zeros
      inliers = zeros(max_points_size,1);
      
      [x_correspondente, y_correspondente] = apply_homography(Temp_Fmatrix, x2_source, y2_source);
      
      
      % laço interno para calcular o erro com a matriz fundamental
      % obtida
      for j = 1:max_points_size
          b = [x_correspondente(j); y_correspondente(j); 1];
          a = [x_source(j); y_source(j); 1];
          ssd = sum((a-b).^2);
          % verifica se o erro é menor que o threshold definido se sim
          % coloca 1 no array com o index do matche "correto"

          inliers(j) = abs(ssd) < threshold;
          
      end
      
      % verifica se a quantidade de inliers calculada é maior que a
      % quantidade de inliers da iteração anterior
      
      if sum(inliers) > size(inliers_ind,1)
        % a melhor matriz fundamental recebe a nova melhor matriz
        % fundamental
        Best_Fmatrix = Temp_Fmatrix;

        % pega o indice dos inliers 
        inliers_ind = find(inliers);
        
      end
    end

end

