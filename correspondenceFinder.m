PointCorrs = {};
for x=1:10
  [P1,P2]=findCorrespondences(rectifiedImgs{x,1},rectifiedImgs{x,2},Ss{x,1},Ss{x,2},7,0.75);
  PointCorrs{x,1} = P1;
  PointCorrs{x,2} = P2;
end