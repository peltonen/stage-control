function [ s, camControl ] = daqSetup( Fs )

s = daq.createSession('ni');
xMirrorChan = 0;
yMirrorChan = 1;
lz1Chan = 2;
flexChan = 3;
addAnalogOutputChannel(s,'galasMod1',xMirrorChan,'Voltage');
addAnalogOutputChannel(s,'galasMod1',yMirrorChan,'Voltage');
addAnalogOutputChannel(s,'galasMod1',lz1Chan,'Voltage');
addAnalogOutputChannel(s,'galasMod1',flexChan,'Voltage');
s.Rate = Fs;

<<<<<<< HEAD
=======
camControl = daq.createSession('ni');
addDigitalChannel(camControl,'Dev1','Port0/Line0:2','OutputOnly');

>>>>>>> refs/remotes/origin/master
end

