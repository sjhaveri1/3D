%tester3

%initial plot
figure
pt0 = [0,0,0];
pt1 = [1,2,1];
pt2 = [2,2,1];
pt3 = [3,1,1];

plot3(pt0(1),pt0(2),pt0(3),'k.','MarkerSize',20), hold on, grid on
plot3(pt1(1),pt1(2),pt1(3),'r.','MarkerSize',20), hold on
plot3(pt2(1),pt2(2),pt2(3),'g.','MarkerSize',20), hold on
plot3(pt3(1),pt3(2),pt3(3),'b.','MarkerSize',20), hold on
xlabel('x')
ylabel('y')
zlabel('z')

plot3([pt0(1) pt1(1)],[pt0(2) pt1(2)],[pt0(3) pt1(3)], 'b'), hold on

plot3([pt0(1) pt2(1)],[pt0(2) pt2(2)],[pt0(3) pt2(3)], 'b'), hold on

plot3([pt0(1) pt3(1)],[pt0(2) pt3(2)],[pt0(3) pt3(3)], 'b'), hold on

trueMid = [(pt0(1)+pt1(1)+pt2(1)+pt3(1))/4, (pt0(2)+pt1(2)+pt2(2)+pt3(2))/4,(pt0(3)+pt1(3)+pt2(3)+pt3(3))/4];
%trueMid = [1 1 0];
plot3(trueMid(1),trueMid(2),trueMid(3),'y.', 'MarkerSize',20)

plot3([pt0(1) trueMid(1)],[pt0(2) trueMid(2)], [pt0(3) trueMid(3)], 'b--'), hold on
plot3([trueMid(1) pt1(1)],[trueMid(2) pt1(2)], [trueMid(3) pt1(3)], 'b-.'), hold on
plot3([trueMid(1) pt2(1)],[trueMid(2) pt2(2)], [trueMid(3) pt2(3)], 'b-.'), hold on
plot3([trueMid(1) pt3(1)],[trueMid(2) pt3(2)], [trueMid(3) pt3(3)], 'b-.'), hold on

ted = tripDist(pt0,pt1) + tripDist(pt0,pt2) + tripDist(pt0,pt3);
ted1 = (tripDist(pt0,trueMid) + tripDist(trueMid,pt1) + tripDist(trueMid,pt2) + tripDist(trueMid,pt3));



