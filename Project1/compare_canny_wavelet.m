%canny边缘提取
[x,map]=imread('Image 2.tif');  
figure;
BW=edge(x,'Canny',0.25); 
subplot(2,2,1);
imshow(BW);
title(['canny阈值为',num2str(0.25)]);

%小波边缘提取
base='sym4';
[c,s] = wavedec2(x,2,base);
ns = wthcoef2('a',c,s);  
xx=abs(waverec2(ns,s,base));
%变为图像通常的格式
B=uint8(xx);
sizeB=size(B);
%设定二值化的阈值
 threshold=5;
  for i=1:sizeB(1)
     for j=1:sizeB(2)
        if(B(i,j)> threshold)
            B(i,j)=255;%比阈值大的置为白
        else
            B(i,j)=0;%否则置为黑
        end;
     end
  end
 subplot(2,2,2);
 imshow(B); 
 title(['小波阈值为',num2str(threshold)]);
 %由于uint8型是无符号的，做减法后负值自动变为0，即成为黑色背景
 %因此用小波结果减去canny结果，剩下的就是小波比canny多提取的部分，反之也成立
 
 %小波结果减去canny结果
 diff1=(B-255*uint8(BW));
 subplot(2,2,3);
 imshow(diff1);
 title('小波结果减去canny结果');
 
 %canny结果减去小波结果
 diff2=(255*uint8(BW)-B);
 subplot(2,2,4);
 imshow(diff2);
 title('canny结果减去小波结果');
 
 