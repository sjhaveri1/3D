function dTot = fullNodeDist(Pts, Cxns)
    dTot = 0;
    for i = 1:122
        dTot = dTot+(nodeDist(i,Pts,Cxns));
    end
end