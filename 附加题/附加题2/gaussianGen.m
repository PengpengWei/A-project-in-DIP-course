function A = gaussianGen(I,D0,c,gammaH,gammaL)
%
% H = gaussianHighGenerator(I,D0,c,gammaH,gammaL)
% ��˹��Ƶ�����˲�,c���ڿ���������,gammaH��gammaL�ǹ��ɷ�Χ�����½�
% Ref: textbook P179, P183
%

%% Ĭ�ϲ���
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
            % ������ñȿα�P183��Ϊֱ�ӵ���ʽ��
            % 1. ����ʱ����ʹ��fftshift��û�б�Ҫ��
            % 2. ��ʹ��fftshift����ô���ĵ㼴ΪƵ�����λ��
            % 3. ��ͨ�˲���������ָ����Ϊ1��ֱ��ͨ�����������ĵľ���ʵ��
            A(i,j) = (gammaH - gammaL) .* exp(-c .* (Dsquare ./ (D0 .* D0))) + gammaL; 
        end
    end
    
    
end