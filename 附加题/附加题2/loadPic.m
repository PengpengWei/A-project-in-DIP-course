% Load pictures

%% 常规路径操作
clc;
CURRENT_PATH = cd;
RESOURCE_PATH = [CURRENT_PATH , '\resource'];
IMAGE_PATH = [RESOURCE_PATH , '\Image'];
LABEL_PATH = [RESOURCE_PATH , '\Label'];
RESULT_PATH = [CURRENT_PATH , '\result\RGB'];

%% 读取图像到I1, I2, I3，标签到L1, L2, L3
cd(IMAGE_PATH);
I1 = imread('1_3.JPG'); I2 = imread('2_3.JPG'); I3 = imread('3_3.JPG');
cd(LABEL_PATH);
L1 = imread('1_3.JPG'); L2 = imread('2_3.JPG'); L3 = imread('3_3.JPG');
cd(CURRENT_PATH);
