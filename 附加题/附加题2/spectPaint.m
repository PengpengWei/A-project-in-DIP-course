function spectPaint(f,handle)
% ��ͼ���Ƶ��ͼ
    if nargin == 1
        handle = 255;
    end

    F = fft2(f);
    F = fftshift(F);
    
    figure(handle); hold off;
    imshow(log(1+abs(F)),[]);
end