# Takes 3x4 projective camera matrices M1 and M2, along with two image
# points (projective OR euclidean) and returns the corresponding world 
# point in normalized projective coordinates. 

function X = triangulate(M1, M2, p1, p2)
  A = [ 
  p1(1)*M1(3,:) - M1(1,:);
  p1(2)*M1(3,:) - M1(2,:);
  p2(1)*M2(3,:) - M2(1,:);
  p2(2)*M2(3,:) - M2(2,:);
  ];
  [U,S,V] = svd(A);
  X = V(:,4)./V(4,4);
end