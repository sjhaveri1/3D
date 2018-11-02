function g = groups(node,cxns,regions)
    a=0;
    b=0;
    c=0;
    d=0;
    e=0;
    f=0;
    
    i=1;
    while cxns(i) ~= node
        i=i+1;
    end
    while cxns(i) == node
        r = getRegion(cxns(i,2),regions);
        switch r
            case 1
                if a==0
                    a=1;
                end
            case 2
                if b==0
                    b=1;
                end
            case 3
                if c==0
                    c=1;
                end
            case 4
                if d==0
                    d=1;
                end
            case 5
                if e==0
                    e=1;
                end
            case 6
                if f==0
                    f=1;
                end
        end 
        i=i+1;
    end
    g = [a,b,c,d,e,f];
end