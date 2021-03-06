function mid = midpoint(ref, n1, n2)

    mid1 = [(ref(1)+n1(1))/2, (ref(2)+n1(2))/2, (ref(3)+n1(3))/2];
    mid2 = [(ref(1)+n2(1))/2, (ref(2)+n2(2))/2, (ref(3)+n2(3))/2];
    mid = [(mid1(1)+mid2(1))/2, (mid1(2)+mid2(2))/2, (mid1(3)+mid2(3))/2];
    
end