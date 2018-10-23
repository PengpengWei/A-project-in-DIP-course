% RGB Picture 1
clear all;
loadPic;
gammaH = [4.5 2.3 1.4];
gammaL = [0.7 0.3 0.1];
c = [1 2 3];
% standard : 1, 0.3, 4.5
figure(255);

[M,N,O] = size(I1);
J = uint8(zeros(M,N,O,9));

for i = 1 : 3
    A = gaussianGen(I1,10,1,4.5,gammaL(i));
    J(:,:,:,i) = colorHomoFilt(I1,A);
end

for i = 1 : 3
    A = gaussianGen(I1,10,1,gammaH(i),0.3);
    J(:,:,:,i+3) = colorHomoFilt(I1,A);
end


for i = 1 : 3
    A = gaussianGen(I1,10,c(i),4.5,0.3);
    J(:,:,:,i+6) = colorHomoFilt(I1,A);
end

subplot(331);imshow(J(:,:,:,1));
subplot(332);imshow(J(:,:,:,2));
subplot(333);imshow(J(:,:,:,3));
subplot(334);imshow(J(:,:,:,4));
subplot(335);imshow(J(:,:,:,5));
subplot(336);imshow(J(:,:,:,6));
subplot(337);imshow(J(:,:,:,7));
subplot(338);imshow(J(:,:,:,8));
subplot(339);imshow(J(:,:,:,9));
