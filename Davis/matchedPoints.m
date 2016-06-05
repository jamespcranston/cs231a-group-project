% Given two stereo pairs with a shared camera, returns two N*3 lists of 
% Euclidean world points that must correspond between the two point clouds.

% Arguments: p11,p12,p21,p22 are n*2 lists of corresponding pixel coordinates 
% discovered by the sliding window. p12 and p21 come from the rectified 
% versions of the common camera, while p11 comes from the rectified camera
% unique to stereo pair 1, and p22 comes from the rectified camera unique to
% stereo pair 2. The first index refers to the stereo pair, the second index
% refers to the camera within that pair. 

% h12 and h21 are the rectifying homographies for the common camera in each
% stereo pair. Naming convention is consistent with above. 

% m11,m12,m21,m22 are the camera matrices for the rectified cameras in the
% stereo pairs. Naming convention is consistent with above. 

% im11,im12,im21,im22 are the rectified images from cameras p11,p12,p21,p22, 
% respectively. 

% im is the original, nonrectified image coming from the shared camera

% s is the scaling factor associated with the rectified image pair

#function [P1,P2] = matchedPoints(p11,p12,p21,p22,h12,h21,m11,m12,m21,m22,im11,im12,im21,im22,im,s1,s2)
#  h = size(im,1);
#  w = size(im,2);
#  P1 = zeros(0,7);
#  P2 = zeros(0,7);
#  for y=1:h
#    for x=1:w
#      r1 = s1*h12*[x;y;1];
#      r1 = round(r1./r1(3))(1:2);
#      r2 = s2*h21*[x;y;1];
#      r2 = round(r2./r2(3))(1:2);
#      list1 = ismember(p12, r1', 'rows');
#      list2 = ismember(p21, r2', 'rows');
#      if sum(list1)>0 && sum(list2)>0
#        P1 = [P1; triangulate(m11, m12, p11(find(list1,1),:), r1', im11, im12)];
#        P2 = [P2; triangulate(m21, m22, r2', p22(find(list2,1),:), im21, im22)];
#      end
#    end
#  end
#end



#function [P1,P2] = matchedPoints(p11,p12,p21,p22,m11,m12,m21,m22,im11,im12,im21,im22,x11,x12,x21,x22,y11,y12,y21,y22,h12,h21,s1,s2)
#  P1 = zeros(0,7);
#  P2 = zeros(0,7);
#  p1 = zeros(0,2);
#  p2 = zeros(0,2);
#  for i=1:size(p12,1)
#    corrpoint = h21*inverse(h12)*[(p12(i,1)+x12)/s1;(p12(i,2)+y12)/s1;1];
#    corrpoint = corrpoint(1:2)./corrpoint(3);
#    corrpoint *= s2;
#    corrpoint -= [x21;y21];
#    dists = sum((p21 - repmat(corrpoint',size(p21,1),1)).^2,2);
#    [~,ind] = sort(dists);
#    p1 = [p1; p21(ind(1),:)];
#  end
#  for i=1:size(p21,1)
#    corrpoint = h12*inverse(h21)*[(p21(i,1)+x21)/s2;(p21(i,2)+y21)/s2;1];
#    corrpoint = corrpoint(1:2)./corrpoint(3);
#    corrpoint *= s1;
#    corrpoint -= [x12;y12];
#    dists = sum((p12 - repmat(corrpoint',size(p12,1),1)).^2,2);
#    [~,ind] = sort(dists);
#    p2 = [p2; p12(ind(1),:)];
#  end
#  size(p1)
#  size(p2)
#  for i=1:size(p12,1)
#    j = find(ismember(p21, p1(i,:), 'rows'));
#    if sum(p2(j,:)==p12(i,:))==2
#      P1 = [P1; our_triangulate(m11, m12, p11(i,:), p12(i,:), im11, im12, s1, x11, x12, y11, y12)];
#      P2 = [P2; our_triangulate(m21, m22, p21(j,:), p22(j,:), im21, im22, s2, x21, x22, y21, y22)];
#    end
#  end
#end

function [ind1,ind2] = matchedPoints(p11,p12,p21,p22,h12,h21,s12,s21,im,verbose)
  p1 = inverse(h12)*inverse(s12)*[p12';ones(1,size(p12,1))];
  p1 = p1./p1(3,:);
  p2 = inverse(h21)*inverse(s21)*[p21';ones(1,size(p21,1))];
  p2 = p2./p2(3,:);
  if verbose
    figure
    hold on
    image(im);
    scatter(p1(1,:),p1(2,:),2,'g',"filled");
    scatter(p2(1,:),p2(2,:),2,'b',"filled");
    hold off
  end
  distsx = bsxfun(@minus, p1(1,:)',p2(1,:));
  distsy = bsxfun(@minus, p1(2,:)',p2(2,:));
  dists = distsx.^2+distsy.^2;
  matsize = size(dists);
  dists = reshape(dists,1,matsize(1)*matsize(2));
  [~,i] = sort(dists);
  ind1 = zeros(20,1);
  ind2 = zeros(20,1);
  for j=1:20
    [a,b] = ind2sub(matsize, i(j));
    ind1(j) = a;
    ind2(j) = b;
  end
  ind1;
  ind2;
  if verbose
    figure
    hold on
    image(im);
    for j=1:20
      plot([p1(1,ind1(j)),p2(1,ind2(j))],[p1(2,ind1(j)),p2(2,ind2(j))],'linewidth',10);
    end
  end
end