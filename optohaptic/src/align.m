function align( offsetX, offsetY, time)
%% Low power alignment of the laser to the foot %%

% Init DAQ
Fs = 20000;
s = daqSetup(Fs);
voltageToDistance = 5925.0; % microns/ volt, 6210H CT mirrors with FTH160-1064-M39 f-theta lens.

% Construct stimulus
t = 0:1/Fs:time;
lz1 = 2.5 * (square(2*pi*30*t,.11)+ 1);
lz2 = zeros(1,length(lz1));
x1 = zeros(1,length(lz1));
x1(1:end) = offsetX/voltageToDistance;
y1 = zeros(1,length(lz1));
y1(1:end) = offsetY/voltageToDistance;
lz1(end) = 0;

queueOutputData(s, [x1', y1', lz1', lz2'])

% Output stimulus
s.startForeground()
s.release()