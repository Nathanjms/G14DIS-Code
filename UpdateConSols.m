function [Cu2DSol, Cb2DSol] = UpdateConSols(ySol, Nx, Ny)
% Reshape the output of ode45 to separate out the Cu and Cb matrices.

finalCuValPosition = (Ny+1)*(Nx-1);
finalCbValPosition = finalCuValPosition + (Nx+1)*(Ny+1);
% Seperate out the values for unbound and bound concentration as two
% vectors.
CuSol1D = ySol(end,1:finalCuValPosition);
CbSol1D = ySol(end,finalCuValPosition+1:finalCbValPosition);

% Reshape these vectors into matrices.
Cu2DSol = reshape(CuSol1D,[Ny+1,Nx-1]);
Cb2DSol = reshape(CbSol1D,[Ny+1,Nx+1]);
end

