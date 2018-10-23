% Project2 Section A Task 2 Part 1 Image 3
% �ӿ���ȫ�ص��ľֲ�ֱ��ͼ���⻯
% ע������Ĵ��ڴ�С��10,401,1001,2001
% 
%% ����·������
clc;
CURRENT_PATH = cd;
RESOURCE_PATH = [CURRENT_PATH , '\resource\A'];
IMAGE_PATH = [RESOURCE_PATH , '\Image'];
LABEL_PATH = [RESOURCE_PATH , '\Label'];
RESULT_PATH = [CURRENT_PATH , '\result\Section A\Task 2\Part 1\Image 3'];

%% ��ȡͼ��
cd(IMAGE_PATH);
I = imread('Gray3_1.JPG');
cd(LABEL_PATH);
L = imread('Label3_1.JPG');
cd(CURRENT_PATH);

%% ����
P = zeros(1,4); S = zeros(1,4); RT = zeros(1,4);

k = 10;
fprintf('���ڱ߳�%d ������...\n',k);
tic;
J1 = myLAHE(I,k);
RT(1) = toc;
imwrite(J1,[RESULT_PATH,'\',num2str(k),'.bmp']);
fprintf('����...\n');
P(1) = psnr(J1,L); S(1) = ssim(J1,L);

k = 401;
fprintf('���ڱ߳�%d ������...\n',k);
tic;
J2 = myLAHE(I,k);
RT(2) = toc;
imwrite(J2,[RESULT_PATH,'\',num2str(k),'.bmp']);
fprintf('����...\n');
P(2) = psnr(J2,L); S(2) = ssim(J2,L);

k = 1001;
fprintf('���ڱ߳�%d ������...\n',k);
tic;
J3 = myLAHE(I,k);
RT(3) = toc;
imwrite(J3,[RESULT_PATH,'\',num2str(k),'.bmp']);
fprintf('����...\n');
P(3) = psnr(J3,L); S(3) = ssim(J3,L);

k = 2001;
fprintf('���ڱ߳�%d ������...\n',k);
tic;
J4 = myLAHE(I,k);
RT(4) = toc;
imwrite(J4,[RESULT_PATH,'\',num2str(k),'.bmp']);
fprintf('����...\n');
P(4) = psnr(J4,L); S(4) = ssim(J4,L);

%% ������
cd(RESULT_PATH);
save('data','P','S','RT');
cd(CURRENT_PATH);