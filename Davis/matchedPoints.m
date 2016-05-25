# Given two stereo pairs with a shared camera, returns two 3*N lists of 
# Euclidean world points that must correspond between the two point clouds.

# Arguments: p11,p12,p21,p22 are n*2 lists of corresponding pixel coordinates 
# discovered by the sliding window. p12 and p21 come from the rectified 
# versions of the common camera, while p11 comes from the rectified camera
# unique to stereo pair 1, and p22 comes from the rectified camera unique to
# stereo pair 2. The first index refers to the stereo pair, the second index
# refers to the camera within that pair. 

# h12 and h21 are the rectifying homographies for the common camera in each
# stereo pair. Naming convention is consistent with above. 

# m11,m12,m21,m22 are the camera matrices for the rectified cameras in the
# stereo pairs. Naming convention is consistent with above. 

# im1, im2, and im3 are the images from camera p11, p12/p21, and p22, 
# respectively. They are used to find sizes and retrieve color information. 

function [P1,P2] = matchedPoints(p11,p12,p21,p22,h12,h21,m11,m12,m21,m22,im11,im12,im21,im22)
  h = size(im1,1);
  w = size(im1,2);
  P1 = zeros(0,7);
  P2 = zeros(0,7);
  for y=1:h
    for x=1:w
      r1 = h12*[x;y;1];
      r1 = round(r1./r1(3))(1:2);
      r2 = h21*[x;y;1];
      r2 = round(r2./r2(3))(1:2);
      list1 = ismember(p12, r1', 'rows');
      list2 = ismember(p21, r2', 'rows');
      if sum(list1)>0 && sum(list2)>0
        P1 = [P1; triangulate(m11, m12, p11(find(list1,1),:), r1', im11, im12)];
        P2 = [P2; triangulate(m21, m22, r2', p22(find(list2,1),:), im21, im22)];
      end
    end
  end
end