function J = myLAHE_thres(I,k,thres)
%myLAHE_thres 不成熟的带阈值的局部直方图均衡化算法
% J = myLAHE_thres(I,k,thres) 将图像根据阈值thres分解成高灰度分量和低灰度分量，
% 分别在各自的灰度范围内作局部直方图均衡化，然后叠加。
%
% I为输入图像，k为模板大小。k应当是一个奇数，否则加1.
%
% 这一函数与修正过的函数相比，至少有以下两个主要的区别，或者说是缺陷：
% 1. 不属于本层次灰度范围的像素，在这一层次中为0像素表示。例如，如果一个像素点属
% 于高灰度水平，那么它在低灰度的对应位置值为0，并且参与均衡化计算.
%
% 2. 使用的表示方式是uint8，表示范围为0~255.如果高过255，将会被归结为0.结果中
% 的部分黑点就是这样来的。不过用uint8好处在于节省空间。黑点可视为胡椒噪声，用中
% 值滤波器可以有效滤除大部分由算法失误导致的黑点。
% 
% See also myLAHE, myLAHE_thres_new, myhist, myHisteq

    if nargin == 2
        thres = 256;
    end
    
    if round(k/2)==k/2
        k=k+1;
    end
    radius = (k-1)/2; % 模板“半径”
    
    I1 = I; I2 = I; % En1 = ones(size(I)); En2 = ones(size(I));
    I1(I1 > thres) = 0; % 低灰度分量
    I2 = I2 - uint8(ones(size(I2)) * thres);
    I2(I2 <= 0) = 0; % 高灰度分量,范围由thres+1~256变为1~256-thres

    %% 低灰度分量 0~thres
    [M,N] = size(I1); % I的大小为M*N
    Ie = myExtend(I1); % Ie的大小为3M*3N. 这里也可以考虑使用wextend
    
    J1 = uint8(zeros(size(I1)));
    
    % 真正待处理的区域是下标索引 M+1~2M，N+1~2N
    % 原图的i,j对应到延拓图像，坐标为M+i, N+j
    % 一开始先算出左上角为中心的直方图(原图左上角的点的左上角)
    ie = M;
    je = N;
    localImage = Ie(ie-radius:ie+radius,je-radius:je+radius);
    [localLevel, localCnt] = myhist(localImage,thres); %第0行第0列的直方图
    preCnt = localCnt; % 将本行前一列直方图保存，以供下一次移动使用
    
    % 行操作
    for i = 1 : M
        ie = M + i;
        je = N;
        
        localCnt = preCnt; % 读取上一次行计算的直方图
        prerow = Ie(ie-radius-1,je-radius:je+radius);
        currow = Ie(ie+radius,je-radius:je+radius);
        % 减去首行
        for k = 1 : 2 * radius + 1
            localCnt(prerow(k)+1) = localCnt(prerow(k)+1) - 1;
        end
        % 加上最后一行
        for k = 1 : 2 * radius + 1
            localCnt(currow(k)+1) = localCnt(currow(k)+1) + 1;
        end
        preCnt = localCnt; % 保存本次计算结果，供下一次行移动计算使用
        
        % 对列操作
        for j = 1 : N
            je = N + j;
            precol = Ie(ie-radius:ie+radius,je-radius-1);
            curcol = Ie(ie-radius:ie+radius,je+radius);
            % 减去首列
            for k = 1 : 2 * radius + 1
                localCnt(precol(k)+1) = localCnt(precol(k)+1) - 1;
            end
            % 加上最后一列
            for k = 1 : 2 * radius + 1
                localCnt(curcol(k)+1) = localCnt(curcol(k)+1) + 1;
            end
            curL = I1(i,j); % 当前点灰度
            transum = cumsum(localCnt);
            % 中心点映射
            J1(i,j) = uint8(length(localLevel) * transum(curL + 1) / transum(length(transum))); 
        end
    end   
    
    %% 高灰度分量 thres+1~255
    [M,N] = size(I2); % I的大小为M*N
    Ie = myExtend(I2); % Ie的大小为3M*3N. 这里也可以考虑使用wextend
    
    J2 = uint8(zeros(size(I2)));
    
    % 真正待处理的区域是下标索引 M+1~2M，N+1~2N
    % 原图的i,j对应到延拓图像，坐标为M+i, N+j
    % 一开始先算出左上角为中心的直方图(原图左上角的点的左上角)
    ie = M;
    je = N;
    localImage = Ie(ie-radius:ie+radius,je-radius:je+radius);
    [localLevel, localCnt] = myhist(localImage,256-thres); %第0行第0列的直方图
    preCnt = localCnt; % 将本行前一列直方图保存，以供下一次移动使用
    
    % 行操作
    for i = 1 : M
        ie = M + i;
        je = N;
        
        localCnt = preCnt; % 读取上一次行计算的直方图
        prerow = Ie(ie-radius-1,je-radius:je+radius);
        currow = Ie(ie+radius,je-radius:je+radius);
        % 减去首行
        for k = 1 : 2 * radius + 1
            localCnt(prerow(k)+1) = localCnt(prerow(k)+1) - 1;
        end
        % 加上最后一行
        for k = 1 : 2 * radius + 1
            localCnt(currow(k)+1) = localCnt(currow(k)+1) + 1;
        end
        preCnt = localCnt; % 保存本次计算结果，供下一次行移动计算使用
        
        % 对列操作
        for j = 1 : N
            je = N + j;
            precol = Ie(ie-radius:ie+radius,je-radius-1);
            curcol = Ie(ie-radius:ie+radius,je+radius);
            % 减去首列
            for k = 1 : 2 * radius + 1
                localCnt(precol(k)+1) = localCnt(precol(k)+1) - 1;
            end
            % 加上最后一列
            for k = 1 : 2 * radius + 1
                localCnt(curcol(k)+1) = localCnt(curcol(k)+1) + 1;
            end
            curL = I2(i,j); % 当前点灰度
            transum = cumsum(localCnt);
            % 中心点映射
            if(curL == 0) 
                J2(i,j) = 0;
            else
                J2(i,j) = uint8(length(localLevel) * transum(curL + 1) / transum(length(transum))); 
            end
        end
    end   
    
    %% 合成
    J2 = J2 + uint8(ones(size(J2)) * thres);
    J2(J2<=thres) = 0;
    J = J1 + J2;
end