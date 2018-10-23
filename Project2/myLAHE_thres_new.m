function J = myLAHE_thres_new(I,k,thres)
%myLAHE_thres_new ������ֵ����ͼ�ָ�ľֲ�ֱ��ͼ���⻯�㷨
% J = myLAHE_thres_new(I,k,thres) �ȸ��ݸ���thres����ԭʼͼ��I�ָ����ͼI1��I2
% �ٶ�I1��I2�ֱ������ԻҶȷ�Χ�ڵģ����ڱ߳�Ϊk�ľֲ�ֱ��ͼ���⻯
% ���֮ǰ�ľֲ�ֱ��ͼ��ֵ�㷨myLAHE_thres��һЩ����
% 
% See also myLAHE, myLAHE_thres, myhist, myHisteq
%

    % �������ڴ�С
    if round(k/2)*2 == k
        k = k + 1;
    end
    
    I = uint16(I); % ת��Ϊ16λ�������������
    % ������ֵǰ���ͼ��
    En1 = uint16(zeros(size(I))); En2 = uint16(zeros(size(I)));
    En1(I <= thres) = 1; % ��ͼ1��λͼ. �Ҷȷ�Χ0~thres�����Ϊ1
    En2(I > thres) = 1;  % ��ͼ2��λͼ���Ҷȷ�Χthres+1~255�����Ϊ1
    I1 = I .* En1; I2 = I .* En2; % �������ͼ
    I1 = I1 + uint16(ones(size(I))); % ����ͼ1�ĻҶȷ�Χ�鵽1~thres+1
    I2 = I2 - uint16(ones(size(I))) * thres; % ����ͼ2�ĻҶȷ�Χ�鵽1~255-thres
    
    % LAHEthresSub(I,En,k,low,high)���Ҷȷ�Χ��low~high֮�䣬
    % ����Enλͼ��ͼ��I�����ڴ�Сk���оֲ�ֱ��ͼ���⻯
    % �������������J�ĻҶȷ�Χ��low~high��λͼ��Ч������0��λͼ��Ч����
    J1 = LAHEthresSub(I1,En1,k,1,thres+1);
    J2 = LAHEthresSub(I2,En2,k,1,255-thres);

    J1(J1 ~= 0) = J1(J1 ~= 0) - 1; J2(J2 ~= 0) = J2(J2 ~= 0) + thres;
    J1 = J1 .* En1; J2 = J2 .* En2;
    J = J1 + J2;
    J = uint8(J); % ת����uint8
end

function J = LAHEthresSub(I,En,k,low,high)
    [M,N] = size(I);
    Ie = myExtend(I); Ene = myExtend(En);
    radius = (k - 1) / 2; % ���ڰ뾶
    cnt = zeros(1,high - low + 1); % ͳ�Ʊ�����ͳ�ƴ����и��Ҷ�ֵ��������
    J = uint16(zeros(size(I)));
    
    %% ��ʼcntֵ���㡣ʹ��Ԫ��M-radius:M+radius, N-radius:N+radius
    for i = M - radius : M + radius
        for j = N - radius : N + radius
            if Ene(i,j) ~= 0
                cnt(Ie(i,j)) = cnt(Ie(i,j)) + 1;
            end
        end
    end
    precnt = cnt;
    
    %% �������Ԫ��
    for x = 1 : M
        cnt = precnt; % ��ȡ��һ�ֵĵ�0��
        xe = x + M; ye = N;
        %��������
        for j = ye - radius : ye + radius
            % ɾȥ����
            if Ene(xe-radius-1,j) ~= 0
                cnt(Ie(xe-radius-1,j)) = cnt(Ie(xe-radius-1,j)) - 1;
            end
            
            % ��������
            if Ene(xe+radius,j) ~= 0
                cnt(Ie(xe+radius,j)) = cnt(Ie(xe+radius,j)) + 1;
            end
        end
        precnt = cnt; %�����μ��������棬����һ��ʹ��
        
        for y = 1 : N
            ye = y + N;
            
            % ��������
            for i = xe - radius : xe + radius
                % ɾȥ����
                if Ene(i,ye-radius-1) ~= 0
                    cnt(Ie(i,ye-radius-1)) = cnt(Ie(i,ye-radius-1)) - 1;
                end
                
                % ��������
                if Ene(i,ye+radius) ~= 0
                    cnt(Ie(i,ye+radius)) = cnt(Ie(i,ye+radius)) + 1;
                end
            end
            
            if En(x,y) ~= 0
                cumF = sum(cnt(1:I(x,y)));
                total = sum(cnt);
                J(x,y) = uint16( low + (high - low) * cumF / total ); % λͼ��Ч��J������ֵ��ΧΪlow~high
            else
                J(x,y) = 0;
            end
        end
    end
end