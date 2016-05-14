h = size(im,1);
w = size(im,2);
P1 = zeros(0,4);
P2 = zeros(0,4);
for y=1:h
  for x=1:w
    r1 = h12*[x;y;1];
    r1 = round(r1./r1(3))(1:2);
    r2 = h21*[x;y;1];
    r2 = round(r2./r2(3))(1:2);
    list1 = ismember(p12, r1', 'rows');
    list2 = ismember(p21, r2', 'rows');
    if sum(list1)>0 && sum(list2)>0
      P1 = [P1; triangulate(m11, m12, p11(find(list1,1),:), r1')];
      P2 = [P2; triangulate(m21, m22, r2', p22(find(list2,1),:))];
    end
  end
end