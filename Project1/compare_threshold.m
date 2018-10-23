%阈值矩阵，5组不同的阈值组合
A=[10,25;
   15,25;
   18,23;
   14,26;
   12,30]
%B和C分别用来记录去噪后图像与label图像相比的全部噪声元素和较大噪声元素
B=[0,0,0,0,0];
C=[0,0,0,0,0];
base='sym4';
[x,map]=imread('before.png');  
[y,map]=imread('label.tif');  
subplot(2,3,1);
imshow(x);  
title('原始图像');  
for i=1:5
    [c,s] = wavedec2(x,2,base);
    %设置尺度向量  
    n = [1,2];  
    %设置阈值向量p  
    p =[A(i,1),A(i,2)]; 
   %对三个方向高频系数进行软阈值处理  
   ns = wthcoef2('h',c,s,n,p,'s');  
   ns = wthcoef2('v',ns,s,n,p,'s');  
   ns = wthcoef2('d',ns,s,n,p,'s');  
   %对新的小波分解结构[ns,s]进行重构  
   xx = waverec2(ns,s,base); 
   subplot(2,3,i+1);
   imshow(uint8(xx)); 
   title(['阈值向量p为[',num2str(A(i,1)),',',num2str(A(i,2)),']']);
   
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
%最终确定较好的阈值组合为[18,23]