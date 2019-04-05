clear all
load('memes.mat')

load('zcoords.mat')
load('dank.mat')
load('cxns.mat')

ls = zeros(length(cxns),1);

for i=1:length(cxns)
    n1 = cxns(i,1);
    n2 = cxns(i,2);
    d = tripDist(asdf(n1,:),asdf(n2,:));
    ls(i) = round((d/16.666)+4,0);
    
end

nls = [cxns,ls];
xlswrite('lengths.xls',nls)
