% demo code for 3D human pose estimation from a monocular RGB image
% this demo code uses CPM (Convolutional Pose Machines) for 2D pose
% estimation, however, any 2D pose estimator from image can be applied.
% prediction: The 2D pose, a 14X2 matrix, 14 corresponding position as
% listed in the following order, 3 columns with [x y] coordinates.
% (head)
% (neck)
% (right shoulder)
% (right elbow)
% (right wrist)
% (left shoulder)
% (left elbow)
% (left wrist)
% (right hip)
% (right knee)
% (right ankle)
% (left hip)
% (left knee)
% (left ankle)

%% setup
% param = model_config();
function demoold(img, pred)
display(img);
display(pred);
load('/content/drive/My Drive/IC/3D_library.mat');
addpath('/content/3dpose/Tools');
%pkg install -forge io;
%pkg install -forge statistics;
pkg load io;
pkg load statistics;
%% input image path
impath = strcat("/content/drive/My Drive/IC/APE/",img);
predpath = strcat("/content/drive/My Drive/IC/output/",pred);
%display(predpath); 
outputpath = strcat("/content/drive/My Drive/IC/output3d/",img,".csv");
test_image = [impath];
im = imread(test_image);

% load the precomputed 2D pose derived by Convolutional Pose Machines,
% other 2D pose estimation methods is applicable, format the 2D pose in the
% definition described above
prediction = load(predpath);
% PREDICTION = PRED_JSON E TALS NAO ESQEUCER!@#!#!!!

Prediction{1}=prediction;

% manually adjust two hips' position due to the variation across MPII and
% H36M
prediction(9,2) = prediction(9,2) - 20;
prediction(12,2) = prediction(12,2) - 20;

%% extract the nearest neighbor 
[j_p] = NN_pose(s1_s9_2d_n,s1_s9_3d,prediction);
% [j_p] = kNN_pose_procrus(s1_s9_2d_n,s1_s9_3d,prediction, 10);

% compute the scale between pixel and real world to recover real size of
% prediction
scale = (max(j_p(:,2))-min(j_p(:,2)))/(max(prediction(:,2))-min(prediction(:,2)));

% predict the depth of each joint by the exemplar
prediction(:,3) = j_p(:,3)/scale;
%display(prediction);

% write prediction to file
csvwrite(outputpath,prediction);

clear;
end