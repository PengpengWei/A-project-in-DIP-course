function J = myHisteq(I)
%myHisteq Histogram Equalization.
% myHisteq(I)���ڶ�uint8���͵�ͼ��I����ȫ��ֱ��ͼ���⻯
%
% See also myhist
    [level,cnt] = myhist(I); % ��ȡͼ���ֱ��ͼ
    lowest = min(level); highest = max(level); % ��ȡ�Ҷȷ�Χ
    L = highest - lowest + 1; % �Ҷȼ�����
    
    totalPixel = sum(cnt);
    transferTable = zeros(1,highest);
    sumofPixel = 0;
    for i = lowest : highest
        sumofPixel = sumofPixel + cnt(i + 1); %���㵱ǰ�Ҷ��ۻ����ظ���
        %���㵱ǰ�Ҷ�ӳ��z
        transferTable(i + 1) = round((L - 1)/totalPixel * sumofPixel);
    end
    
    J = uint8(transferTable(I + uint8(ones(size(I)))));
end