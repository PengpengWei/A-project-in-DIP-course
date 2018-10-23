function J = myMedfilt(I,k)
%myMedfilt 中值滤波器
% J = myMedfilt(I,k) 对图像I做模板大小为k的中值滤波
% 如果输入的k是偶数，会被调整为一个奇数
% 

%% 处理输入输参量
    if nargin == 1
        k = 3;
    end
    
    % 把模板边长调整为奇数
    if uint8(k/2) * 2 == k
        k = k + 1;
    end
    
    Ie = myExtend(I); % 对图像做对称延拓
    J = uint8(zeros(size(I))); % 给输出预分配空间
    [M,N] = size(I);
    radius = (k-1)/2;
    
%% 取中值操作

    for i = 1 : M
        for j = 1 : N
            temp = Ie(i + M - radius:i + M + radius,j + N - radius:j + N + radius);
            J(i,j) = median(temp(:));
        end
    end

end