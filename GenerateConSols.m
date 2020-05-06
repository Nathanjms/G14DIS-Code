function [CuSol, CbSol] = GenerateConSols(tSpan, ySol, Nx, Ny)
% Reshape the input ySol vector into two matrices, one for unbound
% chemokine concentration, and one for bound chemokine concentration.

% Preallocations
CuSol2DTemp = zeros(length(tSpan), (Nx-1)*(Ny+1));
CbSol2DTemp = zeros(length(tSpan), (Nx+1)*(Ny+1));

CuSol = zeros((Ny+1),(Nx+1),length(tSpan));
CbSol = zeros((Ny+1),(Nx+1),length(tSpan));

finalCuValPosition = (Ny+1)*(Nx-1);
finalCbValPosition = finalCuValPosition + (Nx+1)*(Ny+1);

% First convert into 2D matrices.
for i = 1:finalCuValPosition
    CuSol2DTemp(1:size(ySol,1),i) = ySol(:,i);
end
for i = (finalCuValPosition+1):finalCbValPosition
    CbSol2DTemp(1:size(ySol,1),i-finalCuValPosition) = ySol(:,i);
end

% Then into 3D matrices where each time step is the third dimension.
for i = 1:length(tSpan)
    
    CuSol(:,2:end-1,i) = reshape(CuSol2DTemp(i,:),[Ny+1,Nx-1]);
    CbSol(:,:,i) = reshape(CbSol2DTemp(i,:),[Ny+1,Nx+1]);
    
end


end

