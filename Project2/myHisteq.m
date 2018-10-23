function J = myHisteq(I)
%myHisteq Histogram Equalization.
% myHisteq(I)用于对uint8类型的图像I进行全局直方图均衡化
%
% See also myhist
    [level,cnt] = myhist(I); % 获取图像的直方图
    lowest = min(level); highest = max(level); % 获取灰度范围
    L = highest - lowest + 1; % 灰度级数量
    
    totalPixel = sum(cnt);
    transferTable = zeros(1,highest);
    sumofPixel = 0;
    for i = lowest : highest
        sumofPixel = sumofPixel + cnt(i + 1); %计算当前灰度累积像素个数
        %计算当前灰度映射z
        transferTable(i + 1) = round((L - 1)/totalPixel * sumofPixel);
    end
    
    J = uint8(transferTable(I + uint8(ones(size(I)))));
end