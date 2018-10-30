%optimal z coord calculator

%trials = number of trials for random z's
%half = matrix with node nums, x,y
%cxns = numerical netlist
%gain = calculated 3D gain
%slices = number of 3D slices

function [z, dOpt] = gradOpt(gain,slices,half,cxns) %will return the optimal distance and z coords
    full = ([half, zeros(122,1)]); %node,x,y,z (z is not set yet)
    for j=1:122 
        full(j,4) = gain*randi(slices,1); %randomly assigns a slice (z coord) in 3D
    end
    d = 0;
    while fullNodeDist(full,cxns) >= 800000 %iterates "trials" number of times, generating new distances and z coords for each one 
        d = fullNodeDist(full,cxns);
        z = full(:,4);
        for n = 1:122
            if full(n,4)+gain <= gain*slices %&& and(full(n,4) ~= gain, full(n,4) ~= gain*slices)
                full(n,4) = full(n,4)+gain;
                z = full(:,4);
            else
                full(n,4) = gain;
                z = full(:,4);
            end
            if (fullNodeDist(full,cxns) < d)
                d = fullNodeDist(full,cxns);
            else
                full(n,4) = full(n,4) - gain;
                z = full(:,4);
            end
        end
        d
    end
    dOpt = d;
end