function [z, dOpt] = hardRegionOpt(regions,gain,half,cxns)
    full = ([half, zeros(122,1)]);
    for i=1:6
        switch i
            case 1
                for j=1:length(regions)
                    if regions(j) == i
                        full(j,4) = gain*randi([1,4],1);
                    else
                        continue
                    end
                end
            case 2
                for j=1:length(regions)
                    if regions(j) == i
                        full(j,4) = gain*randi([3,7],1);
                    else
                        continue
                    end
                end
            case 3
                for j=1:length(regions)
                    if regions(j) == i
                        full(j,4) = gain*randi([8,9],1);
                    else
                        continue
                    end
                end
            case 4
                for j=1:length(regions)
                    if regions(j) == i
                        full(j,4) = gain*randi([9,17],1);
                    else
                        continue
                    end
                end
            case 5
                for j=1:length(regions)
                    if regions(j) == i
                        full(j,4) = gain*randi([15,16],1);
                    else
                        continue
                    end
                end
            case 6
                for j=1:length(regions)
                    if regions(j) == i
                        full(j,4) = gain*randi([12,20],1);
                    else
                        continue
                    end
                end
        end
    end
    z = full(:,4);
    dOpt = fullNodeDist(full,cxns);

end