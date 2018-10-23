function A = myExtend(I)
%myExtend
% myExtend(I) 对图像I进行对称的延拓，以方便处理边缘的像素点
% 如果原始尺寸为M,N，那么输出图像的尺寸为3M,3N
%
    symlr = fliplr(I);
    midr = [symlr,I,symlr];
    udr = flipud(midr);
    A = [udr;midr;udr];
end