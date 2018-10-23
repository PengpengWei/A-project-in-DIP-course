%canny阈值向量
A=[0.00,0.05,0.1,0.2,0.3];
[x,map]=imread('Image 2.tif');  
figure;
subplot(2,3,1);
imshow(x);  
title('原始图像');  
%粗略估计最佳阈值所在区间
for i=1:5
    BW=edge(x,'Canny',(A(i))); 
    subplot(2,3,i+1);
    imshow(BW);
    title(['阈值为',num2str(A(i))]);
end
%在确定的区间内进一步确定最佳阈值
B=[0.15,0.18,0.20,0.22,0.25,0.28];
figure;
for i=1:6
    BW=edge(x,'Canny',(B(i))); 
    subplot(2,3,i);
    imshow(BW);
    title(['阈值为',num2str(B(i))]);
end
%确定相对较好的阈值为0.25 
