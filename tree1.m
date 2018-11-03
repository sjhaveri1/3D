%treeeeeeeeeee
clear all
close all
load('TREES1.15/SenDes.mat')
%load('SenDes.mat')

run TREES1.15/start_trees

node = 2;

for i=node:node
    j=1;
    while cxns(j,1) ~= i
        j = j+1;
    end
    k=1;
    while cxns(j,1) == i
        targets(k,:) = coords(cxns(j,2),:);
        k = k+1;
        j = j+1;
    end
    X = [coords(i,1);targets(:,1)];
    Y = [coords(i,2);targets(:,2)];
    Z = [coords(i,3);targets(:,3)];
    MST_tree (1, X,Y,Z, 0);
    %MST_tree (1, [coords(i,1);targets(:,1)],[coords(i,2);targets(:,2)], ...
    %    [0;zeros(length(targets),1)],0);
end

figure
imshow(img), hold on
for x=1:length(targets)
    plot3(targets(x,1),targets(x,2),targets(x,3),'r.', 'MarkerSize',20), hold on
    plot3([targets(1,1),targets(x,1)],[targets(1,2),targets(x,2)],[targets(1,3),targets(x,3)]), hold on
    %plot([targets(1,1),targets(x,1)],[targets(1,2),targets(x,2)]), hold on
end

t1 = plot_tree(1,[0 0 1]);
set(t1, 'marker','*')