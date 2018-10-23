%canny��Ե��ȡ
[x,map]=imread('Image 2.tif');  
figure;
BW=edge(x,'Canny',0.25); 
subplot(2,2,1);
imshow(BW);
title(['canny��ֵΪ',num2str(0.25)]);

%С����Ե��ȡ
base='sym4';
[c,s] = wavedec2(x,2,base);
ns = wthcoef2('a',c,s);  
xx=abs(waverec2(ns,s,base));
%��Ϊͼ��ͨ���ĸ�ʽ
B=uint8(xx);
sizeB=size(B);
%�趨��ֵ������ֵ
 threshold=5;
  for i=1:sizeB(1)
     for j=1:sizeB(2)
        if(B(i,j)> threshold)
            B(i,j)=255;%����ֵ�����Ϊ��
        else
            B(i,j)=0;%������Ϊ��
        end;
     end
  end
 subplot(2,2,2);
 imshow(B); 
 title(['С����ֵΪ',num2str(threshold)]);
 %����uint8�����޷��ŵģ���������ֵ�Զ���Ϊ0������Ϊ��ɫ����
 %�����С�������ȥcanny�����ʣ�µľ���С����canny����ȡ�Ĳ��֣���֮Ҳ����
 
 %С�������ȥcanny���
 diff1=(B-255*uint8(BW));
 subplot(2,2,3);
 imshow(diff1);
 title('С�������ȥcanny���');
 
 %canny�����ȥС�����
 diff2=(255*uint8(BW)-B);
 subplot(2,2,4);
 imshow(diff2);
 title('canny�����ȥС�����');
 
 