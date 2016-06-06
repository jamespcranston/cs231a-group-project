
#The wrapper function. Runs 30 times, or until convergence
function [centroids, assign] = kmeans(img,num_clusters)
  newimg = double(img);
  h = size(img,1);
  w = size(img,2);
  A = zeros(h,w);
  C = zeros(num_clusters,3);
  newC = C;
  for j = 1:num_clusters
      newC(j,:) = img(randi([1,h],1,1), randi([1,w],1,1), :);
  end
  i = 0;
  while (any(C!=newC) && i<=50)
    C = newC;
    A = assign(C,img);
    newC = average(C,A,newimg);
    i++;
  endwhile
  centroids = C;
  assign = A;
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

function result = average(C, A, img)
  h = size(img,1);
  w = size(img,2);
  result = zeros(size(C,1),3);
  for c = 1:size(C,1)
    #Find all the points that belong with centroid c
    test = find(A==c);
    #Extract the coordinates of each point
    yco = ceil(test./h .- 1);
    xco = test-yco*h;
    yco = yco.+1;
    #Find average of all selected points, if any
    if (length(test)!=0)
      total = zeros(1,3)';
      for i=1:length(test)
        total += vec(img(xco(i), yco(i),:));
      endfor
      result(c,:) += floor(total./length(test))';
    else
      result(c,:) = img(randi([1,h],1,1),randi([1,w],1,1),:);
    end
  endfor
endfunction
