function [cellPosition, cell, t, cellLeftSide] = Model(D, ...
    xmin,xmax, ymin, ymax, Nx, Ny, dt, C_0, tSpan, cleaveAmount, ...
    chanceToBind, chanceToUnbind, videoOutput, cellRadius, ... 
    maxCells, cellSpeed)
% Run the model using the input parameters, and output the variables 
% needed to gather results.

%%%%%%%%%%%%%%%%%%%% Initial/Boundary Conditions %%%%%%%%%%%%%%%%%%%%%
% Initial conditions for both Cu and Cb (0 everywhere).
Cu_at_t0 = zeros((Nx-1)*(Ny+1),1);
Cb_at_t0 = zeros((Nx+1)*(Ny+1),1);
y0 = [Cu_at_t0' Cb_at_t0']';
% Boundary Conditions (for Cu):
X_Left = C_0; X_Right = 0; % Dirichlet
dCdyTop = 0; dCdyBot = 0; % Neumann
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%% Cell Creation %%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Distance moved each time step.
dist = cellSpeed*dt;
% Create initial cell.
[cell, cellLeftSide] = CellCreation(cellRadius, xmax, ymax, ...
    maxCells);
cellNew = cell;
% Preallocate cellPosition, to be used in tracking cell velocities.
cellPosition = NaN(maxCells,2,length(tSpan));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%% Find the Initial Concentration Solution %%%%%%%%%%%%%%%
% Call ode45 to solve the diffusion equation with the above BCs & ICs.
[tSol, ySol, tSolAlt, ySolAlt] = ODECaller(D,Nx,Ny,X_Left,X_Right,...
    tSpan, y0);

% Generate the solution matrix of the Diffusion Equation.
[Cu_3D, Cb_3D] = SolMatrixCreation(ySol, Nx, Ny, tSpan, X_Left, ...
    X_Right);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%% Preallocations %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
totalTimeSteps = length(tSpan);
escaped = false(maxCells,1);
unbound = true(maxCells,totalTimeSteps);
[x_plot, y_plot] = meshgrid(linspace(xmin,xmax+1,2*(Nx+1)), ...
    linspace(ymin,ymax,Ny+1));
piInterval = pi/8;
probeAngle = 0:piInterval:2*pi-piInterval;
cellLocalConcVec = zeros(1,maxCells);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Find the cell positions and chemokine concentration solutions for 
% all times, before plotting:
for t = 1:totalTimeSteps
    for k = 1:size(cell,1) % For each cell.
        escape = 0; 
        % If cell has entered the Lymphatic vessel, do not consider it.
        if (escaped(k))
            cell(k,:) = [nan,nan];
        else
            % Compute whether cell reacts to bound/ubound chemokine.
            unbound(k,t+1) = CellBoundUnbound(chanceToBind, ...
                chanceToUnbind, unbound, t, k);
            % If cell at the (central) boundary, compute whether it 
            % leaves
            if ( (cell(k,1) >= xmax - cellRadius) && (cell(k,1) <= ...
                    xmax + cellRadius) )
                
                [cell, escape] = CellBoundaryCheck(cell, ... 
                    cellRadius, k, xmax, escape, dt, cellLeftSide);
            else
                % Compute the concentration of chemokine surrounding the
                % cell.
                [I,max_num,cellLocalConc] = ... 
                    CompSurroundingDiffs(x_plot, y_plot , Cu_3D, ...
                    Cb_3D, cell , cellRadius ,probeAngle, ...
                    k, t,unbound(k,t));
                % Compute the potential movement of the cell.
                cellNew = CellMovement(max_num, probeAngle, I, ... 
                    cell, cellNew, dist, k, cellLocalConc);
                % Check to see whether the movement is permitted and, if
                % it is, move the cell.
                [cell(k,1), cell(k,2)] = CellChecks(cell, k , ...
                    cellRadius, xmax, ymin, ymax, cellNew, ...
                    cellLeftSide);
            end
        end
        % If the cell has escaped, mark escaped as true.
        if escape == 1
            escaped(k) = 1;
        end
        % Add to the cell position matrix.
        cellPosition(k,:,t) = cell(k,:);
        % Add to the local concentration of chemokine vector.
        cellLocalConcVec(k) = cellLocalConc;
    end
    % Compute cleaving at every cell for the current time value.
    [Cu_3D(:,:,t), Cb_3D(:,:,t)] = ComputeCleaving(x_plot, y_plot, ...
        cell, cellRadius, Cu_3D(:,:,t), Cb_3D(:,:,t), ... 
        cleaveAmount*dt, unbound(:,t), cellLocalConcVec);
    % Update the unbound and bound chemokine concentration matrixes.
    if t < totalTimeSteps
        [Cu_3D(:,:,t+1), Cb_3D(:,:,t+1)] = ... 
            CompNewSolEqn(Nx, Ny, tSpan, X_Left, X_Right, ... 
            Cu_3D(:,:,t), Cb_3D(:,:,t), ...
            t, D, dt);
    end    
end

if (videoOutput)
    % Prepare the figure.
    figure(1); hold on; set(gcf,'Position',[50 50 1000 500]);
    
    % Subplot preallocation
    iter = 1;
    subPlotTimes = round(linspace(1,totalTimeSteps,24));
    % Plot the solution and the cells at each time point
    for t = 1:totalTimeSteps
        SolPlot(x_plot, y_plot, Cu_3D, xmin, xmax, ymin, ymax, t)
        for k = 1:size(cellPosition,1)
            CellPlot(cellPosition, k, t, cellRadius, unbound)
            hold on
        end
        % Get frame for video output
        F(t) = getframe(gcf);
        
        % Subplots
        if any(subPlotTimes == t)
            figure(2)
            subplot(6,4,iter)
            SolPlot(x_plot, y_plot, Cu_3D, xmin, xmax, ymin, ymax, t)
            for k = 1:size(cellPosition,1)
                CellPlot(cellPosition, k, t, cellRadius, unbound)
                hold on
            end
            time = num2str((t-1)/2);
            title(['t = ', time, ' mins'])
            colorbar('off')
            set(gca, 'XTick', [], 'YTick',[])
            figure(1)
            iter = iter + 1;
        end
        hold off
    end
    
    % Write the frames to a video
    WriteToVideo(F, dt, cellSpeed, D);
end

end
