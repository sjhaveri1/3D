%optimal z coord calculator

%trials = number of trials for random z's
%randomizes z coords until a set with optimized values shows up

%half = matrix with node nums, x,y
%cxns = numerical netlist
%gain = calculated 3D gain
%slices = number of 3D slices

function [z, dOpt] = zOpt(gain,slices,half,cxns) %will return the optimal distance and z coords
    full = ([half, zeros(122,1)]); %node,x,y,z (z is not set yet)
    for i=1:122 
        full(i,4) = gain*randi(slices,1); %randomly assigns a slice (z coord) in 3D
    end
    d = fullNodeDist(full,cxns);
    while fullNodeDist(full,cxns) >= 850000 %this is the benchmark TED val 
        for j=1:122 
            full(j,4) = gain*randi(slices,1); %randomly assigns a slice (z coord) in 3D
        end 
        d = fullNodeDist(full,cxns);
    end 
    dOpt = d; %only reached after while loop is done, this is the min TED
    z = full(:,4); %optimal 
end