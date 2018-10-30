%this is the program that takes existing z coords (from optimization) and
%generates plots (6 total as of now)

tic

img = imread('hippoForm_cells-paths.jpg');
trialnum = 3; %trials in z_coords, pick one
%figure
%imshow(img), hold on

%shows all connections if > 122
%none if 0
showNode = 34; %UI-thing, shows connections of node specified

node = xlsread('nodes1.xlsx');
cxns = xlsread('num_netlist.csv');
filepath = sprintf('z_coords/trial%d.xls', trialnum);
zee = xlsread(filepath);
zs = zee(:,1);

%weights added to scale for the jpeg (this was as close as we could get to
%the original)
coords = [1.31*node(:,1),1.05*node(:,2), zeros(122,1)];

%adds neuron type nums next to coords
nodes = zeros(122,1);
for n=1:122
    nodes(n) = n;
end

full = ([nodes,coords]); %node, x,y,z
full(:,4) = zs; %adds optimal z coords
format long
fullNodeDist(full,cxns)

figure
%this is the preliminary 3D model
plot3(full(:,2),full(:,3),full(:,4), 'r.', 'MarkerSize',20), hold on
imshow(img), hold on
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
plot3(full(:,2),full(:,3),full(:,4), 'r.', 'MarkerSize',20), hold on
plot3(full(showNode,2),full(showNode,3),full(showNode,4), 'k.', 'MarkerSize',25), hold on
imshow(img), hold on


