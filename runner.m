close all

trial = 10;
clusters(trial,100,10,15)
HCModel(113,'t',trial)
load('zcoords.mat')
load('dank.mat')
load('cxns.mat')
t = getTargets(1,cxns);

%1-18 = 1
%19-43 = 2
%44-48 = 3
%49-88 = 4
%89-91 = 5
%92-122 = 6