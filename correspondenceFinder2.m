PointCorrs2 = {};
for x=11:19
  [P1,P2]=findCorrespondences(rectifiedImgs{x,1},rectifiedImgs{x,2},Ss{x,1},Ss{x,2},7,0.75);
  PointCorrs2{x-10,1} = P1;
  PointCorrs2{x-10,2} = P2;
end