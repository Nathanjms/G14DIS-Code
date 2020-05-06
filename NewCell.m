function [Cell, num_cells, cellLeftSide] = NewCell(xmax, ymax, cellRadius, ...
    num_cells, Cell, max_cells, cellLeftSide)
% Add a new cell to the plot which will not overlap with any current cells.

% Preallocate
CellDist = zeros(1,size(Cell,1));

randomNum = unifrnd(0,1);
% If larger than 0.5, go on the Left side.
if randomNum >= 0.5
    x = unifrnd(0, xmax-1.3*cellRadius);
    new_cell = [x ymax*rand(1)];
    tempCellLeftSide = true;
else
    % If not larger than 0.5, go on the Right side.
    x = unifrnd(xmax + cellRadius*1.3, 2);
    new_cell = [x ymax*rand(1)];
    tempCellLeftSide = false;
end
% Check to see if the cell will fit in the top and bottom of the domain
% as well as the total number of cells is less than max_cells.
if (new_cell(2) >= cellRadius) && ...
        (new_cell(2) <= ymax - cellRadius) && (num_cells < max_cells)
    % Create a vector of distances between the new cell and all the old
    % ones
    for i = 1:(length(Cell(:,1)))
        CellDist(i) = sqrt( (new_cell(1) - Cell(i,1))^2 + (new_cell(2) ... 
            - Cell(i,2))^2 );
    end
    % Check whether the new cell would overlap with any other cells. If
    % it does not, add it.
    if (min(CellDist) >= 2*cellRadius)
        Cells_Temp(:,1) = [Cell(:,1)' new_cell(1)];
        Cells_Temp(:,2) = [Cell(:,2)' new_cell(2)];
        num_cells = num_cells + 1;
        Cell(num_cells,:) = Cells_Temp(num_cells,:);
        cellLeftSide(num_cells) = tempCellLeftSide;
    end
end

end

