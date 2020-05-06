function [cell, delete] = CellBoundaryCheck(cell, cellRadius, k, ...
    xmax, delete, dt, cellLeftSide)
% Check whether the cell is on the central boundary, and if so, give it a
% chance to escape into it.

random = unifrnd(0,1);
% If the cell has approached the boundary from the LHS.
if ( (cell(k,1) >= xmax - cellRadius) && (cellLeftSide(k)) )
    if random > 0.05
        % Set the location of the cell to be on the boundary, but not
        % beyond it.
        cell(k,1) = xmax - cellRadius;
    else
        % Mark cell for deletion - ie. cell passes through boundary.
        delete = 1;
    end
% If the cell has approached the boundary from the RHS.
elseif ( (cell(k,1) <= xmax + cellRadius) && (~cellLeftSide(k)) )
    if random > 0.05
        % Set the location of the cell to be on the boundary, but not
        % beyond it.
        cell(k,1) = xmax + cellRadius;
    else
        % Mark cell for deletion - ie. cell passes through boundary.
        delete = 1; 
    end
end

