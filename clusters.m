function clusters(trial,tol,low,high)

node = xlsread('nodes1.xlsx');
str = sprintf('trial%d.mat',trial);
zs = load(str);
zs = cell2mat(struct2cell(zs));
coords = [1.31*node(:,1),1.05*node(:,2), zeros(122,1)];
track = zeros(122,1);
coords(:,3) = zs;

cl_count = 0;
for i=1:122
    if (track(i) == 1)
        continue
    end
    distvec = zeros(122,2);
    distvec(:,1) = 1:122;
    for j=1:122
        d = tripDist(coords(i,:),coords(j,:));
        distvec(j,2) = d;
    end
    distvec = sortrows(distvec,2);
    node_count = 0;
    temp_ind = 0;
    for x=1:122
        if and(and(distvec(x,2) <= tol, distvec(x,2) ~= 0), track(distvec(x,1)) ~= 1)
            node_count = node_count+1;
            temp_ind(node_count) = distvec(x,1);
        end
        if node_count == high
            break
        end
    end
    if node_count >= low
        for a=1:length(temp_ind)
            track(temp_ind(a)) = 1;
        end
        cl_count = cl_count+1;
    end
    
end

cl_count
end