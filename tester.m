
%initial plot
figure
pt0 = [0,0];
pt1 = [1,2];
pt2 = [2,2];
pt3 = [3,1];

plot(pt0(1),pt0(2),'b.','MarkerSize',20), hold on
plot(pt1(1),pt1(2),'b.','MarkerSize',20), hold on
plot(pt2(1),pt2(2),'b.','MarkerSize',20), hold on
plot(pt3(1),pt3(2),'b.','MarkerSize',20), hold on

plot([pt0(1) pt1(1)],[pt0(2) pt1(2)], 'b'), hold on
mid1 = [(pt0(1)+pt1(1))/2, (pt0(2)+pt1(2))/2];

plot([pt0(1) pt2(1)],[pt0(2) pt2(2)], 'b'), hold on
mid2 = [(pt0(1)+pt2(1))/2, (pt0(2)+pt2(2))/2];

plot([pt0(1) pt3(1)],[pt0(2) pt3(2)], 'b'), hold on, grid on
mid3 = [(pt0(1)+pt3(1))/2, (pt0(2)+pt3(2))/2];

plot(mid1(1),mid1(2),'r.','MarkerSize',20), hold on
plot(mid2(1),mid2(2),'r.','MarkerSize',20), hold on
plot(mid3(1),mid3(2),'r.','MarkerSize',20), hold on

merge1 = [(mid1(1)+mid2(1))/2, (mid1(2)+mid2(2))/2];
merge2 = [(mid2(1)+mid3(1))/2, (mid2(2)+mid3(2))/2];

plot(merge1(1),merge1(2),'g.', 'MarkerSize',20)
plot(merge2(1),merge2(2),'g.', 'MarkerSize',20)

trueMid = [(merge1(1)+merge2(1))/2, (merge1(2)+merge2(2))/2];
plot(trueMid(1),trueMid(2),'k.', 'MarkerSize',20)

plot([pt0(1) trueMid(1)],[pt0(2) trueMid(2)], 'b--'), hold on
plot([trueMid(1) pt1(1)],[trueMid(2) pt1(2)], 'b-.'), hold on
plot([trueMid(1) pt2(1)],[trueMid(2) pt2(2)], 'b-.'), hold on
plot([trueMid(1) pt3(1)],[trueMid(2) pt3(2)], 'b-.'), hold on
ted1 = 8.22677;



