function list = targetList(cxns,node)
i=1;
while cxns(i,1) ~= node
    i = i+1;
end
k = 1;
while cxns(i,1) == node
    list(k,1) =  cxns(i,2);
    k = k+1;
    i = i+1;
end
end