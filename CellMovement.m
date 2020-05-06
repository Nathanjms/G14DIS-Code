function Cell_New = CellMovement(max_num, test_angle, I, Cell, ... 
    Cell_New, dist, k, cellLocalConc)
% Computes the movement of a cell given its angle. Movement depends on
% whether the concentration is large enough.


% Only react if the diffusion gradient is large enough.
if max_num > 1e-6
    theta = test_angle(I);
    % Add an element of randomness to the angle, which decreases as the
    % cell's concentration gradient increases.
    randomness = abs(1 - cellLocalConc);
    % Compute the new value of theta by using a normal distribution with
    % the mean at theta and the standard deviation gievn by the randomness
    % multiplied by a constant.
    theta = normrnd(theta,randomness*(5*pi/12));    
    % Create the new x and y coordinates for the cell.
    Cell_New(k,1) = Cell(k,1) + (dist)*cos(theta);
    Cell_New(k,2) = Cell(k,2) + (dist)*sin(theta);
else
    % If the gradient isn't large enough, make the cell move in a
    % completely random (unbiased) direction.
    theta = unifrnd(0,2*pi);
    Cell_New(k,1) = Cell(k,1) + (dist)*cos(theta);
    Cell_New(k,2) = Cell(k,2) + (dist)*sin(theta);
end
end

