%node1, node2 = 1x3 vector of x,y,z coords

function trippy = tripDist(node1,node2)
    trippy = sqrt(((node2(1)-node1(1))^2)+((node2(2)-node1(2))^2)+((node2(3)-node1(3))^2));
end