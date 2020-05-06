function [CuSol2D, CbSol2D] = SolUpdate(ySol, Nx, Ny, X_Left, X_Right, ...
    ySolAlt)
% Generate Cu and Cb for a set time step.

% Rearrange the concentration solutions into the correct by calling 
% the function UpdateConSols.
[CuSol2D, CbSol2D] = UpdateConSols(ySol, Nx, Ny);
[CuSolAlt, CbSolAlt] = UpdateConSols(ySolAlt, Nx, Ny);

% Apply the boundary conditions:
% RHS
CuSol2D = padarray(CuSol2D,[0 1],0,'both');
CuSol2D(:,1) = X_Left;
CuSol2D(:,Nx+1) = X_Right;
% LHS
CuSolAlt = padarray(CuSolAlt,[0 1],0,'both');
CuSolAlt(:,1) = X_Left;
CuSolAlt(:,Nx+1) = X_Right;
% Rearrange and combine into the desired matrix order and shape.
CuSol2D = [fliplr(CuSol2D), CuSolAlt];
CbSol2D = [fliplr(CbSol2D), CbSolAlt];
end

