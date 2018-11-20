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
showNode = 33; %UI-thing, shows connections of node specified

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
for i=1:1
    
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
for i=1:1
    
    ref = coords(i,:);
    targets = getTargets(i,cxns);
    if ~isempty(trunk{i})
        br  = trunk{i};
        plot3([ref(1),br(1)],[ref(2),br(2)],[ref(3),br(3)],'k', 'LineWidth',2)
        branchCount = branchCount+1;
        dCost = dCost+tripDist(ref,br);
        for j=1:length(targets)
            pt = coords(targets(j),:);
            if getRegion(targets(j),regions) == getRegion(i,regions)
                plot3([ref(1),pt(1)],[ref(2),pt(2)],[ref(3),pt(3)],'k-.')
                dCost = dCost+tripDist(ref,pt);
            else
                plot3([br(1),pt(1)],[br(2),pt(2)],[br(3),pt(3)],'b')
                dCost = dCost+tripDist(br,pt);
            end
        end
    else
        for j=1:length(targets)
            pt = coords(targets(j),:);
            plot3([ref(1),pt(1)],[ref(2),pt(2)],[ref(3),pt(3)],'k-.')
            dCost = dCost+tripDist(ref,pt);
        end
    end
end

dCost
branchCount

%{
[pts,leaves,extra] = branch(cxns,full,showNode,25,regions);

figure
imshow(img), hold on, axis on
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

s = size(pts);
plot3(coords(showNode,1),coords(showNode,2),coords(showNode,3),'b*'), hold on
for i=1:s(1)
    bi = pts(i,:);
    pt1 = coords(showNode,:);
    steinPlot(pt1,bi), hold on
    leaf = leaves{i};
    for j=1:length(leaf)
        pt2 = coords(leaf(j),:);
        if tripDist(bi,pt2)<=tripDist(pt1,pt2)
            steinPlot(bi,pt2), hold on
        else
            steinPlot(pt1,pt2), hold on
        end
    end
    for k=1:length(extra)
        pt2 = coords(extra(k),:);
        steinPlot(pt1,pt2), hold on
    end
end
%}


