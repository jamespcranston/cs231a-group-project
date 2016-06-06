function newimg = screen(img, numC)
  h = size(img,1);
  w = size(img,2);
  #figure
  smallim = img(mod([1:h],10)==0,mod([1:w],10)==0,:);
  #imshow(smallim);
  [C,A] = kmeans(smallim, numC);
  A = assign(C,double(img));
  hist = zeros(numC,1);
  for i=1:h
    hist(A(i,1)) += 1;
    hist(A(i,w)) += 1;
  end
  for i=1:w
    hist(A(1,i)) += 1;
    hist(A(h,i)) += 1;
  end
  indicator = hist > (h+w)/4;
  newimg = img;
  for i=1:h
    for j=1:w
      if indicator(A(i,j))==1
        newimg(i,j,:) = [0;0;0];
      else
        for k=1:3
          newimg(i,j,k) = min(newimg(i,j,k)+1,255);
        end
      end
    end
  end
  figure
  imshow(newimg);
end

function result = assign(C,img)
  h = size(img,1);
  w = size(img,2);
  result = zeros(h,w);
  for i = 1:h
    for j = 1:w
      #The Euclidean distance from that point to every centroid
      dist = sqrt(sum((vec(img(i,j,:))'-C(:,:)).**2, 2));
      #Sort the indices, extract the index of the lowest distance
      [s,in] = sort(dist);
      #Assign pixel to that centroid
      result(i,j)=in(1);
    endfor
  endfor
endfunction