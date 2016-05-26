# Given an image and its rectifying transformation, returns the square-pixel 
# rendering of the smallest rectangle that bounds the rectified image, and
# its vertical offset from the origin of the camera coordinate system. 
# Portions outside the original image are colored black, and original image
# intensities are raised by 1 so that 0 signals 'out of image'. The 'verbose'
# argument is true if you want to see graphical representations of the output,
# false otherwise. 

#close all; clc;
function [y,result] = buildRectified(im, H, verbose)
  [h, w, ~] = size(im);
  # Change the coordinate system to match the vertical indexing of pixels
  T = [H(2,:);H(1,:);H(3,:)];
  T = [T(:,2),T(:,1),T(:,3)];
  Ti = inverse(T);
  # Find the corners of the rectified image
  a = T*[1,1,1]';
  a = a(1:2)./a(3);
  b = T*[1,w,1]';
  b = b(1:2)./b(3);
  c = T*[h,1,1]';
  c = c(1:2)./c(3);
  d = T*[h,w,1]';
  d = d(1:2)./d(3);
  # Find the bounding box for the outer rectangle
  left = floor(min(a(2),c(2)));
  right = ceil(max(b(2),d(2)));
  top = floor(min(a(1),b(1)));
  bottom = ceil(max(c(1),d(1)));
  # Visual checking
  if verbose
    figure
    hold('on')
    image(im)
    plot(0,0)
    hold('off')
    figure
    aa = [top,left]';
    bb = [top,right]';
    cc = [bottom,left]';
    dd = [bottom,right]';
    plot([a,b,d,c,a](2,:),[a,b,d,c,a](1,:),[aa,bb,dd,cc,aa](2,:),[aa,bb,dd,cc,aa](1,:));
  end
  # Populate the pixels in the rectangle. Color value is the weighted avg of
  # the 4 nearest pixels, weighted by distance from the reprojected point
  x = left;
  y = top;
  result = zeros(bottom-top,right-left,3);
  for i=1:bottom-top
    for j=1:right-left
      p = Ti*[i+y;j+x;1];
      p = p(1:2)./p(3);
      patch = zeros(1,1,3);
      if p(1) > 1 && p(1) < h && p(2) > 1 && p(2) < w
        a = floor(p(1));
        b = floor(p(2));
        patch = double(im(a:a+1,b:b+1,:));
        dists = [norm([a;b]-p),norm([a;b+1]-p);norm([a+1;b]-p),norm([a+1;b+1]-p)];
        patch .*= repmat(dists,1,1,3);
        patch = sum(sum(patch));
        patch ./= sum(sum(dists));
        patch = round(min(patch.+1, 255));
      end
      result(i,j,:) = patch;
    end
  end
  # More visual checking
  if verbose
    figure
    hold('on')
    image(result./255)
    axis square
    hold('off')
  end
end