function [x,y] = CellChecks(Cell, k , cell_radius, xmax, ymin, ymax, ...
    Cell_New, cellLeftSide)
% Check if the cell movement causes it to overlap with other cells or 
% pass any boundary points. If not, move the cell to its new 
% location.

allowed_to_move = true;

% If the cell's movement cause it to go within the lymphatc vessel, 
% dont let it move further than the lymphatic vessel. (LHS)
if (Cell_New(k,1) >= xmax - cell_radius) && (cellLeftSide(k))
    allowed_to_move = false;
    Cell(k,1) = xmax - cell_radius;
end
% If the cell's movement cause it to go within the lymphatc vessel, 
% dont let it move further than the lymphatic vessel. (RHS)
if (Cell_New(k,1) <= xmax + cell_radius) && (~cellLeftSide(k))
    allowed_to_move = false;
    Cell(k,1) = xmax + cell_radius;
end

% If the cell is on the top or bottom boundary, dont let it go any 
% further.
if (Cell_New(k,2) - cell_radius < ymin)
    allowed_to_move = false;
    Cell(k,2) = ymin + cell_radius;
    % If the cell is on the boundary, dont let it go any further.
elseif (Cell_New(k,2) + cell_radius > ymax)
    allowed_to_move = false;
    Cell(k,2) = ymax - cell_radius;
end

% If there is more than one cells, calculate the distance between the
% current cell's proposed new location, and all the other cells.
if length(Cell(:,1)) > 1
    n = 0;
    CellDist = zeros(length(Cell(:,1))-1,1);
    for i = 1:(length(Cell(:,1)))
        if i ~= k
            n = n+1;
            CellDist(n) = sqrt( (Cell_New(k,1) - Cell(i,1))^2 + ...
                (Cell_New(k,2) - Cell(i,2))^2);
        end
    end
    % If the cell's movemenet does not cause it to overlap with any other
    % cell, let the cell mvoe to the new location.
    if (min(CellDist) >= 2*cell_radius) && (allowed_to_move == true)
        Cell(k,1) = Cell_New(k,1);
        Cell(k,2) = Cell_New(k,2);
    end    
    x = Cell(k,1);
    y = Cell(k,2);

% For one cell, check whether it is allowed to move (ie. it is not on
% the y-boundary), and if so move the cell to it's proposed position.
else
    if (allowed_to_move == true)
        Cell(k,1) = Cell_New(k,1);
        Cell(k,2) = Cell_New(k,2);
    end
    x = Cell(k,1);
    y = Cell(k,2);
end

