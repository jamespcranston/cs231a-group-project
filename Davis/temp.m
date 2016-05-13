IM1 = 255.*rand(10,10,3);
IM2 = 255.*rand(10,10,3);
diam = 5;
thresh = 0.9;


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
      P1 = [P1;[i,j1]];
      P2 = [P2;[i,bestcoord]];
    end
  end
end