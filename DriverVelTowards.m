% Inputs the parameters and then runs the Model multiple times, then 
% computes the average velocity towards the lymhatic vessel
close all; clear;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Parameters %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Diffusion Constant
D = 0.001;
% Boundaries for the (original) shape [Note: x will be doubled].
xmin = 0; xmax = 1; ymin = 0; ymax = 2;
% Number of steps in x and y direction respectively [Note: x will
% essentially be doubled].
Nx = 50;
Ny = 100;
% Time step
dt = 0.5;
% LHS Boundary Concentration
C_0 = 1;
% Define the span of time t.
tSpan = 0:dt:120;
% Amount of concentration to cleave at each time step.
cleaveAmount = 0.01;
% Chance for each cell to react to bound/unbound chemokine at each 
% time step.
chanceToBind = 0.005; 
chanceToUnbind = 0.005; 
% Output to a video file.
videoOutput = false;
% Cell radius.
cellRadius = 0.5*0.24;
% Maxium number of cells.
maxCells = 13;
% Cell speed per time step.
cellSpeed = 2/100;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Call the function Model multiple times to obtain the averaged velocity
% towards the lymphatc vessel.
[cellPosition, cell, fixedtimet, cellLeftSide] = Model(D, xmin, ...
    xmax, ymin, ymax, Nx, Ny, dt, C_0, tSpan, cleaveAmount, ... 
    chanceToBind, chanceToUnbind, videoOutput, cellRadius, ... 
    maxCells, cellSpeed);
% Create the initial vectors for velocity towards LV and corrresponding
% diance from LV.
[velTowardsVec, currDistVec] = ResultVelManip(cellPosition, ...
    cellLeftSide, dt);
% Repeat the simulation up to loopMax times, adding to the vectors
% velTowardsVec and currDistVec.
loopMax = 14;
for loop = 1:loopMax

[cellPosition, cell, fixedtimet, cellLeftSide] = Model(D, xmin, ...
    xmax, ymin, ymax, Nx, Ny, dt, C_0, tSpan, cleaveAmount, ... 
    chanceToBind, chanceToUnbind, videoOutput, cellRadius, ... 
    maxCells, cellSpeed);
% Generate new vectors for velocity towards LV and distance from LV.
[velTowardsVecTemp, currDistVecTemp] = ResultVelManip(cellPosition, ...
    cellLeftSide, dt);
% Add the new vectors to the old vectors for veloicty towards LV and
% distance from LV.
velTowardsVec = [velTowardsVec; velTowardsVecTemp];
currDistVec = [currDistVec; currDistVecTemp];
% Output the progress (to keep track of how long it is taking).
disp([num2str(loop+1) '/' num2str(loopMax+1)])
end

% Gather results and plot graph
ResultVelTowards(velTowardsVec, currDistVec)
