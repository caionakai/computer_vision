% Local Feature Stencil Code
% Written by James Hays for CS 143 @ Brown / CS 4476/6476 @ Georgia Tech

% 'features1' and 'features2' are the n x feature dimensionality features
%   from the two images.
% If you want to include geometric verification in this stage, you can add
% the x and y locations of the features as additional inputs.
%
% 'matches' is a k x 2 matrix, where k is the number of matches. The first
%   column is an index in features1, the second column is an index
%   in features2. 
% 'Confidences' is a k x 1 matrix with a real valued confidence for every
%   match.
% 'matches' and 'confidences' can empty, e.g. 0x2 and 0x1.
function [matches, confidences] = match_features(features1, features2)

% This function does not need to be symmetric (e.g. it can produce
% different numbers of matches depending on the order of the arguments).

% To start with, simply implement the "ratio test", equation 4.18 in
% section 4.1.3 of Szeliski. For extra credit you can implement various
% forms of spatial verification of matches.


% Placeholder that you can delete. Random matches and confidences
num_features = min(size(features1, 1), size(features2,1));


k = 1;
# euclidean distance
for i=1:num_features
  for j = 1:num_features
    % distancia euclidiana entre uma feature e todas as outras da outra imagem
    euclideanDistance(i,j) = sum(sqrt(((features1(i,:) - features2(j,:)).^2)));
  endfor
  % sort the euclideanDistances
  [sorted_euclidean_distance(i,:), sort_index(i,:)] = sort(euclideanDistance(i,:));
  % nndr = d1/d2 (Szeliski 4.18)
  value = sorted_euclidean_distance(i,1)/sorted_euclidean_distance(i,2);
  if sorted_euclidean_distance(i,1)/sorted_euclidean_distance(i,2) < 0.9
    confidences(k) = sorted_euclidean_distance(i,1);
    %confidences(k) = value;
    matches(k,1) = i;
    matches(k,2) = sort_index(i,1);
    k++;
  endif
  
endfor


%matches
%matches = zeros(num_features, 2);
%matches(:,1) = randperm(num_features); 
%matches(:,2) = randperm(num_features);
%confidences = rand(num_features,1);
% Sort the matches so that the most confident onces are at the top of the
% list. You should not delete this, so that the evaluation
% functions can be run on the top matches easily.

[confidences, ind] = sort(confidences, 'descend');
matches = matches(ind,:);