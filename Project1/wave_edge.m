base='sym4';
[x,map]=imread('Image 2.tif');  
subplot(2,3,1);
imshow(x);  
title('原始图像');  
%小波分解
[c,s] = wavedec2(x,2,base);
%低频系数置0，保留高频部分。因边缘是高频，而本图没有噪声，则剩下部分是边缘
ns = wthcoef2('a',c,s);  
%小波重构 两种方式 
%一种对负系数不做处理，这样在转换格式时会被舍弃；另一种对负系数取相反数，可将其保留
xx1=waverec2(ns,s,base);
xx2=abs(waverec2(ns,s,base));
%变为图像通常的格式
B=uint8(xx1);
C=uint8(xx2);
sizeB=size(B);
sizeC=size(C);
%舍弃负系数，两张图
threshold1=[5,3];
for k=1:2
    D=B;
  for i=1:sizeB(1)
     for j=1:sizeB(2)
        if(D(i,j)>threshold1(k))
            D(i,j)=255;%比阈值大的置为白
        else
            D(i,j)=0;%否则置为黑
        end;
     end
  end
  subplot(2,3,k+1);
   imshow(D); 
   title(['舍去负系数，阈值为',num2str(threshold1(k))]);
end
%保留负系数，三张图
threshold2=[5,3,1];
for k=1:3
    E=C;
  for i=1:sizeC(1)
     for j=1:sizeC(2)
        if(E(i,j)>threshold2(k))
            E(i,j)=255;%比阈值大的置为白
        else
            E(i,j)=0;%否则置为黑
        end;
     end
  end
  subplot(2,3,k+3);
   imshow(E); 
   title(['保留负系数，阈值为',num2str(threshold2(k))]);
end
%根据结果，采用保留负系数，阈值为5
   