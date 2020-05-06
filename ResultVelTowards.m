function ResultVelTowards(velTowardsVec, currDistVec)
% Plots the average cell velocity towards the lymphatic vessel as a
% function against cell distance from the lymphatyic vessel.

% Order both the distance vector and the corresponding velocity vector
% from smallest to largest.
[~,order] = sort(currDistVec,'MissingPlacement','last');
velTowardsVec = velTowardsVec(order);
currDistVec = currDistVec(order);
% Shorten the vector by deleting any values that are recorded as NaN. 
velTowardsVec = velTowardsVec(~isnan(velTowardsVec));
currDistVec = currDistVec(~isnan(currDistVec));
% Round to the nearest 10.
currDistVecRound = round(currDistVec/10)*10;
figure(4)
set(gcf,'Position',[50 50 600 450])
% Find the maximum distance any cell was from the wall.
maxDist = max(currDistVecRound);
% Fore every 10 units up to the maximum distance from the wall, compute 
% the average velocity at this point alongside that distance. 
for i = 1:maxDist/10
    velTowardsAvg(i) = mean(velTowardsVec(currDistVecRound==i*10));
    currDistAvg(i) = i*10;
end
% Plot the two vectors
plot(currDistAvg,velTowardsAvg, 'LineWidth', 2, 'color', [0,0,0])
ylabel('Velocity towards LV (micrometers/minute)')
xlabel('Distance (micrometers)')
xlim([0 110])
% Save the figure automatically.
FileName = datestr(now, 'HH-MM');
FileName = [FileName '_VelTowards15Avg.fig'];
saveas(gcf,FileName)

end
