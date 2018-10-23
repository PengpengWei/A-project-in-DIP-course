% Project2 Section A Task 2 Part 2
% ����ֵ�ľֲ�ֱ��ͼ���⻯
% 
% ѡ��ͼ��1
%

%% ����·������
clc;
CURRENT_PATH = cd;
RESOURCE_PATH = [CURRENT_PATH , '\resource\A'];
IMAGE_PATH = [RESOURCE_PATH , '\Image'];
LABEL_PATH = [RESOURCE_PATH , '\Label'];
RESULT_PATH = [CURRENT_PATH , '\result\Section A\Task 2\Part 2'];


%% ��ȡͼ��
cd(IMAGE_PATH);
I = imread('Gray1_1.JPG');
cd(LABEL_PATH);
L = imread('Label1_1.JPG');
cd(CURRENT_PATH);

%% ͳ��ֱ��ͼ����
[level,cnt] = myhist(I);
total = sum(cnt);
cum = cumsum(cnt);
fprintf('Total pixel(s): %d\n',total);
l90 = find(cum <= total * 0.90, 1, 'last' ) - 1;
fprintf('Approximately 90%% pixels are under Level %d\n', l90);
l80 = find(cum <= total * 0.80, 1, 'last' ) - 1;
fprintf('Approximately 80%% pixels are under Level %d\n', l80);
l60 = find(cum <= total * 0.60, 1, 'last') - 1;
fprintf('Approximately 60%% pixels are under Level %d\n', l60);
l40 = find(cum <= total * 0.40, 1, 'last') - 1;
fprintf('Approximately 40%% pixels are under Level %d\n', l40);

% Result:
% Total pixel(s): 7990272
% Approximately 90% pixels are under Level 95
% Approximately 80% pixels are under Level 61
% Approximately 60% pixels are under Level 36
% Approximately 40% pixels are under Level 23

%% �۲쵽���󲿷ֵ����ص�Ҷȶ���100����
% ���м俴�����Ƚ����Ĳ��ֲ����������Ҷ�ֵ��140���¡�
% ɽ���ϵ������лҶ���60~100�ģ�Ҳ��100���ϣ������ﵽ170��
% ����ѡȡ��ֵ100�����ڴ�С1001��ʹ�þɵĺ�����������ֵ�˲�(���ڴ�СΪ3)

J1 = myLAHE_thres(I,1001,100);
J1f = myMedfilt(J1,3);

% ���ָ߻Ҷ�����������Ҷȣ���˽�ԭͼ�ĸ߻Ҷ�ֵ����
J1revise = J1;
J1revise(J1 == 255) = I(J1 == 255);
% Ȼ���˲�
J1revisef = myMedfilt(J1revise,3);
% ��������ƫ��������ȫ��ֱ��ͼ���⻯�ٴ�����
J1revisefeq = myHisteq(J1revisef);

%% ����
cd(RESULT_PATH);
imwrite(J1,'old_thres_wofilt.bmp');
imwrite(J1f,'old_thres_wofilt_filt.bmp');
imwrite(J1revise,'old_thres_revise.bmp');
imwrite(J1revisef,'old_thres_revise_filt.bmp');
imwrite(J1revisefeq,'old_thres_revise_filt_eq.bmp');
P = zeros(1,2); S = zeros(1,2);
P(1) = psnr(J1f,L); P(2) = psnr(J1revisefeq,L);
S(1) = ssim(J1f,L); S(2) = ssim(J1revisefeq,L);
save('psnr n ssim old','P','S');
cd(CURRENT_PATH);

%% �������㷨
cd(CURRENT_PATH);
J60 = myLAHE_thres_new(I,1001,60);
cd(RESULT_PATH);
imwrite(J60,'new_thres_60.bmp');
cd(CURRENT_PATH);
J100 = myLAHE_thres_new(I,1001,100);
cd(RESULT_PATH);
imwrite(J100,'new_thres_100.bmp');
cd(CURRENT_PATH);
J150 = myLAHE_thres_new(I,1001,150);
cd(RESULT_PATH);
imwrite(J150,'new_thres_150.bmp');
P = zeros(1,3); S = zeros(1,3);
P(1) = psnr(J60,L); P(2) = psnr(J100,L); P(3) = psnr(J150,L);
S(1) = ssim(J60,L); S(2) = ssim(J100,L); S(3) = ssim(J150,L);
save('psnr n ssim new','P','S');
cd(CURRENT_PATH);

