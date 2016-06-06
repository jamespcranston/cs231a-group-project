a1 = rand(2,5);
a2 = rand(2,5);

subplot(211)
scatter(a1(1,:),a1(2,:));
[xa1, ya1] = ds2nfu(a1(1,:),a1(2,:));

subplot(212)
scatter(a2(1,:),a2(2,:));
[xa2, ya2] = ds2nfu(a2(1,:),a2(2,:));

for k=1:numel(xa1)
    annotation('line', [xa1(k) xa2(k)], [ya1(k) ya2(k)], 'color', 'r');
end