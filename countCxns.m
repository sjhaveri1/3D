function targets = countCxns(node, cxns)
    m = 1;
    while cxns(m,1) ~= node %runs until the desired node is found in the netlist
        m = m+1;
    end
    count = 0;
    while cxns(m,1) == node
        count = count+1;
        m = m+1;
        if m > 3236
            break
        end
    end
    targets = count;
end