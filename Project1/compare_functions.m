%�趨С�����ľ���
a=['haar ';'db4  ';'sym4 ';'coif4';'dmey '];
A=cellstr(a);
%B��C�ֱ�������¼ȥ���ͼ����labelͼ����ȵ�ȫ������Ԫ�غͽϴ�����Ԫ��
B=[0,0,0,0,0];
C=[0,0,0,0,0];

[x,map]=imread('before.png');  
[y,map]=imread('label.tif');  
subplot(2,3,1);
imshow(x);  
title('ԭʼͼ��');  
for i=1:5
    %ȷ��С�������Ժ���ͼ����зֽ�
    base=char(A(i));
    [c,s] = wavedec2(x,2,base);
    %���ó߶�����  
    n = [1,2];  
    %������ֵ����p  
    p = [10,25]; 
   %�����������Ƶϵ����������ֵ����  
   ns = wthcoef2('h',c,s,n,p,'s');  
   ns = wthcoef2('v',ns,s,n,p,'s');  
   ns = wthcoef2('d',ns,s,n,p,'s');  
   %���µ�С���ֽ�ṹ[c,s]�����ع�  
   xx = waverec2(ns,s,base); 
   subplot(2,3,i+1);
   imshow(uint8(xx)); 
   title(base);
   
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
%����ȷ��С����Ϊsym4
