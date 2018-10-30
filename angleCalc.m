function theta = angleCalc(ref,node1,node2)
    temp1 = [abs(node1(1)-ref(1)),abs(node1(2)-ref(2)), abs(node1(3)-ref(3))];
    temp2 = [abs(node2(1)-ref(1)),abs(node2(2)-ref(2)), abs(node1(3)-ref(3))];
    
    dp = (temp1(1)*temp2(1)) + (temp1(2)*temp2(2) + (temp1(3)*temp2(3));
    theta = radtodeg(acos(dp/(norm(temp1)*norm(temp2))));
end