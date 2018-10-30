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