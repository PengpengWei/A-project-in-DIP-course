function H = butterworthGenerator(I,D0,order)
% 巴特沃斯滤波频域模板生成器。I是待处理图像，D0是通带半径,order为滤波器阶数
% 生成的模板尺寸为奇数。
% 所以如果给定图像为偶数尺寸，那么需要进行适当的延拓
    if nargin == 1
        D0 = 100;
        order = 2;
    end
    
    if nargin == 2
        order = 2;
    end
%% 确定模板尺寸
    [M,N] = size(I);
    if round(M/2)*2 == M
        M = M + 1;
    end
    Mr = (M-1)/2;
    
    if round(N/2)*2 == N
        N = N + 1;
    end
    Nr = (N-1)/2;
    
    H = zeros(M,N);
    
%% 计算模板权重
    for x = -Mr : Mr
        for y = -Nr : Nr
            Dsquare = (x * x + y * y);
            H(x + Mr + 1, y + Nr + 1) = 1 / (1 + (Dsquare / (D0 * D0))^(2 * order));
        end
    end
    
%% 归一化模板系数
    total = sum(sum(H));
    H = H ./ total;
end