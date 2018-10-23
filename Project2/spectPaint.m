function spectPaint(f,handle)
% ×÷Í¼ÏñµÄÆµÆ×Í¼
    if nargin == 1
        handle = 255;
    end

    F = fft2(f);
    F = fftshift(F);
    
    figure(handle); hold off;
    imshow(log(1+abs(F)),[]);
end