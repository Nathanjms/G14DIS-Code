function [tSol, ySol, tSolAlt, ySolAlt] = ODECaller(D, Nx, Ny, ... 
    X_Left, X_Right, tSpan, y0)
% This function solves the diffusion equation for both sides of the
% lymphatic vessel boundary.

% Preallocations
tSol = nan(length(tSpan),1);
ySol = nan(length(tSpan),length(y0));
tSolAlt = nan(length(tSpan),1);
ySolAlt = nan(length(tSpan),length(y0));

% Call ode45 to solve the diffusion equation with the input BCs & ICs.
[tSolTemp,ySolTemp] = ode45(@(t,y) eqn(t,y,D,Nx,Ny,X_Left,X_Right), tSpan, y0);

% Output the computed values in column vector form. 
ySol(1:size(ySolTemp,1),:) = ySolTemp;
tSol(1:size(tSolTemp,1),:) = tSolTemp;

end