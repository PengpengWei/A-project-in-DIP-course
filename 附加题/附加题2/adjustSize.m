function J = adjustSize(I)
% 这一函数利用对称延拓将图片尺寸调整至奇数
% 具体的操作方法是在右侧和下侧延拓
% 处理完记得调回来

    [M,N] = size(I);
    if round(M/2) * 2 == M
        i = 1;
    else
        i = 0;
    end
    
    if round(N/2) * 2 == N
        j = 1;
    else
        j = 0;
    end
    
    Ie = myExtend(I);
    J = Ie(M+1:M+M+i,N+1:N+N+j);
    J = uint8(J);
end