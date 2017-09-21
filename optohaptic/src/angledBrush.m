function [ x, y, lz1, isStroking ] = angledBrush(theta, brushsize_in_mms, brush_speed_mmsec, xPos, yPos, Fs)
%angledBrush  Returns vectors [x1...xn, y1...yn, lz1....lzn, TRUE ....
%TRUE] corresponding to a single optical brush at angle theta and position xPos, yPos
%for a single serpentine scan.

   numSamples = Fs * brushsize_in_mms / (brush_speed_mmsec * 1.0); 
   rho = linspace(-(brushsize_in_mms/2.0),(brushsize_in_mms/2.0), numSamples);
   [xS,yS] = pol2cart(theta,rho);
   x = cat(2, xS, fliplr(xS));
   y = cat(2, yS, fliplr(yS));
   lz1 = ones(1, numSamples) * 5;
   isStroking = ones(1, numSamples) * 5;
   
end

