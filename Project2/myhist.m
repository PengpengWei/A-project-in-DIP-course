function [level,cnt] = myhist(I,levelThres)
%myhist Show the histogram of image I.
% myhist(I)���ڻ�ȡuint8ͼ��I��ֱ��ͼ
%
% myhist(I,levelThres)���Ի�ȡ�Ҷȷ�ΧΪ0~levelThres��ֱ��ͼ��
% ��һ��ʽ�ĵ�Ψһ����������֪�Ҷȷ�Χʱ������ָ����������ĳ��ȣ����������
% ��һ��ʽ���߱������鹦�ܡ�һ��ֻʹ�õ�һ�ַ�ʽ��
%
% ���������
% ���ʹ����������[level,cnt]�����������level�о���0~levelThres(255)������
% �Ҷȼ���cnt�Ƕ�Ӧ�����ص����
%
% ����������κ������������ô���ڵ�ǰ��Ծ��figure��ֱ������ͼ��I��ֱ��ͼ
%
% See also myHisteq
    if(nargin == 1)
        levelThres = 255;
    end
    [m,n] = size(I);
    cnt = zeros(1,levelThres+1);
    for i = 1 : m
        for j = 1 : n
            cnt(I(i,j) + 1) = cnt(I(i,j) + 1) + 1;
        end
    end
%     for i=0:255
%         cnt(i+1) = length(find(I==i));
%     end
    level = 0:levelThres;
    if nargout == 0 
        stem(level,cnt,'Marker','none');
    end
end