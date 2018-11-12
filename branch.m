

function [pts,finalLeaves] = branch(cxns,full,node,maxAngle)
targets = targetList(cxns,node);
targets = [targets(:,1), zeros(length(targets),1)];

ref = full(node,2:4);
%for x=1:length(targets)
x = length(targets);
b = 1;
v = 0;
while v~=length(targets)
    clear angles
    clear short
    y=1;
    for i=1:length(targets)
        if targets(i,2) == 0
            short(y,1) = targets(i,1);
            y = y+1;
        end
    end
    x = length(short);
    angles = [short(:,1),zeros(length(short),1)];
    for i=2:length(short)
        theta = angleCalc(ref,full(short(1,1),2:4),full(short(i,1),2:4));
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

end