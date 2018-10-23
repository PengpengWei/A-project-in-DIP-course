[x,map]=imread('before.png');  
subplot(1,3,1);
imshow(x);  
title('原始图像');  
%用小波函数haar对x进行2层小波分解  
[c,s] = wavedec2(x,2,'haar');
%设置尺度向量  
n = [1,2];  
%设置阈值向量p  
p = [10,25]; 

%对三个方向高频系数进行硬阈值处理  
nh = wthcoef2('h',c,s,n,p,'h');  
nh = wthcoef2('v',nh,s,n,p,'h');  
nh = wthcoef2('d',nh,s,n,p,'h');  

%对三个方向高频系数进行软阈值处理  
ns = wthcoef2('h',c,s,n,p,'s');  
ns = wthcoef2('v',ns,s,n,p,'s');  
ns = wthcoef2('d',ns,s,n,p,'s');  

%对新的小波分解结构[c,s]进行重构  
x1 = waverec2(nh,s,'haar'); 
x2 = waverec2(ns,s,'haar'); 

subplot(1,3,2);
imshow(uint8(x1)); 
title('硬阈值去噪后图像');  

subplot(1,3,3);
imshow(uint8(x2)); 
title('软阈值去噪后图像');  
