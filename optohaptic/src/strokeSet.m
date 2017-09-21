function [ x,y,lz1] = strokeSet( speeds, pause_in_seconds, Fs)
%strokeSet speeds = [1.5,4.5,13.5,45,135]
    voltageToDistance = 5.925; % mm/ volt, 6210H CT mirrors with FTH160-1064-M39 f-theta lens.
    thetas = [0,pi/4,pi/2,3/4 * pi, pi, 1.25 * pi, 1.5 * pi, 1.75 * pi]; %directions
    speeds = [1.5,4.5,13.5,45,135];  %mm/sec
    brushsize_in_mms = 8;
    brush_speed_mmsec = brushsize_in_mms * 200; %empirical
    xPos = 0;
    yPos = 0;
    stroke_in_mms = 8;
    Fs= 40000;
    x = zeros(1, pause_in_seconds * Fs);
    y = zeros(1, pause_in_seconds * Fs);
    lz1 = zeros(1, pause_in_seconds * Fs);
    
    for i=1:length(thetas)
        for j=1:length(speeds)
            [xS,yS,lz1S] = bidirectionalStroke(thetas(i), brushsize_in_mms, brush_speed_mmsec, xPos, yPos, speeds(j), stroke_in_mms, pause_in_seconds, Fs);
            x = cat(2,x,xS);
            y = cat(2,y,yS);
            lz1 = cat(2,lz1,lz1S);
        end
    end
    
    x = x/voltageToDistance;
    y = y/voltageToDistance;

end

