function [cell, cellLeftSide, numCells] = CellCreation(cellRadius, ...
    xmax, ymax, maxCells)
% Create the dendritic cells.


% Preallocation
cellLeftSide = false(maxCells,1);

% Call InitialCellCreation to create the first cell.
[numCells, cell, cellLeftSide] = InitialCellCreation(cellRadius, xmax, ...
    ymax, cellLeftSide);
numIterations = 0;
% Create the rest of the cells, up to either the max number, or the maximum
% iterations - whichever comes first.
while (numCells < maxCells) && numIterations < 50
    % Call the function NewCell.
    [cell, numCells, cellLeftSide] = NewCell(xmax, ymax, cellRadius, ...
        numCells, cell, maxCells, cellLeftSide);
    numIterations = numIterations + 1;
end

end

