function [level,cnt] = myhist(I,levelThres)
%myhist Show the histogram of image I.
% myhist(I)用于获取uint8图像I的直方图
%
% myhist(I,levelThres)可以获取灰度范围为0~levelThres的直方图，
% 这一方式的的唯一意义在于已知灰度范围时，可以指定输出向量的长度，方便操作，
% 这一方式不具备错误检查功能。一般只使用第一种方式。
%
% 关于输出：
% 如果使用两个变量[level,cnt]接收输出，则level列举了0~levelThres(255)的所有
% 灰度级，cnt是对应的像素点个数
%
% 如果不给定任何输出参量，那么将在当前活跃的figure上直接作出图像I的直方图
%
% See also myHisteq
    if(nargin == 1)
        levelThres = 255;
    end
    [m,n] = size(I);
    cnt = zeros(1,levelThres+1);
    for i = 1 : m
        for j = 1 : n
            cnt(I(i,j) + 1) = cnt(I(i,j) + 1) + 1;
        end
    end
%     for i=0:255
%         cnt(i+1) = length(find(I==i));
%     end
    level = 0:levelThres;
    if nargout == 0 
        stem(level,cnt,'Marker','none');
    end
end