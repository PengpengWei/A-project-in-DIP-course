%canny��ֵ����
A=[0.00,0.05,0.1,0.2,0.3];
[x,map]=imread('Image 2.tif');  
figure;
subplot(2,3,1);
imshow(x);  
title('ԭʼͼ��');  
%���Թ��������ֵ��������
for i=1:5
    BW=edge(x,'Canny',(A(i))); 
    subplot(2,3,i+1);
    imshow(BW);
    title(['��ֵΪ',num2str(A(i))]);
end
%��ȷ���������ڽ�һ��ȷ�������ֵ
B=[0.15,0.18,0.20,0.22,0.25,0.28];
figure;
for i=1:6
    BW=edge(x,'Canny',(B(i))); 
    subplot(2,3,i);
    imshow(BW);
    title(['��ֵΪ',num2str(B(i))]);
end
%ȷ����ԽϺõ���ֵΪ0.25 
