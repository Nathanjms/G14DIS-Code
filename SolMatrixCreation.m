function [CuSol, CbSol] = SolMatrixCreation(ySol, Nx, Ny, ...
    tSpan, X_Left, X_Right)
% Generate Cu and Cb in time steps dt as 3-dimensional matrices.

% Generate the concentration solutions. This is done twice to account for
% both sides of the lymphatic vessel boundary.
[CuSol, CbSol] = GenerateConSols(tSpan, ySol, Nx, Ny);
[CuSolAlt, CbSolAlt] = GenerateConSols(tSpan, ySol, Nx, Ny);

% Boundary conditions
CuSol(:,1,:) = X_Left;
CuSol(:,Nx+1,:) = X_Right;
CuSolAlt(:,1,:) = X_Left;
CuSolAlt(:,Nx+1,:) = X_Right;

% Combine both sides of the boundary into one solutution matrix.
CuSol = [fliplr(CuSol), CuSolAlt];
CbSol = [fliplr(CbSol), CbSolAlt];

end

