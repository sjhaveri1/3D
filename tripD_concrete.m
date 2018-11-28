%this is the program that takes existing z coords (from optimization) and
%generates plots (6 total as of now)
clear all
close all
tic

img = imread('hippoForm_cells-paths.jpg');
trialnum = 8; %trials in z_coords, pick one
%figure
%imshow(img), hold on

%shows all connections if > 122
%none if 0
showNode = 110; %UI-thing, shows connections of node specified

node = xlsread('nodes1.xlsx');
cxns = xlsread('num_netlist.csv');
filepath = sprintf('z_coords/trial%d.xls', trialnum);
zee = xlsread(filepath);
zs = zee(:,1);

%weights added to scale for the jpeg (this was as close as we could get to
%the original)
coords = [1.31*node(:,1),1.05*node(:,2), zeros(122,1)];
regions = node(:,4);
%adds neuron type nums next to coords
nodes = 1:122;
nodes = nodes';

full = ([nodes,coords]); %node, x,y,z
full(:,4) = zs; %adds optimal z coords
format short
fullNodeDist(full,cxns)
coords = full(:,2:4);
figure
%this is the preliminary 3D model
for i=1:122
    switch regions(i)
        case 1
            plot3(full(i,2),full(i,3),full(i,4), 'r.', 'MarkerSize',20), hold on
        case 2
            plot3(full(i,2),full(i,3),full(i,4), 'g.', 'MarkerSize',20), hold on
        case 3
            plot3(full(i,2),full(i,3),full(i,4), 'b.', 'MarkerSize',20), hold on
        case 4
            plot3(full(i,2),full(i,3),full(i,4), 'k.', 'MarkerSize',20), hold on
        case 5
            plot3(full(i,2),full(i,3),full(i,4), 'c.', 'MarkerSize',20), hold on
        case 6
            plot3(full(i,2),full(i,3),full(i,4), 'm.', 'MarkerSize',20), hold on
    end
end
imshow(img), hold on, axis on
str2 = sprintf('3D plot - Optimized, distance = %f', fullNodeDist(full,cxns));
title(str2)
%plot connections based on showNode
if showNode>0
    if showNode<123 %only plots one node's connections
        m = 1;
        while cxns(m,1) ~= showNode %runs until the desired node is found in the netlist
            m = m+1;
        end
        while cxns(m,1) == showNode %runs while the netlist value is the desired node
            pt1 = full(showNode,2:4); %desired node
            pt2 = full(cxns(m,2),2:4); %one of its connections
            plot3([pt1(1) pt2(1)],[pt1(2) pt2(2)],[pt1(3) pt2(3)], 'b', 'LineWidth',1), hold on %plots the line
            m = m+1;
            if m > 3236 %prevents out of bounds error
                break
            end
        end
    else %plots all connections
        m = 1;
        d = 0;
        for i=1:122
            %d = d + nodeDist(i,full,cxns); %eventually gives full distance of the network
            while cxns(m,1) == i
                pt1 = full(i,2:4);
                pt2 = full(cxns(m,2),2:4);
                plot3([pt1(1) pt2(1)],[pt1(2) pt2(2)],[pt1(3) pt2(3)]), hold on
                m = m+1;
                if m > 3236
                    break
                end
            end
        end
    end
end

figure
for i=1:122
    switch regions(i)
        case 1
            plot3(full(i,2),full(i,3),full(i,4), 'r.', 'MarkerSize',20), hold on
        case 2
            plot3(full(i,2),full(i,3),full(i,4), 'g.', 'MarkerSize',20), hold on
        case 3
            plot3(full(i,2),full(i,3),full(i,4), 'b.', 'MarkerSize',20), hold on
        case 4
            plot3(full(i,2),full(i,3),full(i,4), 'k.', 'MarkerSize',20), hold on
        case 5
            plot3(full(i,2),full(i,3),full(i,4), 'c.', 'MarkerSize',20), hold on
        case 6
            plot3(full(i,2),full(i,3),full(i,4), 'm.', 'MarkerSize',20), hold on
    end
end
imshow(img), hold on
%close all
%fullBranch(cxns,full,regions,25);
dOptStein = 0;
%k=1;
for i=showNode:showNode
%for i=1:122
    
    [dCost,branchPoints,steinerLeaves] = steiner(i,cxns,coords,regions,25);
    dOptStein = dOptStein+dCost;
    if branchPoints ~= 0
        if size(branchPoints,1) > 1
            trunk{i} = mean(branchPoints(:,2:4));
        else
            trunk{i} = branchPoints(:,2:4);
        end
    else
        trunk{i} = [];
        %k=k+1;
    end
    
end

figure
for i=1:122
    switch regions(i)
        case 1
            plot3(full(i,2),full(i,3),full(i,4), 'r.', 'MarkerSize',20), hold on
        case 2
            plot3(full(i,2),full(i,3),full(i,4), 'g.', 'MarkerSize',20), hold on
        case 3
            plot3(full(i,2),full(i,3),full(i,4), 'b.', 'MarkerSize',20), hold on
        case 4
            plot3(full(i,2),full(i,3),full(i,4), 'k.', 'MarkerSize',20), hold on
        case 5
            plot3(full(i,2),full(i,3),full(i,4), 'c.', 'MarkerSize',20), hold on
        case 6
            plot3(full(i,2),full(i,3),full(i,4), 'm.', 'MarkerSize',20), hold on
    end
end
imshow(img), hold on

dCost = 0;
branchCount = 0;
for i=showNode:showNode
%for i=1:122
    ref = coords(i,:);
    targets = getTargets(i,cxns);
    br  = trunk{i};
    
    m1 = [(ref(1)+br(1))/2,(ref(2)+br(2))/2,(ref(3)+br(3))/2];
    m2 = [(ref(1)+m1(1))/2,(ref(2)+m1(2))/2,(ref(3)+m1(3))/2];
    %m2 = br;
    regComp = getRegion(i,regions);
    counter = 1;
    for x=1:length(targets)
        if getRegion(targets(x),regions) ~= regComp
            counter=counter+1;
        end
    end
    
    if counter == 1
        plot3([ref(1),m2(1)],[ref(2),m2(2)],[ref(3),m2(3)],'k', 'LineWidth',2), hold on
    else
        plot3([ref(1),br(1)],[ref(2),br(2)],[ref(3),br(3)],'k', 'LineWidth',2), hold on
    end
    
    for j=1:length(targets)
        pt = coords(targets(j),:);
        if getRegion(targets(j),regions) == getRegion(i,regions)
            plot3([m2(1),pt(1)],[m2(2),pt(2)],[m2(3),pt(3)],'r')
            dCost = dCost+tripDist(m2,pt);
        else
            plot3([br(1),pt(1)],[br(2),pt(2)],[br(3),pt(3)],'b')
            dCost = dCost+tripDist(br,pt);
        end
    end
    
end

dCost

