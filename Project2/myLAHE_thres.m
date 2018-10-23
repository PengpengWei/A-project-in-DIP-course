function J = myLAHE_thres(I,k,thres)
%myLAHE_thres ������Ĵ���ֵ�ľֲ�ֱ��ͼ���⻯�㷨
% J = myLAHE_thres(I,k,thres) ��ͼ�������ֵthres�ֽ�ɸ߻Ҷȷ����͵ͻҶȷ�����
% �ֱ��ڸ��ԵĻҶȷ�Χ�����ֲ�ֱ��ͼ���⻯��Ȼ����ӡ�
%
% IΪ����ͼ��kΪģ���С��kӦ����һ�������������1.
%
% ��һ�������������ĺ�����ȣ�����������������Ҫ�����𣬻���˵��ȱ�ݣ�
% 1. �����ڱ���λҶȷ�Χ�����أ�����һ�����Ϊ0���ر�ʾ�����磬���һ�����ص���
% �ڸ߻Ҷ�ˮƽ����ô���ڵͻҶȵĶ�Ӧλ��ֵΪ0�����Ҳ�����⻯����.
%
% 2. ʹ�õı�ʾ��ʽ��uint8����ʾ��ΧΪ0~255.����߹�255�����ᱻ���Ϊ0.�����
% �Ĳ��ֺڵ�����������ġ�������uint8�ô����ڽ�ʡ�ռ䡣�ڵ����Ϊ��������������
% ֵ�˲���������Ч�˳��󲿷����㷨ʧ���µĺڵ㡣
% 
% See also myLAHE, myLAHE_thres_new, myhist, myHisteq

    if nargin == 2
        thres = 256;
    end
    
    if round(k/2)==k/2
        k=k+1;
    end
    radius = (k-1)/2; % ģ�塰�뾶��
    
    I1 = I; I2 = I; % En1 = ones(size(I)); En2 = ones(size(I));
    I1(I1 > thres) = 0; % �ͻҶȷ���
    I2 = I2 - uint8(ones(size(I2)) * thres);
    I2(I2 <= 0) = 0; % �߻Ҷȷ���,��Χ��thres+1~256��Ϊ1~256-thres

    %% �ͻҶȷ��� 0~thres
    [M,N] = size(I1); % I�Ĵ�СΪM*N
    Ie = myExtend(I1); % Ie�Ĵ�СΪ3M*3N. ����Ҳ���Կ���ʹ��wextend
    
    J1 = uint8(zeros(size(I1)));
    
    % ������������������±����� M+1~2M��N+1~2N
    % ԭͼ��i,j��Ӧ������ͼ������ΪM+i, N+j
    % һ��ʼ��������Ͻ�Ϊ���ĵ�ֱ��ͼ(ԭͼ���Ͻǵĵ�����Ͻ�)
    ie = M;
    je = N;
    localImage = Ie(ie-radius:ie+radius,je-radius:je+radius);
    [localLevel, localCnt] = myhist(localImage,thres); %��0�е�0�е�ֱ��ͼ
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
            curL = I1(i,j); % ��ǰ��Ҷ�
            transum = cumsum(localCnt);
            % ���ĵ�ӳ��
            J1(i,j) = uint8(length(localLevel) * transum(curL + 1) / transum(length(transum))); 
        end
    end   
    
    %% �߻Ҷȷ��� thres+1~255
    [M,N] = size(I2); % I�Ĵ�СΪM*N
    Ie = myExtend(I2); % Ie�Ĵ�СΪ3M*3N. ����Ҳ���Կ���ʹ��wextend
    
    J2 = uint8(zeros(size(I2)));
    
    % ������������������±����� M+1~2M��N+1~2N
    % ԭͼ��i,j��Ӧ������ͼ������ΪM+i, N+j
    % һ��ʼ��������Ͻ�Ϊ���ĵ�ֱ��ͼ(ԭͼ���Ͻǵĵ�����Ͻ�)
    ie = M;
    je = N;
    localImage = Ie(ie-radius:ie+radius,je-radius:je+radius);
    [localLevel, localCnt] = myhist(localImage,256-thres); %��0�е�0�е�ֱ��ͼ
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
            curL = I2(i,j); % ��ǰ��Ҷ�
            transum = cumsum(localCnt);
            % ���ĵ�ӳ��
            if(curL == 0) 
                J2(i,j) = 0;
            else
                J2(i,j) = uint8(length(localLevel) * transum(curL + 1) / transum(length(transum))); 
            end
        end
    end   
    
    %% �ϳ�
    J2 = J2 + uint8(ones(size(J2)) * thres);
    J2(J2<=thres) = 0;
    J = J1 + J2;
end