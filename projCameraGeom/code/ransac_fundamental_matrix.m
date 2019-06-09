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
    %%%%%%%%%%%%%%%%
    % Your code here
    %%%%%%%%%%%%%%%%
    inliers_a = [0,0];

    sampled_points = 8;
    threshold = 0.5;
    max_points_size = size(matches_a, 1);
    p = 0.99;
    outlier_ratio = 0.5;
    number_of_iterations = log(1 - p) / log(1-(1 - outlier_ratio) ^ sampled_points);

    for i = 1:number_of_iterations
      random_points = randperm(max_points_size, sampled_points);

      points_random_a  = matches_a(random_points, :);
      points_random_b  = matches_b(random_points, :);

      Temp_Fmatrix = estimate_fundamental_matrix(points_random_a, points_random_b);
      inliers = zeros(max_points_size,1);
      for j = 1:max_points_size
          matrix_A = [matches_a(j,:), 1]';
          matrix_B = [matches_b(j,:), 1];
          distance = matrix_B * Temp_Fmatrix * matrix_A;

          if distance < threshold
              inliers(j) = 1;
          end

      end

      if sum(inliers) > size(inliers_a,1)
        Best_Fmatrix = Temp_Fmatrix;
        inliers_a = matches_a(find(inliers),:);
        inliers_b = matches_b(find(inliers),:);
      end
    end

%     Best_Fmatrix = estimate_fundamental_matrix(matches_a(1:10,:), matches_b(1:10,:));
%     inliers_a = matches_a(1:30,:);
%     inliers_b = matches_b(1:30,:);
end

