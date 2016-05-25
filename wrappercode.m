clc; close all;
addpath Davis;
addpath james;
addpath leahkim;

load('construct-pairs/frames.mat');
pairs = node_pairs;
window_diam = 7;
pixel_thresh = .5;

clouds = {};
pointpairs = cell(0,2);
imgcampairs = cell(0,6);
for i = size(pairs, 1)
  ind1 = pairs(i,1);
  ind2 = pairs(i,2);
  # Load both cameras and their matrices
  cam1 = frames(ind1).P;
  cam2 = frames(ind2).P;
  im1 = frames(ind1).image;
  im2 = frames(ind2).image;
  
  # Rectify cameras
  [T1, T2, P1, P2] = rectifyImages(cam1, cam2);
  im1 = zeros(4);#Rectangularize(im1, T1);
  im2 = ones(4);#Rectangularize(im2, T2);
  imgcampairs = [imgcampairs; {T1, T2, P1, P2, im1, im2}];
  
  # Generate point cloud
  [plist1,plist2] = findCorrespondences(im1, im2, window_diam, pixel_thresh);
  cloud = triangulate(P1, P2, plist1, plist2, im1, im2);
  clouds = horzcat(clouds, cloud);
end

# go through and create correspondences and similarities pairwise
for i = 1:size(pairs, 1)
  for j = i:size(pairs, 1)
    pair1 = pairs(i);
    pair2 = pairs(j);
    flip1 = 0;
    flip2 = 0;
    if sum(pair2==pair1(1)) > 0
      c1 = pair1(2);
      c = pair1(1);
      flip1 = 1;
      c2 = 3-find(pair2==c);
    else
      c1 = pair1(1);
      c = pair1(2);
      c2 = 3-find(pair2==c);
    end
    if c2==pair2(1)
      flip2 = 1;
    end
    data1 = imgcampairs(i);
    data2 = imgcampairs(j);
    p11 = pointpairs(i, find(pair1==c1));
    p12 = pointpairs(i, find(pair1==c));
    p21 = pointpairs(j, find(pair2==c));
    p22 = pointpairs(j, find(pair2==c2));
    [P1,P2] = matchedPoints(p11,p12,p21,p22,imgcampairs(i,2-flip1),imgcampairs(j,1+flip2),
    # Finish arguments, add P1,P2 to global storage structure
  end
end



# crawl the tree and apply the similarities recursively