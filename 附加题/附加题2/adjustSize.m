function J = adjustSize(I)
% ��һ�������öԳ����ؽ�ͼƬ�ߴ����������
% ����Ĳ������������Ҳ���²�����
% ������ǵõ�����

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