function testfit(H, test, test2)
  new = H*test';
  figure
  hold on
  plot3(test2'(1,:),test2'(2,:),test2'(3,:));
  plot3(test'(1,:),test'(2,:),test'(3,:),'color','r');
  plot3(new(1,:),new(2,:),new(3,:),'color','g');
  hold off

end