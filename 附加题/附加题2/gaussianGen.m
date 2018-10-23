function A = gaussianGen(I,D0,c,gammaH,gammaL)
%
% H = gaussianHighGenerator(I,D0,c,gammaH,gammaL)
% 高斯高频提升滤波,c用于控制锐利度,gammaH和gammaL是过渡范围的上下界
% Ref: textbook P179, P183
%

%% 默认参数
    if nargin < 5
        gammaH = 4.5; gammaL = 0.3;
    end
    
    if nargin < 3
        c = 2;
    end
    
    if nargin < 2
        D0 = 10;
    end

    [M,N,~] = size(I);
    Rrow = floor(M/2); Rcol = floor(N/2);
    A = zeros(M,N);
    
    for i = 1 : M
        for j = 1 : N
            Dsquare = ((i - Rrow) .^ 2 + (j - Rcol) .^ 2);
            % 这里采用比课本P183更为直接的形式：
            % 1. 处理时不再使用fftshift（没有必要）
            % 2. 不使用fftshift，那么中心点即为频率最高位置
            % 3. 高通滤波器，中心指数项为1，直接通过计算与中心的距离实现
            A(i,j) = (gammaH - gammaL) .* exp(-c .* (Dsquare ./ (D0 .* D0))) + gammaL; 
        end
    end
    
    
end