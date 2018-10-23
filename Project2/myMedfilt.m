function J = myMedfilt(I,k)
%myMedfilt ��ֵ�˲���
% J = myMedfilt(I,k) ��ͼ��I��ģ���СΪk����ֵ�˲�
% ��������k��ż�����ᱻ����Ϊһ������
% 

%% �������������
    if nargin == 1
        k = 3;
    end
    
    % ��ģ��߳�����Ϊ����
    if uint8(k/2) * 2 == k
        k = k + 1;
    end
    
    Ie = myExtend(I); % ��ͼ�����Գ�����
    J = uint8(zeros(size(I))); % �����Ԥ����ռ�
    [M,N] = size(I);
    radius = (k-1)/2;
    
%% ȡ��ֵ����

    for i = 1 : M
        for j = 1 : N
            temp = Ie(i + M - radius:i + M + radius,j + N - radius:j + N + radius);
            J(i,j) = median(temp(:));
        end
    end

end