function mid = midpoint(ref, n1, n2)
    pt0 = ref;
    pt1 = n1;
    pt2 = n2;
    mid1 = [(pt0(1)+pt1(1))/2, (pt0(2)+pt1(2))/2, (pt0(3)+pt1(3))];
    mid2 = [(pt0(1)+pt2(1))/2, (pt0(2)+pt2(2))/2, (pt0(3)+pt2(3))];
    mid = [(mid1(1)+mid2(1))/2, mid1(
end