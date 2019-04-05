function HCModel(showNode, display, trial)
%this is the program that takes existing z coords (from optimization) and
%generates plots (11 total as of now)
%display:
%'n': outbound edges only, all same color, nodes colord by type
%'r': outbound edges with nodes colored by region

close all
tic

img = imread('hippoForm_cells-paths.png');

node = xlsread('nodes1.xlsx');
cxns = xlsread('num_netlist.csv');
save('cxns.mat','cxns')
colors = xlsread('colors.xlsx');

str = sprintf('trial%d.mat',trial);
zs = load(str);
zs = cell2mat(struct2cell(zs));
%bracket
zs = [125
    200
    125
    100
    175
    50
    100
    200
    125
    175
    150
    125
    50
    150
    25
    150
    150
    150
    225
    225
    200
    150
    225
    150
    50
    50
    200
    125
    200
    75
    150
    175
    50
    150
    100
    50
    125
    75
    50
    75
    75
    75
    50
    225
    200
    225
    225
    200
    425
    300
    225
    300
    350
    375
    250
    250
    300
    325
    275
    250
    375
    225
    225
    225
    250
    325
    325
    225
    375
    350
    350
    225
    375
    375
    375
    425
    350
    425
    250
    275
    225
    225
    375
    275
    275
    275
    400
    325
    375
    400
    400
    475
    175
    400
    300
    150
    200
    350
    500
    325
    500
    400
    450
    250
    350
    375
    175
    450
    475
    300
    150
    375
    300
    400
    375
    325
    325
    500
    450
    400
    500
    300];
%}
zz = zs/25;

%weights added to scale for the jpeg (this was as close as we could get to
%the original)
coords = [1.31*node(:,1),1.05*node(:,2), zeros(122,1)];
regions = node(:,4);
states = node(:,3);
%adds neuron type nums next to coords
nodes = 1:122;
nodes = nodes';

for a=1:122
    dank(a,1) = a;
    dank(a,2) = countCxns(a,cxns);
end

dank = sortrows(dank,2);
save('dank.mat','dank')

full = ([nodes,coords]); %node, x,y,z
full(:,4) = zs; %adds optimal z coords
asdf = full(:,2:4);
save('memes.mat','asdf')
format short
coords = full(:,2:4);

custom_colors = struct('gg',[.5,.5,0],'bb',[0,0,.5],'gr',[.1,.1,.1]);
dOptStein = 0;
for i=1:122
    
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
    end
    
end

switch display
    case 't'
        blk = 0;
        greenn = 0;
        redd = 0;
        bluee = 0;
        figure
        for i=1:122
            switch colors(i)
                case 0
                    blk = blk+1;
                    h4 = plot3(full(i,2),full(i,3),full(i,4), 'k.', 'MarkerSize',30);
                    text(full(i,2),full(i,3),full(i,4),sprintf('%d',i))
                    hold on
                    if i==showNode
                        plot3(full(i,2),full(i,3),full(i,4), 'ro', 'MarkerSize',15), hold on
                        plot3(full(i,2),full(i,3),full(i,4), 'bo', 'MarkerSize',17), hold on
                        plot3(full(i,2),full(i,3),full(i,4), 'ko', 'MarkerSize',20), hold on
                    end
                case 1
                    redd = redd+1;
                    h1 = plot3(full(i,2),full(i,3),full(i,4), 'r.', 'MarkerSize',30);
                    text(full(i,2),full(i,3),full(i,4),sprintf('%d',i))
                    hold on
                    if i==showNode
                        plot3(full(i,2),full(i,3),full(i,4), 'ro', 'MarkerSize',15), hold on
                        plot3(full(i,2),full(i,3),full(i,4), 'bo', 'MarkerSize',17), hold on
                        plot3(full(i,2),full(i,3),full(i,4), 'ko', 'MarkerSize',20), hold on
                    end
                case 2
                    greenn = greenn+1;
                    h2 = plot3(full(i,2),full(i,3),full(i,4), 'g.', 'MarkerSize',30);
                    text(full(i,2),full(i,3),full(i,4),sprintf('%d',i))
                    hold on
                    if i==showNode
                        plot3(full(i,2),full(i,3),full(i,4), 'ro', 'MarkerSize',15), hold on
                        plot3(full(i,2),full(i,3),full(i,4), 'bo', 'MarkerSize',17), hold on
                        plot3(full(i,2),full(i,3),full(i,4), 'ko', 'MarkerSize',20), hold on
                    end
                case 3
                    bluee = bluee+1;
                    h3 = plot3(full(i,2),full(i,3),full(i,4), 'c.', 'MarkerSize',30);
                    text(full(i,2),full(i,3),full(i,4),sprintf('%d',i))
                    hold on
                    if i==showNode
                        plot3(full(i,2),full(i,3),full(i,4), 'ro', 'MarkerSize',15), hold on
                        plot3(full(i,2),full(i,3),full(i,4), 'bo', 'MarkerSize',17), hold on
                        plot3(full(i,2),full(i,3),full(i,4), 'ko', 'MarkerSize',20), hold on
                    end
            end
        end
        imshow(img), hold on, axis on, grid on
        %legend([h1,h2,h3,h4],'Inhibitory (Axo-dendritic)','Inhibitory (Axo-somatic)','Inhibitory (Interneuron-specific)','Excitatory (Glutamatergic)')
        view(0,90)
        
        dCost = 0;
        branchCount = 0;
        if showNode ~= 0
            if showNode ~= 123
                counter=1;
                for i=showNode(1:end)
                    ref = coords(i,:);
                    targets = getTargets(i,cxns);
                    br  = trunk{i};
                    m1 = [(ref(1)+br(1))/2,(ref(2)+br(2))/2,(ref(3)+br(3))/2];
                    m2 = [(ref(1)+m1(1))/2,(ref(2)+m1(2))/2,(ref(3)+m1(3))/2];
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
                            plot3([m2(1),pt(1)],[m2(2),pt(2)],[m2(3),pt(3)],'b')
                            dCost = dCost+tripDist(m2,pt);
                        else
                            plot3([br(1),pt(1)],[br(2),pt(2)],[br(3),pt(3)],'b')
                            dCost = dCost+tripDist(br,pt);
                        end
                    end
                    
                end
            else
                for i=1:122
                    ref = coords(i,:);
                    targets = getTargets(i,cxns);
                    br  = trunk{i};
                    
                    m1 = [(ref(1)+br(1))/2,(ref(2)+br(2))/2,(ref(3)+br(3))/2];
                    m2 = [(ref(1)+m1(1))/2,(ref(2)+m1(2))/2,(ref(3)+m1(3))/2];
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
                            plot3([m2(1),pt(1)],[m2(2),pt(2)],[m2(3),pt(3)],'b')
                            dCost = dCost+tripDist(m2,pt);
                        else
                            plot3([br(1),pt(1)],[br(2),pt(2)],[br(3),pt(3)],'b')
                            dCost = dCost+tripDist(br,pt);
                        end
                    end
                    
                end
            end
        end
        %}
    case 'a'
        figure
        for i=1:122
            if i == showNode
                plot3(full(i,2),full(i,3),full(i,4), 'r.', 'MarkerSize',30), hold on
            else
                plot3(full(i,2),full(i,3),full(i,4), 'k.', 'MarkerSize',30), hold on
            end
        end
        imshow(img), hold on, axis on, grid on
        view(0,90)
    case 'r'
        figure
        for i=1:122
            switch regions(i)
                case 1
                    plot3(full(i,2),full(i,3),full(i,4), 'r.', 'MarkerSize',40), hold on
                case 2
                    plot3(full(i,2),full(i,3),full(i,4), 'g.', 'MarkerSize',40), hold on
                case 3
                    plot3(full(i,2),full(i,3),full(i,4), 'b.', 'MarkerSize',40), hold on
                case 4
                    plot3(full(i,2),full(i,3),full(i,4), 'k.', 'MarkerSize',40), hold on
                case 5
                    plot3(full(i,2),full(i,3),full(i,4), 'c.', 'MarkerSize',40), hold on
                case 6
                    plot3(full(i,2),full(i,3),full(i,4), 'm.', 'MarkerSize',40), hold on
            end
        end
        imshow(img), hold on, axis on, grid on
        
        dCost = 0;
        branchCount = 0;
        if showNode ~= 123
            counter=1;
            for i=showNode(1:end)
                ref = coords(i,:);
                targets = getTargets(i,cxns);
                br  = trunk{i};
                
                m1 = [(ref(1)+br(1))/2,(ref(2)+br(2))/2,(ref(3)+br(3))/2];
                m2 = [(ref(1)+m1(1))/2,(ref(2)+m1(2))/2,(ref(3)+m1(3))/2];
                regComp = getRegion(i,regions);
                counter = 1;
                for x=1:length(targets)
                    if getRegion(targets(x),regions) ~= regComp
                        counter=counter+1;
                    end
                end
                
                if counter == 1
                    plot3([ref(1),m2(1)],[ref(2),m2(2)],[ref(3),m2(3)],'k', 'LineWidth',3), hold on
                else
                    plot3([ref(1),br(1)],[ref(2),br(2)],[ref(3),br(3)],'k', 'LineWidth',3), hold on
                end
                
                for j=1:length(targets)
                    pt = coords(targets(j),:);
                    if getRegion(targets(j),regions) == getRegion(i,regions)
                        plot3([m2(1),pt(1)],[m2(2),pt(2)],[m2(3),pt(3)],'b')
                        dCost = dCost+tripDist(m2,pt);
                    else
                        plot3([br(1),pt(1)],[br(2),pt(2)],[br(3),pt(3)],'b')
                        dCost = dCost+tripDist(br,pt);
                    end
                end
                
            end
        else
            for i=1:122
                ref = coords(i,:);
                targets = getTargets(i,cxns);
                br  = trunk{i};
                
                m1 = [(ref(1)+br(1))/2,(ref(2)+br(2))/2,(ref(3)+br(3))/2];
                m2 = [(ref(1)+m1(1))/2,(ref(2)+m1(2))/2,(ref(3)+m1(3))/2];
                regComp = getRegion(i,regions);
                counter = 1;
                for x=1:length(targets)
                    if getRegion(targets(x),regions) ~= regComp
                        counter=counter+1;
                    end
                end
                
                if counter == 1
                    plot3([ref(1),m2(1)],[ref(2),m2(2)],[ref(3),m2(3)],'k', 'LineWidth',3), hold on
                else
                    plot3([ref(1),br(1)],[ref(2),br(2)],[ref(3),br(3)],'k', 'LineWidth',3), hold on
                end
                
                for j=1:length(targets)
                    pt = coords(targets(j),:);
                    if getRegion(targets(j),regions) == getRegion(i,regions)
                        plot3([m2(1),pt(1)],[m2(2),pt(2)],[m2(3),pt(3)],'b')
                        dCost = dCost+tripDist(m2,pt);
                    else
                        plot3([br(1),pt(1)],[br(2),pt(2)],[br(3),pt(3)],'b')
                        dCost = dCost+tripDist(br,pt);
                    end
                end
                
            end
        end
    case 'n'
        figure
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
        imshow(img), hold on, axis on, grid on
        legend([h1,h2,h3,h4],'Inhibitory (1)','Inhibitory (2)','Inhibitory (3)','Excitatory')
        dCost = 0;
        branchCount = 0;
        if showNode ~= 123
            counter=1;
            for i=showNode(1:end)
                ref = coords(i,:);
                targets = getTargets(i,cxns);
                br  = trunk{i};
                m1 = [(ref(1)+br(1))/2,(ref(2)+br(2))/2,(ref(3)+br(3))/2];
                m2 = [(ref(1)+m1(1))/2,(ref(2)+m1(2))/2,(ref(3)+m1(3))/2];
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
                        plot3([m2(1),pt(1)],[m2(2),pt(2)],[m2(3),pt(3)],'b')
                        dCost = dCost+tripDist(m2,pt);
                    else
                        plot3([br(1),pt(1)],[br(2),pt(2)],[br(3),pt(3)],'b')
                        dCost = dCost+tripDist(br,pt);
                    end
                end
                
            end
        else
            for i=1:122
                ref = coords(i,:);
                targets = getTargets(i,cxns);
                br  = trunk{i};
                
                m1 = [(ref(1)+br(1))/2,(ref(2)+br(2))/2,(ref(3)+br(3))/2];
                m2 = [(ref(1)+m1(1))/2,(ref(2)+m1(2))/2,(ref(3)+m1(3))/2];
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
                        plot3([m2(1),pt(1)],[m2(2),pt(2)],[m2(3),pt(3)],'b')
                        dCost = dCost+tripDist(m2,pt);
                    else
                        plot3([br(1),pt(1)],[br(2),pt(2)],[br(3),pt(3)],'b')
                        dCost = dCost+tripDist(br,pt);
                    end
                end
                
            end
        end
    case 'i'
end
%dCost


end