% Project2 Section B Freq
% 基于频域方法去噪的图像增强
% 
%
%% 常规路径操作
clc;
CURRENT_PATH = cd;
RESOURCE_PATH = [CURRENT_PATH , '\resource\B'];
IMAGE_PATH = [RESOURCE_PATH , '\Image'];
LABEL_PATH = [RESOURCE_PATH , '\Label'];
RESULT_PATH = [CURRENT_PATH , '\result\Section B'];

%% 读取图像
cd(IMAGE_PATH);
I1 = imread('Gray1_2.PNG'); I2 = imread('Gray2_2.PNG'); I3 = imread('Gray3_2.PNG');
cd(LABEL_PATH);
L1 = imread('Label1_2.JPG'); L2 = imread('Label2_2.JPG'); L3 = imread('Label3_2.JPG');
cd(CURRENT_PATH);

%% 图像1 butterworth
J1_150_2 = butterFilt(I1,150,2);
J1_200_2 = butterFilt(I1,200,2);
J1_300_2 = butterFilt(I1,300,2);

J1_150_3 = butterFilt(I1,150,3);
J1_200_3 = butterFilt(I1,200,3);
J1_300_3 = butterFilt(I1,300,3);

%% 存盘
cd([RESULT_PATH,'/Image 1']);
imwrite(J1_150_2,'1_150_2.bmp'); imwrite(J1_200_2,'1_200_2.bmp'); imwrite(J1_300_2,'1_300_2.bmp');
cd(CURRENT_PATH);

%% 直方图均衡化
J1_150_eq = myHisteq(J1_150_2); J1_200_eq = myHisteq(J1_200_2); J1_300_eq = myHisteq(J1_300_2);
P1 = zeros(3); S1 = zeros(3);
P1(1) = psnr(J1_150_eq,L1);P1(2) = psnr(J1_200_eq,L1);P1(3) = psnr(J1_300_eq,L1);
S1(1) = ssim(J1_150_eq,L1);S1(2) = ssim(J1_200_eq,L1);S1(3) = ssim(J1_300_eq,L1);

%% 存盘
cd([RESULT_PATH,'/Image 1']);
imwrite(J1_150_eq,'1_150_eq.bmp'); imwrite(J1_200_eq,'1_200_eq.bmp'); imwrite(J1_300_eq,'1_300_eq.bmp');
save('Freq','P1','S1');
cd(CURRENT_PATH);

%% 继续尝试
D0 = 500; J1 = myHisteq(butterFilt(I1,D0,2)); P = psnr(J1,L1), S = ssim(J1,L1),

%% 图像2&3 butterworth
J2_150 = myHisteq(butterFilt(I2,150,2));
J2_300 = myHisteq(butterFilt(I2,300,2));
J2_500 = myHisteq(butterFilt(I2,500,2));

J3_200 = myHisteq(butterFilt(I3,200,2));
J3_400 = myHisteq(butterFilt(I3,400,2));
J3_800 = myHisteq(butterFilt(I3,800,2));

P2 = zeros(3); S2 = zeros(3);
P2(1) = psnr(J2_150,L2);P2(2) = psnr(J2_300,L2);P2(3) = psnr(J2_500,L2);
S2(1) = ssim(J2_150,L2);S2(2) = ssim(J2_300,L2);S2(3) = ssim(J2_500,L2);

P3 = zeros(3); S3 = zeros(3);
P3(1) = psnr(J3_200,L3);P3(2) = psnr(J3_400,L3);P3(3) = psnr(J3_800,L3);
S3(1) = ssim(J3_200,L3);S3(2) = ssim(J3_400,L3);S3(3) = ssim(J3_800,L3);

%% 存盘
cd([RESULT_PATH,'/Image 2']);
imwrite(J2_150,'2_150.bmp'); imwrite(J2_300,'2_300.bmp'); imwrite(J2_500,'2_500.bmp');
save('Freq','P2','S2');
cd(CURRENT_PATH);

cd([RESULT_PATH,'/Image 3']);
imwrite(J3_200,'3_200.bmp'); imwrite(J3_400,'3_400.bmp'); imwrite(J3_800,'3_800.bmp');
save('Freq','P3','S3');
cd(CURRENT_PATH);

%% 图像1&2&3高斯
J1g_150 = myHisteq(gaussFilt(I1,150));
J1g_200 = myHisteq(gaussFilt(I1,200));
J1g_300 = myHisteq(gaussFilt(I1,300));

J2g_150 = myHisteq(gaussFilt(I2,150));
J2g_300 = myHisteq(gaussFilt(I2,300));
J2g_500 = myHisteq(gaussFilt(I2,500));

J3g_200 = myHisteq(gaussFilt(I3,200));
J3g_400 = myHisteq(gaussFilt(I3,400));
J3g_800 = myHisteq(gaussFilt(I3,800));

%% 计算PSNR & SSIM
P1g(1) = psnr(J1g_150,L1); P1g(2) = psnr(J1g_200,L1); P1g(3) = psnr(J1g_300,L1);
P2g(1) = psnr(J2g_150,L2); P2g(2) = psnr(J2g_300,L2); P2g(3) = psnr(J2g_500,L2);
P3g(1) = psnr(J3g_200,L3); P3g(2) = psnr(J3g_400,L3); P3g(3) = psnr(J3g_800,L3);

S1g(1) = ssim(J1g_150,L1); S1g(2) = ssim(J1g_200,L1); S1g(3) = ssim(J1g_300,L1);
S2g(1) = ssim(J2g_150,L2); S2g(2) = ssim(J2g_300,L2); S2g(3) = ssim(J2g_500,L2);
S3g(1) = ssim(J3g_200,L3); S3g(2) = ssim(J3g_400,L3); S3g(3) = ssim(J3g_800,L3);

%% 存盘
cd([RESULT_PATH,'/Image 1']);
imwrite(J1g_150,'g1_150.bmp'); imwrite(J1g_200,'g1_200.bmp'); imwrite(J1g_300,'g1_300.bmp');
save('FreqG','P1g','S1g');
cd(CURRENT_PATH);

cd([RESULT_PATH,'/Image 2']);
imwrite(J2g_150,'g2_150.bmp'); imwrite(J2g_300,'g2_300.bmp'); imwrite(J2g_500,'g2_500.bmp');
save('FreqG','P2g','S2g');
cd(CURRENT_PATH);

cd([RESULT_PATH,'/Image 3']);
imwrite(J3g_200,'g3_200.bmp'); imwrite(J3g_400,'g3_400.bmp'); imwrite(J3g_800,'g3_800.bmp');
save('FreqG','P3g','S3g');
cd(CURRENT_PATH);