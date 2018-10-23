%设定小波基的矩阵
a=['haar ';'db4  ';'sym4 ';'coif4';'dmey '];
A=cellstr(a);
%B和C分别用来记录去噪后图像与label图像相比的全部噪声元素和较大噪声元素
B=[0,0,0,0,0];
C=[0,0,0,0,0];

[x,map]=imread('before.png');  
[y,map]=imread('label.tif');  
subplot(2,3,1);
imshow(x);  
title('原始图像');  
for i=1:5
    %确定小波基并对含噪图像进行分解
    base=char(A(i));
    [c,s] = wavedec2(x,2,base);
    %设置尺度向量  
    n = [1,2];  
    %设置阈值向量p  
    p = [10,25]; 
   %对三个方向高频系数进行软阈值处理  
   ns = wthcoef2('h',c,s,n,p,'s');  
   ns = wthcoef2('v',ns,s,n,p,'s');  
   ns = wthcoef2('d',ns,s,n,p,'s');  
   %对新的小波分解结构[c,s]进行重构  
   xx = waverec2(ns,s,base); 
   subplot(2,3,i+1);
   imshow(uint8(xx)); 
   title(base);
   
   %去噪后图像与label图像作差
   difference=uint8(xx)-y;
   size_diff=size(difference);
   for m=1:size_diff(1)
       for n=1:size_diff(2)
           if(difference(m,n)>0)   %记录剩余噪声元素数目
                B(i)=B(i)+1;
           end;
           if(difference(m,n)>20)  %记录剩余较大噪声元素数目
                C(i)=C(i)+1;
           end;
       end
   end
end
B
C
%最终确定小波基为sym4
