%returns total distance between ONE node and all its connections
%node = int of node whose connections we are looking at
%Pts = matrix [node number;x;y;z]
%cxns = node num, node it connects to (Netlist numerical)

function edgy = nodeDist(node, Pts, Cxns)
    n = 1; %cxns current index
    d = 0;
    while Cxns(n,1) ~= node
        n = n+1;
    end
    while Cxns(n,1) == node
        pt1 = Cxns(n,1);
        pt2 = Cxns(n,2);
        n1 = Pts(pt1,2:4);
        n2 = Pts(pt2,2:4);
        d = d+tripDist(n1,n2);
        n = n+1;
        if n>3236
            break
        end
    end
    edgy = d;
end