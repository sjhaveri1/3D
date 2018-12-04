function [z, dOpt] = hardRegionOpt(regions,gain,half,cxns)
    full = ([half, zeros(122,1)]);
    for i=1:6
        switch i
            case 1
                for j=1:length(regions)
                    if regions(j) == i
                        full(j,4) = gain*randi([1,8],1);
                        %full(j,4) = gain*randi([1,20],1);
                    else
                        continue
                    end
                end
            case 2
                for j=1:length(regions)
                    if regions(j) == i
                        full(j,4) = gain*randi([2,9],1);
                        %full(j,4) = gain*randi([4,24],1);
                    else
                        continue
                    end
                end
            case 3
                for j=1:length(regions)
                    if regions(j) == i
                        full(j,4) = gain*randi([8,9],1);
                        %full(j,4) = gain*randi([23,26],1);
                    else
                        continue
                    end
                end
            case 4
                for j=1:length(regions)
                    if regions(j) == i
                        g = groups(j,cxns,regions);
                        if or(g(6) == 1, g(5) ==1)
                            full(j,4) = gain*randi([16,17],1);
                            %full(j,4) = gain*randi([12,23],1);
                        else
                            full(j,4) = gain*randi([9,15],1);
                            %full(j,4) = gain*randi([25,38],1);
                        end
                    else
                        continue
                    end
                end
            case 5
                for j=1:length(regions)
                    if regions(j) == i
                        full(j,4) = gain*randi([15,16],1);
                        %full(j,4) = gain*randi([39,41],1);
                    else
                        continue
                    end
                end
            case 6
                for j=1:length(regions)
                    if regions(j) == i
                        g = groups(j,cxns,regions);
                        if or(g(1) == 1, g(2) == 1)
                            full(j,4) = gain*randi([5,10],1);
                            %full(j,4) = gain*randi([12,25],1);
                        else                          
                            full(j,4) = gain*randi([12,20],1);
                            %full(j,4) = gain*randi([40,60],1);
                        end
                    else
                        continue
                    end
                end
        end
    end
    z = full(:,4);
    dOpt = fullNodeDist(full,cxns);

end