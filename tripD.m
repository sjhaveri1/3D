%this is the original code for showing the connections, all randomized

img = imread('hippoForm_cells-paths.jpg');

%figure
%imshow(img), hold on

%shows all connections if > 122
%none if 0
showNode = 91; %UI-thing

height = 500;
slices = 20; %number of slices, z coordinates will be randomized in this range
gain = height/slices; %amplification for more height to visualize points, 
                      %make them more proportionate to the rest of the model

node = xlsread('nodes1.csv');
cxns = xlsread('num_netlist.csv');

%weights added to scale for the jpeg (this was as close as we could get to
%the original)
coords = [1.31*node(:,2),1.05*node(:,3), zeros(122,1)];

for j=1:122
    coords(j,3) = gain*randi(slices,1); %randomly assigns a slice (z coord) in 3D
end
%adds neuron type nums next to coords
nodes = zeros(122,1);
for n=1:122
    nodes(n) = n;
end

full = ([nodes,coords]);
half = ([nodes,coords(:,1:2)]); %only x-y coords, used for zOpt

figure
%this is the preliminary 3D model
plot3(coords(:,1),coords(:,2),coords(:,3), 'r.', 'MarkerSize',20), hold on
imshow(img), hold on
str = sprintf('Non-optimized random plot, d = %f',fullNodeDist(full,cxns));
title(str);
%plot connections based on showNode
if showNode >0
    if showNode <123 %only plots one node connections
        m = 1;
        while cxns(m,1) ~= showNode
            m = m+1;
        end
        while cxns(m,1) == showNode
            pt1 = full(showNode,2:4);
            pt2 = full(cxns(m,2),2:4);
            plot3([pt1(1) pt2(1)],[pt1(2) pt2(2)],[pt1(3) pt2(3)], 'LineWidth',1), hold on
            m = m+1;
            if m > 3236
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


