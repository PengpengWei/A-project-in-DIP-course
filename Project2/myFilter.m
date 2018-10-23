function J = myFilter(A,I)
% I为原始图像，A为模板。采用对称方式延拓
% 暂时只支持A为奇数尺寸方阵

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