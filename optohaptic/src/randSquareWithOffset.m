function [x1,y1,lz1,lz2] = randSquareWithOffset(edgeLength, offsetX, offsetY, numStim, dwellTime, ISI, Fs)
%randSquare Random dot stimulation on a square of size edgeLength x edgeLength. 
%   edgeLength is specified in microns.
%   dwellTime is specified in seconds, recommended dwelltime is .0001 seconds
%   ISI is the time between successive mirror locations, specified in
%   seconds, recommended is .001 seconds.

    voltageToDistance = 5925; % microns/ volt, 6210H CT mirrors with FTH160-1064-M39 f-theta lens.

    ISISamples = round( ISI * Fs);
    dwellSamples = round(dwellTime * Fs);
    centerSamplePad = round((ISISamples - dwellSamples)/2);
    totalSamples = (numStim + 2)*ISISamples; %Number of total samples required, including returning to zero at beg and end.
    x1 = zeros(totalSamples,1);   
    y1 = zeros(totalSamples,1);  
    lz1 = zeros(totalSamples,1);  
    lz2 = zeros(totalSamples,1);  

    for n = 1:numStim
       x1(n * ISISamples : (n+1) * ISISamples) = (offsetX + unifrnd(-edgeLength/2, edgeLength/2))/voltageToDistance;
       y1(n * ISISamples : (n+1) * ISISamples) =(offsetY + unifrnd(-edgeLength/2, edgeLength/2))/voltageToDistance;
       lz1(n * ISISamples + centerSamplePad : (n+1) * ISISamples - centerSamplePad ) = 5; % set laser TTL to HIGH
       lz2(n * ISISamples + centerSamplePad : (n+1) * ISISamples - centerSamplePad ) = 5; % set laser TTL to HIGH 
    end

