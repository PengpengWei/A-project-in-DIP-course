function J = myLAHE(I,k)
%myLAHE Local Area Histogram Equalization
% myLAHE(I,k) ��ͼ��I���д��ڴ�СΪk���ӿ���ȫ�ص���ֱ��ͼ���⻯
% kӦ����һ�������������ں����л��Զ���1
%
% See also myExtend, myhist
%
    if round(k/2)==k/2
        k=k+1;
    end
    radius = (k-1)/2; % ģ�塰�뾶��
    [M,N] = size(I); % I�Ĵ�СΪM*N
    Ie = myExtend(I); % Ie�Ĵ�СΪ3M*3N. ����Ҳ���Կ���ʹ��wextend
    
    J = uint8(zeros(size(I)));
    
    % ������������������±����� M+1~2M��N+1~2N
    % ԭͼ��i,j��Ӧ������ͼ������ΪM+i, N+j
    % һ��ʼ��������Ͻ�Ϊ���ĵ�ֱ��ͼ(ԭͼ���Ͻǵĵ�����Ͻ�)
    ie = M;
    je = N;
    localImage = Ie(ie-radius:ie+radius,je-radius:je+radius);
    [localLevel, localCnt] = myhist(localImage); %��0�е�0�е�ֱ��ͼ
    preCnt = localCnt; % ������ǰһ��ֱ��ͼ���棬�Թ���һ���ƶ�ʹ��
    
    % �в���
    for i = 1 : M
        ie = M + i;
        je = N;
        
        localCnt = preCnt; % ��ȡ��һ���м����ֱ��ͼ
        prerow = Ie(ie-radius-1,je-radius:je+radius);
        currow = Ie(ie+radius,je-radius:je+radius);
        % ��ȥ����
        for k = 1 : 2 * radius + 1
            localCnt(prerow(k)+1) = localCnt(prerow(k)+1) - 1;
        end
        % �������һ��
        for k = 1 : 2 * radius + 1
            localCnt(currow(k)+1) = localCnt(currow(k)+1) + 1;
        end
        preCnt = localCnt; % ���汾�μ�����������һ�����ƶ�����ʹ��
        
        % ���в���
        for j = 1 : N
            je = N + j;
            precol = Ie(ie-radius:ie+radius,je-radius-1);
            curcol = Ie(ie-radius:ie+radius,je+radius);
            % ��ȥ����
            for k = 1 : 2 * radius + 1
                localCnt(precol(k)+1) = localCnt(precol(k)+1) - 1;
            end
            % �������һ��
            for k = 1 : 2 * radius + 1
                localCnt(curcol(k)+1) = localCnt(curcol(k)+1) + 1;
            end
            curL = I(i,j); % ��ǰ��Ҷ�
            transum = cumsum(localCnt);
            % ���ĵ�ӳ��
            J(i,j) = uint8(length(localLevel) * transum(curL + 1) / transum(length(transum))); 
        end
    end
    
        
end