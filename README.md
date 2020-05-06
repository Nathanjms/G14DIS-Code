# G14DIS-Code
The code created for my dissertation titled 'Chemokine Chemokine Gradient and Dendritic Cell Migration in Lymphatic Interstitium'. 

The file 'CodeHeirarchy.png' is an image showing which functions call each other, as well as a general order of this process. 

The file 'Video_5PiOver12.avi' is an animation of the code being ran using 'DriverVideoOutput.m'.

Code Descriptions:

	DriverVideoOutput.m - This function is used to run the simulation after inputting the parameters, and then outputs the animation as a video file.
  
	DriverCellTracks.m - This function is used to run the simulation after inputting the parameters, and then outputs the cell tracks from the simulation.
  
	DriverVelTowards.m - This function runs the simulation 15 times, then computes the average veloctiy towards the lymphatics vessel as a function of distance from the vessel and outputs this result.
  
	Model.m - This function is called to run the simulation using the input parameters.
  
	CellCreation.m - This function is called to create the dendritic cells.
  
	InitCellCreation.m - This function is called to create the initial cell.
  
	NewCell.m - This function is called to create every subsequent cell after the inittial cell.
  
	ODECaller.m - This function computes, by calling MATLAB's ode45, the diffusion equation with the input initial condfitions.
  
	eqn.m - This function creates the system of equations to be called MATLAB's ode45 function.
  
	SolMatrixCreation.m - This function generates the solution 3D matrices for C_u and C_b by reshaping the output of ode45 and adding the boundary conditions.
	
	GenConSols.m - This function is called by SolMatrixCreation.m and shapes the output of ode45 into matrices.
  
	CellBoundUnbound.m - This function computes whether each cell responds to bound or unbound chemokine.
  
	CellBoundaryCheck.m - This function checks whether the cell is on the central boundary (the lymphatuc vessel), and if so, gives it a chance to escape into it.
  
	CompSurroundingDiffs.m - This function computes the cell's surrounding concentration gradients in multiple directions. It then outputs the direction and the value of the maximum concentration gradient.
  
	CellMovement.m - This function computes the movement of a cell, given its angle. Movement depends on whether the concentration is large enough.
  
	CellChecks.m - This function checks if the cell movement would cause it to overlap with any other other cells or pass any boundary points. If it does not, it moves the cell to its new location.
  
	ComputeCleaving.m - This function computes the cleaving that occurs (at the current time step) for every cell.
  
	CompNewSolEqn.m - This function recomputes the solutions Cu and Cb after cleaving, for that specific time step.
  
	SolUpdate.m - This function updates the solution matrices after a new solution has been computed by CompNewSolEqn.m.
  
	UpdateConSols.m - This function reshapes the output of ode45 to separate out the Cu and Cb matrices and is called by UpdateConSols.m.
  
	SolPlot.m - This function plots the unbound chemokine matrix, with a provided domain size.
  
	CellPlot.m - This function plot a cell at its current position.
  
	WriteToVideo.m - This function creates a video using each frame generated in Model.m.
  
	ResultCellTracks.m - This function plots the cell tracks for the current simulation.
  
	ResultVelManip.m - This function arranges 'cell velocity towards the lymphatic vessel' and its corresponding 'distance from the lymphatic vessel' into vectors.
  
	ResultVelTowards.m - This function plots the average 'cell velocity towards the lymphatic vessel' as a function against 'cell distance from the lymphatyic vessel'.
