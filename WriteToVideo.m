function WriteToVideo(F, dt, speed, D)
% Creates a video using each frame generated in Model.m.

A = datestr(now, 'dd.mm.yy - HH.MM');
A = [A ' - dt = ' num2str(dt) ', speed = '  num2str(speed) ', D = '...
    num2str(D) '.avi'];
video = VideoWriter(A);
video.FrameRate = 2/dt;
open(video)
writeVideo(video,F);
close(video)

end

