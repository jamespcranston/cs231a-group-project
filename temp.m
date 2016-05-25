if sum(pair2==pair1(1)) > 0
  c1 = pair1(2);
  c = pair1(1);
  c2 = 3-find(pair2==c);
else
  c1 = pair1(1);
  c = pair1(2);
  c2 = 3-find(pair2==c);
end
[c1,c,c2]