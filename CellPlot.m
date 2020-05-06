function CellPlot(cellPosition, k ,t, cellRadius, unbound)
% Plot the cell at its current position

% If the cell is still within the domain (hasnt `passed' into the lymphatic
% vessel), plot it.
if ~isnan(cellPosition(k,1,t))
    r = rectangle('Position', [cellPosition(k,1,t)-cellRadius ...
        cellPosition(k,2,t)-cellRadius 2*cellRadius 2*cellRadius]);
    r.FaceColor = [1 1 1];
    r.Curvature = [1 1];
    % If the cell is responding to bound chemokine, mark it blue.
    if (~unbound(k,t))
        r.FaceColor = [0 1 1];
    end
end
end

