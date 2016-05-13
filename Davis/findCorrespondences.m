# Takes 2 rectified images of the same dimension, and performs sliding-
# window correspondence algorithm for disparity mapping. Uses normalized 
# cross-correlation and dual-aggregation harmonic mean to combine the 
# color channels. Also takes a window diameter and threshold level between 
# 0 and 1 representing stringency of correspondence points. 0 includes 
# everything and 1 accepts only perfect matches. 

# Returns two nx2 matrices. Each row contains the pixel coordinates of a 
# corresponding point in the rectified image. The first matrix corresponds
# to the first image passed as argument, and the second to the second.

# The mapping is injective. 

function [P1, P2] = findCorrespondences(IM1, IM2, diam, thresh)
  offset = floor(diam/2);
  w = size(IM1, 2);
  h = size(IM1, 1);
  P1 = zeros(0,2);
  P2 = zeros(0,2);
  # zero-pad the images
  im1 = zeros(h+2*offset, w+2*offset, 3);
  im2 = zeros(h+2*offset, w+2*offset, 3);
  im1(1+offset:h+offset, 1+offset:w+offset, :) = IM1;
  im2(1+offset:h+offset, 1+offset:w+offset, :) = IM2;
  # The helper function gives a non-injective mapping from the first
  # image to the second. To get an injective mapping, we run the helper
  # function again in the opposite order, and take the intersection of
  # the correspondence sets. 
  x1 = helper(im1, im2, diam, offset, thresh, h, w);
  x2 = helper(im2, im1, diam, offset, thresh, h, w);
  for i=1:size(x1, 1)
    nmatches = sum(ismember(x2,[x1(i,1),x1(i,3),x1(i,2)],'rows'));
    if nmatches>0
      P1 = [P1;x1(i,1:2)];
      P2 = [P2;[x1(i,1),x1(i,3)]];
    end
  end
  
end

# Given zero-padded images, performs sliding-window correspondence from
# the first image to the second. Returns a n*3 list of indices [y,x1,x2].
function P = helper(im1, im2, diam, offset, thresh, h, w)
  P = zeros(0,3);
  for i=1+offset:h+offset
    for j1=1+offset:w+offset
      # Create normalized window in image 1
      w1 = reshape(im1(i-offset:i+offset,j1-offset:j1+offset,:),1,diam^2,3);
      w1 = w1.-mean(w1,2);
      w1 = w1./sqrt(sum(w1.^2,2));
      best = 0;
      bestcoord = 0;
      for j2=1+offset:w+offset
        # Create normalized window in image 2
        w2 = reshape(im2(i-offset:i+offset,j2-offset:j2+offset,:),1,diam^2,3);
        w2 = w2.-mean(w2,2);
        w2 = w2./sqrt(sum(w2.^2,2));
        # Compute normalized cross-correlation and dual-aggregation h-mean
        scores = sum(w1.*w2,2);
        score = 1-3/sum(1./(1.-scores));
        if score > best
          best = score;
          bestcoord = j2;
        end
      end
      if best > thresh
        P = [P;[i-offset,j1-offset,bestcoord-offset]];
      end
    end
  end
end
