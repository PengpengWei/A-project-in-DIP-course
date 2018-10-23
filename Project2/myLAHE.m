function J = myLAHE(I,k)
%myLAHE Local Area Histogram Equalization
% myLAHE(I,k) 对图像I进行窗口大小为k的子块完全重叠的直方图均衡化
% k应当是一个奇数，否则在函数中会自动加1
%
% See also myExtend, myhist
%
    if round(k/2)==k/2
        k=k+1;
    end
    radius = (k-1)/2; % 模板“半径”
    [M,N] = size(I); % I的大小为M*N
    Ie = myExtend(I); % Ie的大小为3M*3N. 这里也可以考虑使用wextend
    
    J = uint8(zeros(size(I)));
    
    % 真正待处理的区域是下标索引 M+1~2M，N+1~2N
    % 原图的i,j对应到延拓图像，坐标为M+i, N+j
    % 一开始先算出左上角为中心的直方图(原图左上角的点的左上角)
    ie = M;
    je = N;
    localImage = Ie(ie-radius:ie+radius,je-radius:je+radius);
    [localLevel, localCnt] = myhist(localImage); %第0行第0列的直方图
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
            curL = I(i,j); % 当前点灰度
            transum = cumsum(localCnt);
            % 中心点映射
            J(i,j) = uint8(length(localLevel) * transum(curL + 1) / transum(length(transum))); 
        end
    end
    
        
end