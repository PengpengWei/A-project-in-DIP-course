[x,map]=imread('before.png');  
subplot(1,3,1);
imshow(x);  
title('ԭʼͼ��');  
%��С������haar��x����2��С���ֽ�  
[c,s] = wavedec2(x,2,'haar');
%���ó߶�����  
n = [1,2];  
%������ֵ����p  
p = [10,25]; 

%�����������Ƶϵ������Ӳ��ֵ����  
nh = wthcoef2('h',c,s,n,p,'h');  
nh = wthcoef2('v',nh,s,n,p,'h');  
nh = wthcoef2('d',nh,s,n,p,'h');  

%�����������Ƶϵ����������ֵ����  
ns = wthcoef2('h',c,s,n,p,'s');  
ns = wthcoef2('v',ns,s,n,p,'s');  
ns = wthcoef2('d',ns,s,n,p,'s');  

%���µ�С���ֽ�ṹ[c,s]�����ع�  
x1 = waverec2(nh,s,'haar'); 
x2 = waverec2(ns,s,'haar'); 

subplot(1,3,2);
imshow(uint8(x1)); 
title('Ӳ��ֵȥ���ͼ��');  

subplot(1,3,3);
imshow(uint8(x2)); 
title('����ֵȥ���ͼ��');  
