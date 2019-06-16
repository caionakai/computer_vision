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

function [ Best_Fmatrix, inliers_a, inliers_b] = ransac_fundamental_matrix(matches_a, matches_b)    
    % declaracao da matriz de inliers para executar o if no primeiro caso
    inliers_a = [0,0];
    
    % quantidade de pontos aleatorios que serao utilizados
    sampled_points = 8;
    
    % limite escolhido empiricamente
    threshold = 0.001;
    
    % quantidade maxima de matches para gerar indexes aleatorios até este
    % valor
    max_points_size = size(matches_a, 1);
    
    % probabilidade de que pelo menos uma amostra aleatoria é livre de
    % outliers
    p = 0.99;
    
    % porcentagem de outlier (só é conhecido a taxa do Mount Rushmore)
    outlier_ratio = 0.3;
    
    % quantidade de iterações baseada na fórmula, porém é necessário
    % conhecer a taxa de outlier
    number_of_iterations = log(1 - p) / log(1-(1 - outlier_ratio) ^ sampled_points);

    % laço externo do RANSAC, apesar da formula é utilizado uma quantidade
    % fixa de iterações, pois não sabemos a taxa de outliers de todas as
    % imagens
    for i = 1:1000
      % pega indexes aleatorios dentro do intervalo dos matches
      random_points = randperm(max_points_size, sampled_points);
      
      % pega os pontos aleatorios do matche a
      points_random_a  = matches_a(random_points, :);
      
      % pega os pontos aleatorios do matche b
      points_random_b  = matches_b(random_points, :);
      
      % estima a matriz fundamental com a amostra gerada randomicamente
      Temp_Fmatrix = estimate_fundamental_matrix(points_random_a, points_random_b);
      
      % declaração dos inliers preenchendo com zeros
      inliers = zeros(max_points_size,1);
      
      % laço interno para calcular o erro com a matriz fundamental
      % obtida
      for j = 1:max_points_size
          % transposta do matche a mais a coordenada homogenea
          matrix_A = [matches_a(j,:), 1]';
          
          % adiciona a coordenada homogenea no matche b
          matrix_B = [matches_b(j,:), 1];
          
          % calcula o erro 
          err = matrix_B * Temp_Fmatrix * matrix_A;
          
          % verifica se o erro é menor que o threshold definido se sim
          % coloca 1 no array com o index do matche "correto"
          inliers(j) = abs(err) < threshold;
      end
      
      % verifica se a quantidade de inliers calculada é maior que a
      % quantidade de inliers da iteração anterior
      if sum(inliers) > size(inliers_a,1)
        % a melhor matriz fundamental recebe a nova melhor matriz
        % fundamental
        Best_Fmatrix = Temp_Fmatrix;
        
        % insere na matriz de inliers a os novos inliers calculados
        inliers_a = matches_a(find(inliers),:);
        
        % pega o indice dos inliers 
        %index_a = find(inliers);
        
        % insere na matriz de inliers b os novos inliers calculados
        inliers_b = matches_b(find(inliers),:);
      end
    end

end

