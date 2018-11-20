%Generates a full Steiner plot with the cost

function fullBranch(cxns,full,regions,maxAngle)
%iterates through all nodes
for node=1:1
    node
    %clear pts
    %clear finalLeaves
    clearvars -except node cxns full regions maxAngle
    r = getRegion(node,regions); %current region
    targets1 = targetList(cxns,node);
    targets1 = [targets1(:,1), zeros(length(targets1),1)]; %full list with second column for indication
    
    %creates vector of points to Steinerize, and points that are untouched
    %for normal connections
    j=1;
    k=1;
    %clear targets
    for i=1:length(targets1)
        
        %removes self connections and same region nodes
        if and(targets1(i,1) ~= node,getRegion(targets1(i,1),regions) ~= r)
            targets(j,:) = targets1(i,:);
            j=j+1;
        else
            extra(k,1) = targets1(i,1); %for normal cxns
            k = k+1;
        end
    end
    
    %statement in case no outside connections
    if length(extra)~=length(targets1)
        if length(targets) >=3
            %if length(targets) >=3
            %separates nodes by region for better connections
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
            
            ref = full(node,2:4); %coords of current node
            
            b = 1; %cell position
            %v = 0; %will track how many nodes have been Steinerized
            for x=1:length(tempcell)
                v=0;
                targets = tempcell{x};
                vs = size(targets,1);
                while v~=vs
                    clear angles
                    clear trim
                    y=1;
                    for i=1:size(targets,1)
                        if targets(i,2) == 0
                            trim(y,1) = targets(i,1);
                            y = y+1;
                        end
                    end
                    %x = length(trim);
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
                    v = v+pts(b,1);
                    b = b+1;
                end
                %pts = pts(:,2:4);
            end
            pts = pts(:,2:4);
            ptsSize = size(pts);
            ptsSize = ptsSize(1);
            pt1 = ref;
            plot3(ref(1),ref(2),ref(3),'k*'), hold on
            for i=1:ptsSize
                bi = pts(i,:);
                steinPlot(ref,bi), hold on
                leaf = finalLeaves{i};
                for j=1:length(leaf)
                    pt2 = full(leaf(j),2:4);
                    if tripDist(bi,pt2)<=tripDist(pt1,pt2)
                        steinPlot(bi,pt2), hold on
                    else
                        steinPlot(pt1,pt2), hold on
                    end
                end
                for k=1:length(extra)
                    pt2 = full(extra(k),2:4);
                    steinPlot(pt1,pt2), hold on
                end
            end
        end
    end
end
end