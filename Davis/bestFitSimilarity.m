% Takes two 4xn lists of corresponding points in projective coordinates, and
% returns the best-fit similarity transformation H for converting A, the first
% list, into B, the second list. Finds the exact scale and translation so that
% the location of and mean distance from the centroids of H*A and B are 
% identical, and uses SVD to find the best-fit rotation. 

function H = bestFitSimilarity(A, B)
  centroidA = mean(A,2);
  centroidB = mean(B,2);
  n = size(A,2);
  % Normalize the points: set centroid to zero
  newA = A-repmat([centroidA(1:3);1],1,n);
  newB = B-repmat([centroidB(1:3);1],1,n);
  % Rescale the points so that the mean distance from the centroid is 1
  distA = mean(sqrt(sum(newA.^2)));
  distB = mean(sqrt(sum(newB.^2)));
  newA = [newA(1:3,:)./distA;newA(4,:)];
  newB = [newB(1:3,:)./distB;newB(4,:)];
  % Find optimal rotation, scale it
  [U,S,V] = svd(newA(1:3,:)*newB(1:3,:)');
  R = V*U';
  R = distB*R./distA;
  % Find the translation
  T = -R*centroidA(1:3)+centroidB(1:3);
  % Put it all together
  H = [R,T;[0,0,0,1]]; 
end