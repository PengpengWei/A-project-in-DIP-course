%��ֵ����5�鲻ͬ����ֵ���
A=[10,25;
   15,25;
   18,23;
   14,26;
   12,30]
%B��C�ֱ�������¼ȥ���ͼ����labelͼ����ȵ�ȫ������Ԫ�غͽϴ�����Ԫ��
B=[0,0,0,0,0];
C=[0,0,0,0,0];
base='sym4';
[x,map]=imread('before.png');  
[y,map]=imread('label.tif');  
subplot(2,3,1);
imshow(x);  
title('ԭʼͼ��');  
for i=1:5
    [c,s] = wavedec2(x,2,base);
    %���ó߶�����  
    n = [1,2];  
    %������ֵ����p  
    p =[A(i,1),A(i,2)]; 
   %�����������Ƶϵ����������ֵ����  
   ns = wthcoef2('h',c,s,n,p,'s');  
   ns = wthcoef2('v',ns,s,n,p,'s');  
   ns = wthcoef2('d',ns,s,n,p,'s');  
   %���µ�С���ֽ�ṹ[ns,s]�����ع�  
   xx = waverec2(ns,s,base); 
   subplot(2,3,i+1);
   imshow(uint8(xx)); 
   title(['��ֵ����pΪ[',num2str(A(i,1)),',',num2str(A(i,2)),']']);
   
   %ȥ���ͼ����labelͼ������
   difference=uint8(xx)-y;
   size_diff=size(difference);
   for m=1:size_diff(1)
       for n=1:size_diff(2)
           if(difference(m,n)>0)   %��¼ʣ������Ԫ����Ŀ
                B(i)=B(i)+1;
           end;
           if(difference(m,n)>20)  %��¼ʣ��ϴ�����Ԫ����Ŀ
                C(i)=C(i)+1;
           end;
       end
   end
end
B
C
%����ȷ���Ϻõ���ֵ���Ϊ[18,23]