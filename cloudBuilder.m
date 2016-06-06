addpath Davis
clouds = {19,1};
for x=1:19
  x
  P=our_triangulate(Ps{x,1},Ps{x,2},PointCorrs{x,1},PointCorrs{x,2},rectifiedImgs{x,1},rectifiedImgs{x,2},Ss{x,1},Ss{x,2});
  clouds{x} = P;
end