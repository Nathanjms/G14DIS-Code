function ResultCellTracks(ymax, cellPosition, cellRadius)
% Plot cell tracks for the current simulation.

% Set the size of the figure and the domain
figure(3)
set(gcf,'Position',[50 50 400 300])
hold on
xlim([-100 100])
ylim([0 100*ymax])
xlabel('Distance (micrometers)')

cellPosition(:,1,:) = cellPosition(:,1,:) - 1;
cellPosition = cellPosition*100;
% Preallocation
xCombined = zeros(size(cellPosition,3), size(cellPosition,1));
yCombined = zeros(size(cellPosition,3), size(cellPosition,1));
% Rearrange into a form we can plot
for i = 1:size(cellPosition,1)
    x = cellPosition(i,1,:);
    x = x(:);
    y = cellPosition(i,2,:);
    y = y(:);
    xCombined(:,i) = x;
    yCombined(:,i) = y;
end
% Plot with thicker lines to be easier to see on small figures.
plot(xCombined,yCombined, 'LineWidth', 2, 'color', [0,0,0]);
rectangle('Position', [-cellRadius*100 0 200*cellRadius ymax*100])
camroll(90)
FileName = datestr(now, 'HH-MM');
FileName = [FileName '_CellTracks.fig'];
saveas(gcf,FileName)