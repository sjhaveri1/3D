%cxnsSorted = sorted matrix of nodes and number of connections
%half = x,y only
%cxns = netlist numerical

function [zs, dOpt] = denseOpt(cxnsSorted,gain,slices,half,cxns)
    h = gain*slices;
    full = ([half, zeros(122,1)]);
    node = 1;
    for i=1:slices/2 %always use even slices
        if i == slices/2
            for j=1:14
                k=1;
                while full(k,1) ~= cxnsSorted(node,1)
                    k = k+1;
                end
                if mod(j,2) == 1
                    full(k,4) = h-(gain*(i-1));
                else
                    full(k,4) = i*gain;
                end
                node = node+1;
            end
        else
            for j=1:12
                k=1;
                while full(k,1) ~= cxnsSorted(node,1)
                    k = k+1;
                end
                if mod(j,2) == 1
                    full(k,4) = h-(gain*(i-1));
                else
                    full(k,4) = i*gain;
                end
                node = node+1;
            end
        end
    end
    zs = full(:,4);
    dOpt = fullNodeDist(full,cxns);
end