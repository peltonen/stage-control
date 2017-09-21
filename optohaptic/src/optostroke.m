function [x1,y1,lz1, isStroking] = optostroke(brush_size_in_mms, brush_speed, seconds_between_strokes, stroke_speed, stroke_in_mms, Fs)
%optostroke Optical stroke stimulus
%   brush_size_in_mms is extent of the line that is scanned to formed by scanning a point at brush_speed the
%   fictive brush head. stroke_speed is an array that specifices the stroke
%   speeds, typically 1 mm/sec -> 200 mm/sec, with seconds_between_strokes
%   pauses.  

    voltageToDistance = 5925; % microns/ volt, 6210H CT mirrors with FTH160-1064-M39 f-theta lens.
%      

    totalSamples = (numStim + 2)*ISISamples; %Number of total samples required, including returning to zero at beg and end.
    x1 = zeros(totalSamples,1);   
    y1 = zeros(totalSamples,1);  
    lz1 = zeros(totalSamples,1);  
    isStroking = zeros(totalSamples,1);
    for n = 1:numStim
       x1(n * ISISamples : (n+1) * ISISamples) = (offsetX + unifrnd(-edgeLength/2, edgeLength/2))/voltageToDistance;
       y1(n * ISISamples : (n+1) * ISISamples) =(offsetY + unifrnd(-edgeLength/2, edgeLength/2))/voltageToDistance;
       lz1(n * ISISamples + centerSamplePad : (n+1) * ISISamples - centerSamplePad ) = 5; % set laser TTL to HIGH
       lz2(n * ISISamples + centerSamplePad : (n+1) * ISISamples - centerSamplePad ) = 5; % set laser TTL to HIGH 
    end
end

