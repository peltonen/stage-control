function [x1,y1,stimStartTime] = randSquareWithOffsetStimParameters(edgeLength, offsetX, offsetY, numStim, dwellTime, ISI, Fs)
%randSquare Random dot stimulation on a square of size edgeLength x edgeLength. 
%   edgeLength is specified in microns.
%   dwellTime is specified in seconds, recommended dwelltime is .0001 seconds
%   ISI is the time between successive mirror locations, specified in
%   seconds, recommended is .001 seconds.


    ISISamples = round( ISI * Fs);
    dwellSamples = round(dwellTime * Fs);
    centerSamplePad = round((ISISamples - dwellSamples)/2);
    totalSamples = (numStim + 2)*ISISamples; %Number of total samples required, including returning to zero at beg and end.
    x1 = zeros(numStim,1);   
    y1 = zeros(numStim,1);  
    stimStartTime = zeros(numStim,1); 
    rng(.08041961) % seed random number generator for reproducibility
    for n = 1:numStim
       x1(n) = (offsetX + unifrnd(-edgeLength/2, edgeLength/2));
       y1(n) = (offsetY + unifrnd(-edgeLength/2, edgeLength/2));
       stimStartTime(n) = n * ISI + centerSamplePad/(1.0 * Fs); 
    end
    
    
