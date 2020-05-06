function [velTowardsVec, currDistVec] = ResultVelManip(cellPosition, cellLeftSide, dt)
% Arrange 'cell velocity towards the lymphatic vessel' and its corresponding
% 'distance from the lymphatic vessel' into vectors.

% Rewrite cell locations in the scaled domain size: -100 < x < 100
% and 0 < y < 200, both in micrometers.
cellPosition(:,1,:) = cellPosition(:,1,:) - 1;
cellPosition = cellPosition*100;
% Preallocations
xCombined = zeros(size(cellPosition,3), size(cellPosition,1));
yCombined = zeros(size(cellPosition,3), size(cellPosition,1));
% Rewrite the cell positions in a form easier to manipulate.
for i = 1:size(cellPosition,1)
    x = cellPosition(i,1,:);
    x = x(:);
    y = cellPosition(i,2,:);
    y = y(:);
    xCombined(:,i) = x;
    yCombined(:,i) = y;
end
% For each cell:
for j = 1:size(xCombined,2)
    % Make all of the cell's distance from the lymphatic vessel be
    % positive by taking the absolute value.
    if (cellLeftSide(j))
        xCombined(:,j) = abs(xCombined(:,j));
    end
    % For each time step (excluding the final one) compute the velocity
    % towards the lymphatic vessel (the x-componenet of the velocity).
    for i = 1:size(xCombined,1)-1
            velTowards(i,j) = (xCombined(i,j)-xCombined(i+1,j))/dt;
            currDist(i,j) = xCombined(i+1,j);
    end
end
% Rearrange into vectors.
velTowardsVec = velTowards(:);
currDistVec = currDist(:);