function fval = eqn(t,y,D,Nx,Ny,X_Left,X_Right)
% Create the system of equations to be used in MATLAB's ode45 function.

% Constants for binding and unbinding
k_b = 0.004; % Constant for binding
k_u = 0.002; % Constant for unbinding
% Step Sizes
h_x = 1/Nx;
h_y = 1/Ny;
% Values for Cu
Cu = y( 1:(Nx-1)*(Ny+1) );
Cu = reshape(Cu,[Ny+1 Nx-1]);
Cu = padarray(Cu,[0 1],0,'both');
% Boundary conditions for Cu
Cu(:,1) = X_Left; 
Cu(:,Nx+1) = X_Right; 

% Values for Cb
Cb = y((Nx-1)*(Ny+1)+1:end);
Cb = reshape(Cb, [Ny+1 Nx+1]);
% Preallocation
dCudt = zeros(Ny+1,Nx+1);
dCbdt = zeros(Ny+1,Nx+1);

% Unbound concentration equations:
% From Neumann BC's, we obtain
for i = 2:Nx
    dCudt(Ny+1,i) = (D/h_x^2) * (Cu(Ny+1,i-1) + Cu(Ny+1,i+1) - 2*Cu(Ny+1,i)) ...
                 + (D/h_y^2) * (Cu(Ny,i) + 0 + Cu(Ny,i) - 2*Cu(Ny+1,i)) ... 
                 - k_b*Cu(Nx+1,i) + k_u*Cb(Nx+1,i);
end
% and:
for i = 2:Nx
    dCudt(1,i) = (D/h_x^2) * (Cu(1,i-1) + Cu(1,i+1) - 2*Cu(1,i)) ...
               + (D/h_y^2) * (Cu(2,i) + 0 + Cu(2,i) - 2*Cu(1,i)) ... 
               - k_b*Cu(1,i) + k_u*Cb(1,i);
end
% Interior points:
for i = 2:Ny
    for j = 2:Nx
        dCudt(i,j) = (D/h_x^2) * ( Cu(i,j-1) + Cu(i,j+1) -2*Cu(i,j) ) ... 
                   + (D/h_y^2) * ( Cu(i+1,j) +  Cu(i-1,j) - 2*Cu(i,j) ) ...
                   - k_b*Cu(i,j) + k_u*Cb(i,j);
    end
end

% Bound concentration equations:
for i=1:Ny+1
    for j = 1:Nx+1
        dCbdt(i,j) = k_b*Cu(i,j) - k_u*Cb(i,j);
    end
end

% Output the interior points of the matrices, but as a stacked
% column vector (the form ode45 will want to use).
temp = dCudt(1:Ny+1,2:Nx);
temp = temp(:);
temp2 = dCbdt;
temp2 = temp2(:);
fval = [temp' temp2']';
end