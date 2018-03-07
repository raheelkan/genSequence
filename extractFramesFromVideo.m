
clc; clear; close all;

addpath(genpath('/home/ga47qiv/codes/EKF_monoSLAM_1pRANSAC/myUtils/npy-matlab-master'))
% obj = VideoReader('/home/ga47qiv/codes/recordings/2018_01_17/005/world.mp4');
% Folder = '../pupil_calibration/stLabVOR_new2/';

timeStamps = readNPY('/home/ga47qiv/codes/OrbSLAM_codes/recordings_640x480_DS2_ORB_PTAM/000/world_timestamps.npy');
fileID = fopen('/home/ga47qiv/codes/OrbSLAM_codes/recordings_640x480_DS2_ORB_PTAM/000/sceneImages/rgb.txt','w');
fprintf(fileID,'# color images \n');
fprintf(fileID,'# file: new_recordings_640x480_DS1_ORB_PTAM \n');
fprintf(fileID,'# timestamp filename \n');

obj = VideoReader('/home/ga47qiv/codes/OrbSLAM_codes/recordings_640x480_DS2_ORB_PTAM/000/world.mp4');
Folder = '/home/ga47qiv/codes/OrbSLAM_codes/recordings_640x480_DS2_ORB_PTAM/000/sceneImages/rgb/';
numframes = floor(obj.FrameRate * obj.Duration);
get_every_x_frame = 1;
i = 1;
for iFrame = 1:numframes
  frames = readFrame(obj, 'Native');
  if ~rem(iFrame, get_every_x_frame)
%     frames = imresize(frames,[240 320], 'bicubic');
    imwrite(frames, fullfile(Folder, sprintf('%08f.png', timeStamps(i))));
    fprintf(fileID, '%08f rgb/%08f.png\n', timeStamps(i), timeStamps(i));
    i = i+1;
  end
end 
fclose(fileID);