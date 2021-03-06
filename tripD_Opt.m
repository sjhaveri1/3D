%the code that produces optimized plots with helper functions

tic
close all
clear all
img = imread('hippoForm_cells-paths.jpg');

%figure
%imshow(img), hold on

%shows all connections if > 122
%none if 0
showNode = 91; %UI-thing, shows connections of node specified
trials = 10000; %number of random trials for z coords (500 is roughly 4 seconds, watch out)
height = 500;
slices = 20; %number of slices, z coordinates will be randomized in this range
%note: if using regionOpt, MUST be an even multiple of 3.
gain = height/slices; %amplification for more height to visualize points,
%make them more proportionate to the rest of the model

node = xlsread('nodes1.xlsx');
cxns = xlsread('num_netlist.csv');

%weights added to scale for the jpeg (this was as close as we could get to
%the original)
coords = [1.31*node(:,1),1.05*node(:,2), zeros(122,1)];
regions = node(:,4);
states = node(:,3);

%adds neuron type nums next to coords
nodes = zeros(122,1);
for n=1:122
    nodes(n) = n;
end

full = ([nodes,coords]); %node, x,y,z
half = ([nodes,coords(:,1:2)]); %only x-y coords, used for zOpt

numCxns = zeros(122,2);
for a = 1:122
    numCxns(a,1) = a;
    numCxns(a,2) = countCxns(a,cxns);
end

numCxnsSorted = sortrows(numCxns,2);

[zs, dOpt] = zOpt(gain,slices,half,cxns); %optimizes the z coords
%[zs, dOpt] = gradOpt(gain,slices,half,cxns);
%[zs, dOpt] = denseOpt(numCxnsSorted,gain,slices,half,cxns);
%[zs, dOpt] = hardRegionOpt(regions,gain,half,cxns);
full(:,4) = zs; %adds optimal z coords
dOpt %total distance of optimized network

toc

t = 11;  %trial number for file

str = sprintf('trial%d.xls',t);
xlswrite(str,zs)
xlswrite(str,dOpt,1,'B1')

figure
%this is the preliminary 3D model
%plot3(full(:,2),full(:,3),full(:,4), 'r.', 'MarkerSize',20), hold on
for i=1:122
    switch states(i)
        case 0
            randcolor = randi(3,1);
            switch randcolor
                case 1
                    h1 = plot3(full(i,2),full(i,3),full(i,4), 'r.', 'MarkerSize',30);
                    hold on
                case 2
                    h2 = plot3(full(i,2),full(i,3),full(i,4), 'g.', 'MarkerSize',30);
                    hold on
                case 3
                    h3 = plot3(full(i,2),full(i,3),full(i,4), 'b.', 'MarkerSize',30);
                    hold on
            end
        case 1
            h4 = plot3(full(i,2),full(i,3),full(i,4), 'k.', 'MarkerSize',30);
            hold on
    end
end
%{
for i=1:122
    switch regions(i)
        case 1
            plot3(full(i,2),full(i,3),full(i,4), 'r.', 'MarkerSize',30), hold on
        case 2
            plot3(full(i,2),full(i,3),full(i,4), 'g.', 'MarkerSize',30), hold on
        case 3
            plot3(full(i,2),full(i,3),full(i,4), 'b.', 'MarkerSize',30), hold on
        case 4
            plot3(full(i,2),full(i,3),full(i,4), 'k.', 'MarkerSize',30), hold on
        case 5
            plot3(full(i,2),full(i,3),full(i,4), 'c.', 'MarkerSize',30), hold on
        case 6
            plot3(full(i,2),full(i,3),full(i,4), 'm.', 'MarkerSize',30), hold on
    end
end
%}

scaling = 0;

imshow(img), hold on, axis on, grid on
legend([h1,h2,h3,h4],'Inhibitory (1)','Inhibitory (2)','Inhibitory (3)','Excitatory')

%str2 = sprintf('Random Control');
title('Random Control')
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
            plot3([pt1(1) pt2(1)],[pt1(2) pt2(2)],[pt1(3) pt2(3)],'LineWidth',1), hold on %plots the line
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

coords(:,3) = zs;