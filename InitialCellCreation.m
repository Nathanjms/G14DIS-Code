function [numCells, cell, cellLeftSide] = InitialCellCreation(cellRadius, ...
    xmax, ymax, cellLeftSide)
% Creates the first cell. 

% Give cell random chance to initialise on either side of the boundary.
% After choosing a side, make the cell's x-coordinate be within that
% boundary but not too close to the boundary.
    randomNum = unifrnd(0,1);
    if randomNum >= 0.5
        cellLeftSide(1) = true;
        cell_x = unifrnd(0, xmax-1.2*cellRadius);
    else
        cell_x = unifrnd(xmax + cellRadius*1.2, 2);
        cellLeftSide(1) = false;
    end
    cell_y = ymax*rand(1);

cell(1,1) = cell_x; 
cell(1,2) = cell_y;
numCells = 1;


end