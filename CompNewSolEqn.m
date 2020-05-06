function [Cu_2DNew, Cb_2DNew] = CompNewSolEqn(Nx,Ny,tSpan,X_Left,X_Right, ... 
                               Cu_2D, Cb_2D, fixedtimet, D, dt)
% Recompute the solutions Cu and Cb after cleaving, for that specific 
% time step.

% Time step starts at the current time and ends at the next time step.
tInit = tSpan(fixedtimet);
tFinal = tInit + dt;   

% Split into LHS and RHS Components for both bound and unbound, then
% rearrange into the desired shape.
Cu_2D_LHS = Cu_2D(:,1:size(Cu_2D,2)/2);
Cu_2D_LHS = fliplr(Cu_2D_LHS);
Cb_2D_LHS = Cb_2D(:,1:size(Cb_2D,2)/2);
Cb_2D_LHS = fliplr(Cb_2D_LHS);
Cu_2D_RHS = Cu_2D(:,(size(Cu_2D,2)/2)+1:end);
Cb_2D_RHS = Cb_2D(:,(size(Cb_2D,2)/2)+1:end);

                               
% LHS First - run the ode solver to compute the next concentration matrix
% for both bound and unbound concentrations.

%Put into the form required by ode45 (vector).
CuAtTinit = Cu_2D_LHS(:,2:end-1);
CuInit = CuAtTinit(:);
CbAtTinit = Cb_2D_LHS;
CbInit = CbAtTinit(:);
% Initital condition is the value at the initial, or current, time step.
y0 = [CuInit' CbInit']';
tCurrSpan = [tInit tFinal];
[tSol,ySol] = ode45(@(t,y) eqn(t,y,D,Nx,Ny,X_Left,X_Right), tCurrSpan, y0);

% RHS - run the ode solver to compute the next concentration matrix
% for both bound and unbound concentrations.:

CuAtTinit = Cu_2D_RHS(:,2:end-1);
CuInit = CuAtTinit(:);
CbAtTinit = Cb_2D_RHS;
CbInit = CbAtTinit(:);
y0 = [CuInit' CbInit']';
[tSolAlt,ySolAlt] = ode45(@(t,y) eqn(t,y,D,Nx,Ny,X_Left,X_Right), tCurrSpan, y0);

% Combine the equations by calling SolUpdate:
[Cu_2DNew, Cb_2DNew] = SolUpdate(ySol, Nx, Ny, X_Left, X_Right, ySolAlt);
end