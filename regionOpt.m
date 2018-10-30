function [z, dOpt] = regionOpt(regions,gain,slices,half,cxns)
    n = slices/6;
    full = ([half, zeros(122,1)]);
    for i=1:6
        for j=1:length(regions)
            if regions(j) == i
                full(j,4) = gain*randi([(n*i)-(n-1),n*i],1);
            else
                continue
            end
        end
    end
    z = full(:,4);
    dOpt = fullNodeDist(full,cxns);
end