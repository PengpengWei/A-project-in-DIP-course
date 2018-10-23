function J = myFilter(A,I)
% IΪԭʼͼ��AΪģ�塣���öԳƷ�ʽ����
% ��ʱֻ֧��AΪ�����ߴ緽��

    Ie = myExtend(I);
    Ie = double(Ie);
    [M,N] = size(I);
    [k,~] = size(A);
    radius = (k - 1) / 2;
    J = zeros(size(I));
    
    for i = 1 : M
        for j = 1 : N
            J(i,j) = sum(sum(Ie(i+M-radius:i+M+radius,j+N-radius:j+N+radius) .* A));
        end
    end
    
    J = uint8(J);

end