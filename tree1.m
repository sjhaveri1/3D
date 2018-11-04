%treeeeeeeeeee
clear all
close all
load('TREES1.15/SenDes.mat')
%load('SenDes.mat')

run TREES1.15/start_trees

node = 2;

coords1 = coords/1;
%img1 = imresize(img);
%figure
%imshow(img), hold on

tic

for i=1:122
    j=1;
    while cxns(j,1) ~= i
        j = j+1;
    end
    k=1;
    while cxns(j,1) == i
        main = coords1(cxns(j,1),:);
        targets(k,:) = coords1(cxns(j,2),:);
        k = k+1;
        j = j+1;
        if j > length(cxns)
            break
        end
    end
    X = [coords1(i,1);targets(:,1)];
    Y = [coords1(i,2);targets(:,2)];
    Z = [coords1(i,3);targets(:,3)];
    %Z = zeros(length(X),1);
    %figure
    MST_tree (1, X,Y,Z, 0, 900,[],[]);
    %bCoords = [tree{i}.X, tree{i}.Y, tree{i}.Z];
    %MST_tree (1, X,Y,Z,0);
    rows = size(targets);
    rows = rows(1);
    
    for x=1:rows
        %plot3(targets(x,1),targets(x,2),targets(x,3),'r.', 'MarkerSize',20), hold on
        %plot3([main(1,1),targets(x,1)],[main(1,2),targets(x,2)],[main(1,3),targets(x,3)]), hold on
        %plot(targets(x,1),targets(x,2),'r.', 'MarkerSize',20), hold on
        %plot([targets(1,1),targets(x,1)],[targets(1,2),targets(x,2)]), hold on
    end
    
    %figure
    %HP = plot_tree(i,[],[],[],[],'-3l');
    %hold on
    %set(HP, 'marker','*'), hold on
    i
end

toc

save('bMST.mtr','trees')