function mid = avgMidpoint(pts)

for i=1:size(pts,1)
    x(i) = pts(i,1);
    y(i) = pts(i,2);
    z(i) = pts(i,3);
end
mX = mean(x);
mY = mean(y);
mZ = mean(z);
mid = [mX,mY,mZ];
end