function H = gaussianGenerator(I,D0)
% ��˹�˲�Ƶ��ģ����������I�Ǵ�����ͼ��D0��ͨ���뾶�����ɵ�ģ��ߴ�Ϊ������
% �����������ͼ��Ϊż���ߴ磬��ô��Ҫ�����ʵ�������
    if nargin == 1
        D0 = 100;
    end
    
%% ȷ��ģ��ߴ�
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
    
%% ����ģ��Ȩ��
    for x = -Mr : Mr
        for y = -Nr : Nr
            Dsquare = (x * x + y * y);
            H(x + Mr + 1, y + Nr + 1) = exp(- Dsquare * 0.5 / (D0 * D0));
        end
    end
    
%% ��һ��ģ��ϵ��
    total = sum(sum(H));
    H = H ./ total;
    
end