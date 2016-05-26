Code in this folder:

buildRectified: takes an image and a projective transformation. Applies the transformation, and builds a square-pixel version of the original image. Returns the image and its vertical offset from the origin. 

findCorrespondences: takes two rectified images and performs the sliding window algorithm on them. Returns two lists of pixel coordinates, where the ith entry in each list is a corresponding pixel. 

matchedPoints: takes two point clouds with a common camera, and uses the common camera to generate point correspondences between the clouds. Needs revision as of 5/25. 

triangulate: takes two lists of corresponding pixels, and two camera matrices, and finds the world point corresponding to each pixel in the list. Each world point is 7-dimensional: 4 projective coordinates, plus 3 color channel values. 