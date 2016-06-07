fullMaps = {};
fullMaps{1} = eye(4);
fullMaps{2} = Hs{1};
fullMaps{3} = Hs{1}*Hs{5};
fullMaps{4} = Hs{1}*Hs{2};
fullMaps{5} = Hs{1}*Hs{5}*Hs{6};
fullMaps{6} = Hs{1}*Hs{5}*Hs{6}*Hs{15};
fullMaps{7} = Hs{1}*Hs{5}*Hs{6}*Hs{7};
fullMaps{8} = Hs{1}*Hs{5}*Hs{6}*Hs{15}*Hs{16};
fullMaps{9} = Hs{1}*Hs{5}*Hs{6}*Hs{15}*Hs{16}*Hs{17};
fullMaps{10} = Hs{1}*Hs{5}*Hs{6}*Hs{15}*Hs{16}*Hs{17}*Hs{18};
fullMaps{11} = Hs{1}*Hs{2}*Hs{3};
fullMaps{12} = Hs{1}*Hs{2}*Hs{3}*Hs{4};
fullMaps{13} = Hs{1}*Hs{5}*Hs{6}*Hs{7}*Hs{8};
fullMaps{14} = Hs{1}*Hs{5}*Hs{6}*Hs{7}*Hs{9};
fullMaps{15} = Hs{1}*Hs{5}*Hs{6}*Hs{7}*Hs{9}*Hs{10};
fullMaps{16} = Hs{1}*Hs{5}*Hs{6}*Hs{7}*Hs{9}*Hs{10}*Hs{11};
fullMaps{17} = Hs{1}*Hs{5}*Hs{6}*Hs{7}*Hs{9}*Hs{10}*Hs{11}*Hs{12};
fullMaps{18} = Hs{1}*Hs{5}*Hs{6}*Hs{7}*Hs{9}*Hs{10}*Hs{11}*Hs{12}*Hs{13};
fullMaps{19} = Hs{1}*Hs{5}*Hs{6}*Hs{7}*Hs{9}*Hs{10}*Hs{11}*Hs{12}*Hs{13}*Hs{14};

adjustClouds = {};
for i=1:19
  c = fullMaps{i}*clouds{i}(:,1:4)';
  c = c./c(4,:);
  c = [c;clouds{i}(:,5:7)'];
  adjustClouds{i}=c;
end
