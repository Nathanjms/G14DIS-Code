% Inputs the parameters and then runs the Model, then outputs the video and
% selected frames of the video output.
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
videoOutput = true;
% Cell radius.
cellRadius = 0.5*0.24;
% Maxium number of cells.
maxCells = 13;
% Cell speed per time step.
cellSpeed = 2/100;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Call the function Model to run the model and output the required
% variables it create any results.
[cellPosition, cell, fixedtimet, cellLeftSide] = Model(D, xmin, ...
    xmax, ymin, ymax, Nx, Ny, dt, C_0, tSpan, cleaveAmount, ... 
    chanceToBind, chanceToUnbind, videoOutput, cellRadius, ... 
    maxCells, cellSpeed);
