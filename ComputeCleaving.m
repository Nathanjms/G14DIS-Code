function [CuAtT, CbAtT] = ComputeCleaving(x_plot, y_plot, Cell, ...
    cellRadius, CuAtT, CbAtT, CleaveAmount, unboundCheck)
% Compute the cleaving that occurs (at the current time step) for every
% cell.

    for n = 1:size(Cell,1)
        % Check whether the cell is responding to bound or unbound
        % chemokine conecntration, and cleave the correct one.
        if (unboundCheck(n))           
            % Compute the solution surrounding/under the current cell.
            distance_r = sqrt((x_plot-Cell(n,1)).^2 + (y_plot-Cell(n,2)).^2);
            mask = distance_r < cellRadius + 0.05*cellRadius;            
            % Subtract the cleaveAmount from Cu, the unbound concentration.            
            CuAtT = CuAtT - mask*CleaveAmount;
            CuAtT(CuAtT<0) = 0;
        else
            % Compute the solution surrounding/under the current cell.
            distance_r = sqrt((x_plot-Cell(n,1)).^2 + (y_plot-Cell(n,2)).^2);
            mask = distance_r < cellRadius + 0.05*cellRadius;            
            % Subtract the cleaveAmount from Cb, the unbound concentration.            
            CbAtT = CbAtT - mask*CleaveAmount;
            CbAtT(CbAtT<0) = 0;            
        end        
    end
end