function targets = getTargets(node, cxns)
    m = 1;
    while cxns(m,1) ~= node %runs until the desired node is found in the netlist
        m = m+1;
    end
    i=1;
    while cxns(m,1) == node
        targets(i,1) = cxns(m,2);
        i=i+1;
        m = m+1;
        if m > 3236
            break
        end
    end
end