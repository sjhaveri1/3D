The first 3 trials used the random alogorithm (iterate random z vals 10000 times and pick the one with lowest distance)
	-takes too much time, but more uniform

The last 3 use the optimization algorithm (z vals are moved one at a time slightly until the optimal distance value is reached)
	-quicker, but nodes tend to squish together, not uniform. It naturally converges to all the z coords being equal. My constarint was based
	on the values from the random alg (values below 800000 were rare, so that was my benchmark for an optimal network)
	-the loop ran only until the distance was below 800000, and values that started at the minimum or maximum did not move.
	-the final vals selected gave the best shapes, though still not as uniform.
	-another note - trial 6 had one node stuck at the minimum, but it seemed unnecessary so I manually moved it up.

figures of all 6 trials can be found in the folder 'figures', and excel files of coordinates in 'z_coords'

If you are creating another algorithm, do it in a new .m file. You can copy the initial steps from the other files and it should work fine.

CODE SUMMARY

MAIN (run these files!)
tripD.m: original main file to generate a 3D model, obsolete.
tripD_Opt.m: optimizing generator, calls one of the optimization functions to get new z vals
tripD_concrete.m: uses an existing set of z coords and generates a model

HELPER (functions)
zOpt.m: randomly generates z vals until TED is optimal (method 1)
gradOpt.m: slowly moves nodes up and down until a good TED is reached (method 2)
denseOpt.m: places nodes according to number of connections (method 3), not very good, so probably obsolete
regionOpt.m: randomly arranges nodes, but in z ranges according to region (e.g. DG is z slices 1-3 if there are 18 slices)
nodeDist.m: dist between two nodes
fullNodeDist.m: TED calculator
tripDist.m: calculates 3 dimensional distance between points, used by nodeDist and fullNodeDist
countCxns.m: counts connections of one node, used by denseOpt.m

ALL OTHER .m FILES:
pretty much obsolete, they were used for minimum spanning tree tests.
I've kept them just in case but we probably won't be using them again

FILE SUMMARY

nodes1.xlsx: main excel sheet used, contains x-y coords, regions and excitatory/inhibitory
num_netlist.csv: numerical rep. of Netlist
hippoForm_cells-paths.jpg: image used to plot 3D nodes over, used for visual reference

SUBDIRECTORIES

figures: plots of the 3D nodes
coords: good trials are manually placed in here. 

Note about coords: in the parent directory there is an excel file trialx.xlsx. In tripD_Opt.m, there is a variable t, which denotes the trial number.
An excel file is created with this number replacing x, and if it is good, it is placed into coords. t should then be incremented for future trials.

