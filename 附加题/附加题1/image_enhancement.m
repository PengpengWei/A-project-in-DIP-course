base='sym4';       %小波基用sym4
canny_threshold=0.25;   %canny阈值取0.25
[x,map]=imread('brain.tif');  
figure;
subplot(1,3,1);
imshow(x);  
title('原始图像'); 

 %小波分解
[c,s] = wavedec2(x,2,base);
 %设置尺度向量  
n = [1,2];  
 %设置阈值向量p  
p =[18,23];
%对三个方向高频系数进行软阈值处理  
 ns = wthcoef2('h',c,s,n,p,'s');  
 ns = wthcoef2('v',ns,s,n,p,'s');  
 ns = wthcoef2('d',ns,s,n,p,'s');  
 %对新的小波分解结构进行重构  
 xx = waverec2(ns,s,base);
 after_wave=uint8(xx);
 subplot(1,3,2);
  imshow(after_wave); 
 title('小波去噪图像');
 
 %canny边缘检测
 BW=edge(after_wave,'Canny',canny_threshold); 
 subplot(1,3,3);
imshow(BW); 
sizeBW=size(BW); 
 title('阈值为0.25的canny边缘提取');
 
 %系数向量 
 coeff=[1.5, 2, 2.5, 3, 3.5, 4];
 figure;
 for k=1:6
    to_enhance=after_wave; 
   for i=1:sizeBW(1)
     for j=1:sizeBW(2)
        if(BW(i,j)==1)  %找到边缘的位置，在去噪后图像的对应位置元素乘个系数
           to_enhance(i,j)=to_enhance(i,j)*coeff(k);
        end;
     end
   end
  subplot(2,3,k);
   imshow(to_enhance); 
   title(['系数为',num2str(coeff(k))]);
end
 
 