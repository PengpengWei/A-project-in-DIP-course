% Project2 Section A Task 1
% ȫ��ֱ��ͼ���⻯
% 
%% ����·������
clc;
CURRENT_PATH = cd;
RESOURCE_PATH = [CURRENT_PATH , '\resource\A'];
IMAGE_PATH = [RESOURCE_PATH , '\Image'];
LABEL_PATH = [RESOURCE_PATH , '\Label'];
RESULT_PATH = [CURRENT_PATH , '\result\Section A\Task 1'];

%% ��ȡͼ��
cd(IMAGE_PATH);
I1 = imread('Gray1_1.JPG'); I2 = imread('Gray2_1.JPG'); I3 = imread('Gray3_1.JPG');
cd(LABEL_PATH);
L1 = imread('Label1_1.JPG'); L2 = imread('Label2_1.JPG'); L3 = imread('Label3_1.JPG');
cd(CURRENT_PATH);

%% ȫ��ֱ��ͼ���⻯
tic;
J1 = myHisteq(I1); J2 = myHisteq(I2); J3 = myHisteq(I3);
toc;

%% ����psnr��ssim
P = zeros(1,3); S = zeros(1,3);
P(1) = psnr(J1,L1); P(2) = psnr(J2,L2); P(3) = psnr(J3,L3);
S(1) = ssim(J1,L1); S(2) = ssim(J2,L2); S(3) = ssim(J3,L3);

%% ����
cd(RESULT_PATH);
imwrite(J1,'1.bmp'); imwrite(J2,'2.bmp'); imwrite(J3,'3.bmp');
save('psnr n ssim','P','S');

%% ���
cd(CURRENT_PATH);
figure(double(uint16(rand(1)*1024))); hold off;
subplot(231); imshow(I1); title('ԭͼ');
subplot(234); imshow(J1); title('ȫ��ֱ��ͼ���⻯��');
subplot(232); imshow(I2);
subplot(235); imshow(J2);
subplot(233); imshow(I3);
subplot(236); imshow(J3);