for i=1:19
  for j=1:2
    figure
    hold on
    image(rectifiedImgs{i,j}/255);
    scatter(PointCorrs{i,j}(:,2),PointCorrs{i,j}(:,1));
  end
end