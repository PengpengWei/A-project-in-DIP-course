function fc = homoFilt(f,A)
% 同态滤波.f为图像，A为频域模板
% 针对uint8灰度图像，或者彩色图像的一个分量
% Ref:https://blog.csdn.net/scottly1/article/details/42705271

    f = double(f);
    lf = log(f + 1); % Ref: textbook P182：如果灰度范围为[0,L-1],须加1,处理后再减掉
    LF = fft2(lf);
    FC = LF .* A;
    fc = ifft2(FC);
    fc = real(fc); % 提取实部
    fc = exp(fc) - 1;
    % 转换为uint8
    fc = uint8((fc - min(min(fc))) / (max(max(fc))-min(min(fc))) * 255);
    
end