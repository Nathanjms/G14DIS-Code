function [I,max_num,cellLocalConc] = CompSurroundingDiffs(x_plot,y_plot, ...
    Cu_3D,Cb_3D,Cell,cell_radius,test_angle,k, fixedtimet, unboundCheck)
% Computes the cell's surrounding concentration gradients in multiple
% directions. Outputs the direction and the value of the maximum
% concentration gradient.

% Compute surrounding differences
x_coord = Cell(k,1) + cell_radius*cos(test_angle);
y_coord = Cell(k,2) + cell_radius*sin(test_angle);

Test_Sol = zeros(length(test_angle),1);

% Find the value of the concentraiton, either bound or unbound, at the
% centre of the cell.
if (unboundCheck)
    cellLocalConc = interp2(x_plot,y_plot, ...
        Cu_3D(:,:,fixedtimet),Cell(k,1),Cell(k,2));
else
    cellLocalConc = interp2(x_plot,y_plot, ...
        Cb_3D(:,:,fixedtimet),Cell(k,1),Cell(k,2));
end

for K = 1:length(test_angle)
    % Check whether the cell is bound or unbound, then compute the
    % corresponding surrounding chemokine concentration gradient.
    if (unboundCheck)
        Test_Sol(K) = interp2(x_plot,y_plot, ...
            Cu_3D(:,:,fixedtimet),x_coord(K),y_coord(K));
        localConcGrad(K) = Test_Sol(K) - cellLocalConc;
    else
        Test_Sol(K) = interp2(x_plot,y_plot, ...
            Cb_3D(:,:,fixedtimet),x_coord(K),y_coord(K));
        localConcGrad(K) = Test_Sol(K) - cellLocalConc;
    end
end
% Locate the index of the largest concentration gradient.
localConcGrad = round(localConcGrad,8);
max_num = max(localConcGrad);
I =  find(localConcGrad==max_num);
% If the max number is in more than one direction, round that direction
% up or down with equal probability.
if size(I',1) > 1
    testval = rand(1);
    if testval < 0.5
        I = I(ceil(end/2));
    else
        I = I(floor(end/2));
    end
end


end

