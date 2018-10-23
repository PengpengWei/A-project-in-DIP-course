function J = myLAHE_thres_new(I,k,thres)
%myLAHE_thres_new 基于阈值的子图分割的局部直方图均衡化算法
% J = myLAHE_thres_new(I,k,thres) 先根据给定thres，将原始图像I分割成子图I1，I2
% 再对I1和I2分别作各自灰度范围内的，窗口边长为k的局部直方图均衡化
% 针对之前的局部直方图阈值算法myLAHE_thres作一些修正
% 
% See also myLAHE, myLAHE_thres, myhist, myHisteq
%

    % 调整窗口大小
    if round(k/2)*2 == k
        k = k + 1;
    end
    
    I = uint16(I); % 转换为16位，方便后续计算
    % 分离阈值前后的图像
    En1 = uint16(zeros(size(I))); En2 = uint16(zeros(size(I)));
    En1(I <= thres) = 1; % 子图1的位图. 灰度范围0~thres被标记为1
    En2(I > thres) = 1;  % 子图2的位图，灰度范围thres+1~255被标记为1
    I1 = I .* En1; I2 = I .* En2; % 计算出子图
    I1 = I1 + uint16(ones(size(I))); % 把子图1的灰度范围归到1~thres+1
    I2 = I2 - uint16(ones(size(I))) * thres; % 把子图2的灰度范围归到1~255-thres
    
    % LAHEthresSub(I,En,k,low,high)将灰度范围在low~high之间，
    % 具有En位图的图像I按窗口大小k进行局部直方图均衡化
    % 经过操作后，输出J的灰度范围在low~high（位图有效处）和0（位图无效处）
    J1 = LAHEthresSub(I1,En1,k,1,thres+1);
    J2 = LAHEthresSub(I2,En2,k,1,255-thres);

    J1(J1 ~= 0) = J1(J1 ~= 0) - 1; J2(J2 ~= 0) = J2(J2 ~= 0) + thres;
    J1 = J1 .* En1; J2 = J2 .* En2;
    J = J1 + J2;
    J = uint8(J); % 转换回uint8
end

function J = LAHEthresSub(I,En,k,low,high)
    [M,N] = size(I);
    Ie = myExtend(I); Ene = myExtend(En);
    radius = (k - 1) / 2; % 窗口半径
    cnt = zeros(1,high - low + 1); % 统计表，用于统计窗口中各灰度值像素数量
    J = uint16(zeros(size(I)));
    
    %% 初始cnt值计算。使用元素M-radius:M+radius, N-radius:N+radius
    for i = M - radius : M + radius
        for j = N - radius : N + radius
            if Ene(i,j) ~= 0
                cnt(Ie(i,j)) = cnt(Ie(i,j)) + 1;
            end
        end
    end
    precnt = cnt;
    
    %% 逐个更新元素
    for x = 1 : M
        cnt = precnt; % 读取上一轮的第0列
        xe = x + M; ye = N;
        %窗口下移
        for j = ye - radius : ye + radius
            % 删去老行
            if Ene(xe-radius-1,j) ~= 0
                cnt(Ie(xe-radius-1,j)) = cnt(Ie(xe-radius-1,j)) - 1;
            end
            
            % 加入新行
            if Ene(xe+radius,j) ~= 0
                cnt(Ie(xe+radius,j)) = cnt(Ie(xe+radius,j)) + 1;
            end
        end
        precnt = cnt; %将本次计算结果保存，供下一轮使用
        
        for y = 1 : N
            ye = y + N;
            
            % 窗口右移
            for i = xe - radius : xe + radius
                % 删去老列
                if Ene(i,ye-radius-1) ~= 0
                    cnt(Ie(i,ye-radius-1)) = cnt(Ie(i,ye-radius-1)) - 1;
                end
                
                % 加入新列
                if Ene(i,ye+radius) ~= 0
                    cnt(Ie(i,ye+radius)) = cnt(Ie(i,ye+radius)) + 1;
                end
            end
            
            if En(x,y) ~= 0
                cumF = sum(cnt(1:I(x,y)));
                total = sum(cnt);
                J(x,y) = uint16( low + (high - low) * cumF / total ); % 位图有效处J的像素值范围为low~high
            else
                J(x,y) = 0;
            end
        end
    end
end