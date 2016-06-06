clc; close all;

load('../pointCorrs.mat');
load('../finalinput.mat');
addpath Davis;
load('james/construct-pairs/node-pairs.txt');
is = [1,2,3;
2,3,11;
3,11,10;
11,10,20;
2,3,4;
3,4,5;
4,5,13;
5,13,12;
5,13,14;
13,14,15;
14,15,16;
15,16,17;
17,18,19;
4,5,6;
5,6,7;
6,7,8;
7,8,9];

Hs = {};
for j=1:17
  i1 = is(j,3);
  i0 = is(j,2);
  i2 = is(j,1);

  p1 = find(sum(node_pairs==i1,2) .* sum(node_pairs==i0,2));
  p2 = find(sum(node_pairs==i2,2) .* sum(node_pairs==i0,2));
  i11 = find(node_pairs(p1,:)==i1);
  i12 = find(node_pairs(p1,:)==i0);
  i21 = find(node_pairs(p2,:)==i0);
  i22 = find(node_pairs(p2,:)==i2);
  
  [ind1,ind2] = matchedPoints(PointCorrs{p1,i11},PointCorrs{p1,i12},PointCorrs{p2,i21},PointCorrs{p2,i22},Ts{p1,i12},Ts{p2,i21},Ss{p1,i12},Ss{p2,i21},imgs{node_pairs(p1,i12)},true);
  P1 = our_triangulate(Ps{p1,i11},Ps{p1,i12},PointCorrs{p1,i11}(ind1,:),PointCorrs{p1,i12}(ind1,:),rectifiedImgs{p1,i11},rectifiedImgs{p1,i12},Ss{p1,i11},Ss{p1,i12});
  P2 = our_triangulate(Ps{p2,i21},Ps{p2,i22},PointCorrs{p2,i21}(ind2,:),PointCorrs{p2,i22}(ind2,:),rectifiedImgs{p2,i21},rectifiedImgs{p2,i22},Ss{p2,i21},Ss{p2,i22});
  H = bestFitSimilarity(P1(:,1:4)',P2(:,1:4)');
  Hs{j}=H;
end