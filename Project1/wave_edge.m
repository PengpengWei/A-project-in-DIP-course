base='sym4';
[x,map]=imread('Image 2.tif');  
subplot(2,3,1);
imshow(x);  
title('ԭʼͼ��');  
%С���ֽ�
[c,s] = wavedec2(x,2,base);
%��Ƶϵ����0��������Ƶ���֡����Ե�Ǹ�Ƶ������ͼû����������ʣ�²����Ǳ�Ե
ns = wthcoef2('a',c,s);  
%С���ع� ���ַ�ʽ 
%һ�ֶԸ�ϵ����������������ת����ʽʱ�ᱻ��������һ�ֶԸ�ϵ��ȡ�෴�����ɽ��䱣��
xx1=waverec2(ns,s,base);
xx2=abs(waverec2(ns,s,base));
%��Ϊͼ��ͨ���ĸ�ʽ
B=uint8(xx1);
C=uint8(xx2);
sizeB=size(B);
sizeC=size(C);
%������ϵ��������ͼ
threshold1=[5,3];
for k=1:2
    D=B;
  for i=1:sizeB(1)
     for j=1:sizeB(2)
        if(D(i,j)>threshold1(k))
            D(i,j)=255;%����ֵ�����Ϊ��
        else
            D(i,j)=0;%������Ϊ��
        end;
     end
  end
  subplot(2,3,k+1);
   imshow(D); 
   title(['��ȥ��ϵ������ֵΪ',num2str(threshold1(k))]);
end
%������ϵ��������ͼ
threshold2=[5,3,1];
for k=1:3
    E=C;
  for i=1:sizeC(1)
     for j=1:sizeC(2)
        if(E(i,j)>threshold2(k))
            E(i,j)=255;%����ֵ�����Ϊ��
        else
            E(i,j)=0;%������Ϊ��
        end;
     end
  end
  subplot(2,3,k+3);
   imshow(E); 
   title(['������ϵ������ֵΪ',num2str(threshold2(k))]);
end
%���ݽ�������ñ�����ϵ������ֵΪ5
   