

function [pts,finalLeaves,extra] = branch(cxns,full,node,maxAngle,regions)
r = getRegion(node,regions);
targets1 = targetList(cxns,node);
targets1 = [targets1(:,1), zeros(length(targets1),1)];
j=1;
k=1;
for i=1:length(targets1)
    %removes self connections and same region nodes
    if and(targets1(i,1) ~= node,getRegion(targets1(i,1),regions) ~= r)
        targets(j,:) = targets1(i,:);
        j=j+1;
    else
        extra(k,1) = targets1(i,1);
        k = k+1;
    end
end
for i=1:length(targets)
    temp_regions(i,1) = getRegion(targets(i,1), regions);
end
temp_reg = temp_regions(1);
k=1;
j=1;
for i=1:length(temp_regions)
    if temp_regions(i) == temp_reg
        temp(j,:) = targets(i,:);
        j = j+1;
        temp_reg = temp_regions(i);
        if i == length(temp_regions)
            tempcell{k} = temp;
        end
    else
        tempcell{k} = temp;
        k=k+1;
        clear temp
        temp(1,:) = targets(i,:);
        temp_reg = temp_regions(i);
        j=2;
    end
end
ref = full(node,2:4);
%for x=1:length(targets)
x = length(targets);
b = 1;
v = 0;
while v~=length(targets)
    clear angles
    clear trim
    y=1;
    for i=1:length(targets)
        if targets(i,2) == 0
            trim(y,1) = targets(i,1);
            y = y+1;
        end
    end
    x = length(trim);
    angles = [trim(:,1),zeros(length(trim),1)];
    for i=2:length(trim)
        theta = angleCalc(ref,full(trim(1,1),2:4),full(trim(i,1),2:4));
        angles(i,2) = theta;
    end
    angles = sortrows(angles,2);
    n=0;
    for a=1:length(angles)
        if angles(a,2)<=maxAngle
            n = n+1;
        end
    end
    if n<=2
        %fill later
    end
    leaves = angles(1:n,1);
    for j=1:length(targets)
        for k=1:length(leaves)
            if targets(j,1) == leaves(k)
                targets(j,2) = 1;
            end
        end
    end
    %lag = angles(n+1,1);
    t = idivide(int32(length(leaves)),int32(2));
    mid = midpoint(ref,full(leaves(t),2:4),full(leaves(t+1),2:4));
    pts(b,:) = [length(leaves),mid];
    finalLeaves{b} = leaves;
    v = sum(pts(:,1));
    b = b+1;
end
pts = pts(:,2:4);
end