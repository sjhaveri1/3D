function [dCost,branchPoints,steinerLeaves] = steiner(node,cxns,coords,fullRegions,maxAngle)

dCost = 0;
refNode = coords(node,:);          %coords of desired node
reg = getRegion(node,fullRegions); %region of main node
targets = getTargets(node,cxns);
targets = [targets(:,1), zeros(length(targets),1)];

shortTargets = [0,0];
extraTargets = [0,0];
for i=1:size(targets,1)
    if and(targets(i,1) ~= node,getRegion(targets(i,1),fullRegions) ~= reg)
        if sum(shortTargets) == 0
            shortTargets = targets(i,:);
        else
            shortTargets = [shortTargets;targets(i,:)];
        end
    else
        if sum(extraTargets) == 0
            extraTargets = targets(i,:);
        else
            extraTargets = [extraTargets;targets(i,:)];
        end
    end
end

if sum(shortTargets(:,1)) == 0
    %edge case, all targets in same region
    for p=1:size(extraTargets,1)
        pt1 = coords(extraTargets(p,1),:);
        plot3([refNode(1),pt1(1)],[refNode(2),pt1(2)],[refNode(3),pt1(3)],'k-.'), hold on
        dCost = dCost+tripDist(refNode,pt1);
    end
    branchPoints = 0;
    steinerLeaves = 0;
else
    if size(shortTargets,1) >= 2
        for i=1:size(shortTargets,1)
            %corresponding regions for shortTargets
            shortRegions(i,1) = getRegion(shortTargets(i,1), fullRegions);
        end
        rTemp = shortRegions(1); %temp var for previous region
        k=1; %indexing for region cell
        singleRegion = 0;
        for i=1:size(shortRegions,1)
            if and(shortRegions(i) == rTemp,i~=length(shortRegions))
                if singleRegion == 0
                    singleRegion = shortTargets(i,:);
                    rTemp = shortRegions(i);
                else
                    singleRegion = [singleRegion;shortTargets(i,:)];
                    rTemp = shortRegions(i);
                end
            else
                if i == length(shortRegions)
                    singleRegion = [singleRegion;shortTargets(i,:)];
                    regionCell{k} = singleRegion;
                else
                    regionCell{k} = singleRegion;
                    k=k+1;
                    singleRegion = shortTargets(i,:);
                    rTemp = shortRegions(i);
                end
            end
        end
        
        b=1; %new cell position
        for x=1:length(regionCell)
            c = 0; %completed steiner nodes
            currentTargets = regionCell{x};
            while c ~= size(currentTargets,1)
                shortlist = 0; %list of incomplete nodes
                for i=1:size(currentTargets,1)
                    if currentTargets(i,2) == 0
                        if shortlist == 0
                            shortlist = currentTargets(i,1);
                        else
                            shortlist = [shortlist;currentTargets(i,1)];
                        end
                    end
                end
                if length(shortlist)<2
                    leaves = shortlist;
                else
                    angles = [shortlist(:,1),zeros(length(shortlist),1)];
                    for i=2:length(shortlist)
                        theta = angleCalc(refNode,coords(shortlist(1),:),coords(shortlist(i),:));
                        angles(i,2) = theta;
                    end
                    angles = sortrows(angles,2);
                    n=0;
                    for i=1:size(angles,1)
                        if angles(i,2)<=maxAngle
                            n=n+1;
                        end
                    end
                    if n<2
                        %edge case, none to steinerize
                        
                    end
                    leaves = angles(1:n,1);
                end
                for j=1:size(currentTargets,1)
                    for k=1:length(leaves)
                        if currentTargets(j,1) == leaves(k)
                            currentTargets(j,2) = 1;
                        end
                    end
                end
                if length(leaves)>1
                    t = idivide(int32(length(leaves)),int32(2));
                    mid = midpoint(refNode,coords(leaves(t),:),coords(leaves(t+1),:));
                    %                 for i=1:length(leaves)
                    %                     leafPts(i,:) = coords(leaves(i),:);
                    %                 end
                    %                 mid = avgMidpoint(leafPts);
                    branchPoints(b,:) = [length(leaves),mid];
                    steinerLeaves{b} = leaves;
                    c=c+branchPoints(b,1);
                    b=b+1;
                else
                    if exist('branchPoints')
                        for d=1:size(branchPoints,1)
                            curMid = branchPoints(d,2:4);
                            cost(d) = tripDist(coords(leaves(1),:),curMid);
                        end
                        [mini,ind] = min(cost);
                        mid = branchPoints(ind,2:4);
                        branchPoints(b,:) = [length(leaves),mid];
                        steinerLeaves{b} = leaves;
                        c=c+branchPoints(b,1);
                        b=b+1;
                    else
                        branchPoints(b,1) = 1;
                        mdpt = [(refNode(1)+coords(leaves,1))/2,(refNode(2)+coords(leaves,2))/2,(refNode(3)+coords(leaves,3))/2];
                        branchPoints(b,2:4) = mdpt;
                        steinerLeaves{b} = leaves;
                        c=c+branchPoints(b,1);
                        b=b+1;
                    end
                end
            end
        end
        %plotting
        plot3(refNode(1),refNode(2),refNode(3),'k*'), hold on
        for p=1:size(branchPoints,1)
            bi = branchPoints(p,2:4);
            plot3([refNode(1),bi(1)],[refNode(2),bi(2)],[refNode(3),bi(3)],'k', 'LineWidth',1.5), hold on
            dCost = dCost+tripDist(refNode,bi);
            currentNodes = steinerLeaves{p};
            for q=1:length(currentNodes)
                pt2 = coords(currentNodes(q),:);
                plot3([bi(1),pt2(1)],[bi(2),pt2(2)],[bi(3),pt2(3)],'b'), hold on
                dCost = dCost+tripDist(bi,pt2);
            end
        end
        for p=1:size(extraTargets,1)
            pt1 = coords(extraTargets(p,1),:);
            plot3([refNode(1),pt1(1)],[refNode(2),pt1(2)],[refNode(3),pt1(3)],'k-.'), hold on
            dCost = dCost+tripDist(refNode,pt1);
        end
    else
        %edge case, less then 2 targets in outer region
        for p=1:size(extraTargets,1)
            pt1 = coords(extraTargets(p,1),:);
            plot3([refNode(1),pt1(1)],[refNode(2),pt1(2)],[refNode(3),pt1(3)],'k-.'), hold on
            dCost = dCost+tripDist(refNode,pt1);
        end
        branchPoints=0;
        steinerLeaves=0;
    end
end

end