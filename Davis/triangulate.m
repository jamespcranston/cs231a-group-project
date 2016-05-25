# Takes 3x4 projective camera matrices M1 and M2, along with two nx2
# matrices of pixel coordinates [y,x] and returns the nx7 list of 
# corresponding world points in normalized projective coordinates. 
# Also takes the two images, and maps the mean color value of the 
# corresponding points onto the world point as coordinates 5-7 (so the world
# point is 7-dimensional, with 4 projective coordinates + 3 color coordinates). 

function P = triangulate(M1, M2, p1, p2, im1, im2)
  n = size(p1, 1);
  P = zeros(n,7);
  for i=1:n
    # Point indices are switched compared to matrix indices because pixel
    # coordinates are indexed vertically, then horizontally
    A = [ 
    p1(i,2)*M1(3,:) - M1(1,:);
    p1(i,1)*M1(3,:) - M1(2,:);
    p2(i,2)*M2(3,:) - M2(1,:);
    p2(i,1)*M2(3,:) - M2(2,:);
    ];
    [~,~,V] = svd(A);
    P(i,1:4) = V(:,4)'./V(4,4);
    P(i,5:7) = (im1(p1(i,1),p1(i,2),:).+im2(p2(i,1),p2(i,2),:))./2
  end
end