function SolPlot(x_plot, y_plot, Sol_3D, xmin, xmax, ymin, ymax, t)
% Plot the concentration Cu.

% Plot the unbound chemokine concentration at the current time step, 
% with the assigned settings below:
pcolor(x_plot, y_plot, Sol_3D(:,:,t));
axis([xmin 2*xmax ymin ymax])
xlabel('x')
ylabel('y')
shading interp
colorbar
line([1 1], [ymin ymax])
set(gca, 'XTick', [], 'YTick',[])

end

