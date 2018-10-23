%% 常规路径操作
clc;
CURRENT_PATH = cd;
RESOURCE_PATH = [CURRENT_PATH , '\resource\B'];
IMAGE_PATH = [RESOURCE_PATH , '\Image'];
LABEL_PATH = [RESOURCE_PATH , '\Label'];
RESULT_PATH = [CURRENT_PATH , '\result\Section B\Image 1'];

%% 不同模板大小下均值滤波后，再经过全局直方图均衡化后的结果：
clc;
f1 = imread([IMAGE_PATH,'\Gray1_2.PNG']);
ref1 = imread([LABEL_PATH,'\Label1_2.JPG']);
psnr_array = zeros(1,3);
ssim_array = zeros(1,3);

 %% case 1 3*3模板
 A = ones(3,3) / (3*3);
 j1 = myFilter(A,f1);
 j1_eq = myHisteq(j1);
 psnr_array(1) = psnr(j1_eq,ref1);
 ssim_array(1) = ssim(j1_eq,ref1);
 
 %% case 2 5*5模板
 A = ones(5,5) / (5*5);
 j2 = myFilter(A,f1);
 j2_eq = myHisteq(j2);
 psnr_array(2) = psnr(j2_eq,ref1);
 ssim_array(2) = ssim(j2_eq,ref1);
 
 %% case 3 7*7模板
 A = ones(7,7) / (7*7);
 j3 = myFilter(A,f1);
 j3_eq = myHisteq(j3);
 psnr_array(3) = psnr(j3_eq,ref1);
 ssim_array(3) = ssim(j3_eq,ref1);
 
 %% 作图
 figure(1);
 subplot(221);
 imshow(j1_eq); title('3*3均值模板');
 subplot(222);
 imshow(j2_eq); title('5*5均值模板');
 subplot(223);
 imshow(j3_eq); title('7*7均值模板');
 subplot(224);
 imshow(ref1); title('Label');
 
 %% 导出结果
 cd(RESULT_PATH);
 save('psnr n ssim mean','psnr_array','ssim_array');
 imwrite(j1,'3x3.bmp');imwrite(j2,'5x5.bmp');imwrite(j3,'7x7.bmp');
 imwrite(j1_eq,'3x3_eq.bmp');imwrite(j2_eq,'5x5_eq.bmp');imwrite(j3_eq,'7x7_eq.bmp');
 cd(CURRENT_PATH);