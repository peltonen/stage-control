function [ x,y,lz1] = bidirectionalStroke(theta, brushsize_in_mms, brush_speed_mmsec, xPos, yPos, stroke_speed_mmsec, stroke_in_mms, pause_in_seconds, Fs)
%unidirectionalStroke returns voltage commands to the f-theta scan system to
%generate a bidirectional stroke.
%stroke is centered at xPos, yPos   


    %generate brush stroke, then displace brush along the stroke path at
    %constant speed stroke_in_mms
    [xB,yB,lzB,sB] = angledBrush(theta + pi/2.0, brushsize_in_mms, brush_speed_mmsec, 0, 0, Fs);
    numSamples = Fs * stroke_in_mms / (stroke_speed_mmsec * 1.0); 
    rho = linspace(-(stroke_in_mms/2.0),(stroke_in_mms/2.0), numSamples);
    [xD, yD] = pol2cart(theta, rho); %numSamplewise displacement along the stroke path.
    lz1 = cat(2, cat(2,ones(1, size(xD,2)), zeros(1,Fs * pause_in_seconds), ones(1, size(xD,2)))); 
    xD = cat(2, cat(2,xD,ones(1,Fs * pause_in_seconds) * xD(end)), fliplr(xD)); 
    yD = cat(2, cat(2,yD,ones(1,Fs * pause_in_seconds) * yD(end)), fliplr(yD));
    xD = xD + xPos;
    yD = yD + yPos;
    x = repmat(xB, 1, ceil(size(xD,2)/(1.0 * size(xB,2))));
    x = x(1:size(xD,2));
    y = repmat(yB, 1, ceil(size(yD,2)/(1.0 * size(yB,2))));
    y = y(1:size(yD,2));
    
    for i = 1:size(x,2)
       x(i) = x(i) + xD(i); 
       y(i) = y(i) + yD(i);
    end




end

