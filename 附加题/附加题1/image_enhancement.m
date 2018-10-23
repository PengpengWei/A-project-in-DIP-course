base='sym4';       %С������sym4
canny_threshold=0.25;   %canny��ֵȡ0.25
[x,map]=imread('brain.tif');  
figure;
subplot(1,3,1);
imshow(x);  
title('ԭʼͼ��'); 

 %С���ֽ�
[c,s] = wavedec2(x,2,base);
 %���ó߶�����  
n = [1,2];  
 %������ֵ����p  
p =[18,23];
%�����������Ƶϵ����������ֵ����  
 ns = wthcoef2('h',c,s,n,p,'s');  
 ns = wthcoef2('v',ns,s,n,p,'s');  
 ns = wthcoef2('d',ns,s,n,p,'s');  
 %���µ�С���ֽ�ṹ�����ع�  
 xx = waverec2(ns,s,base);
 after_wave=uint8(xx);
 subplot(1,3,2);
  imshow(after_wave); 
 title('С��ȥ��ͼ��');
 
 %canny��Ե���
 BW=edge(after_wave,'Canny',canny_threshold); 
 subplot(1,3,3);
imshow(BW); 
sizeBW=size(BW); 
 title('��ֵΪ0.25��canny��Ե��ȡ');
 
 %ϵ������ 
 coeff=[1.5, 2, 2.5, 3, 3.5, 4];
 figure;
 for k=1:6
    to_enhance=after_wave; 
   for i=1:sizeBW(1)
     for j=1:sizeBW(2)
        if(BW(i,j)==1)  %�ҵ���Ե��λ�ã���ȥ���ͼ��Ķ�Ӧλ��Ԫ�س˸�ϵ��
           to_enhance(i,j)=to_enhance(i,j)*coeff(k);
        end;
     end
   end
  subplot(2,3,k);
   imshow(to_enhance); 
   title(['ϵ��Ϊ',num2str(coeff(k))]);
end
 
 