function fc = homoFilt(f,A)
% ̬ͬ�˲�.fΪͼ��AΪƵ��ģ��
% ���uint8�Ҷ�ͼ�񣬻��߲�ɫͼ���һ������
% Ref:https://blog.csdn.net/scottly1/article/details/42705271

    f = double(f);
    lf = log(f + 1); % Ref: textbook P182������Ҷȷ�ΧΪ[0,L-1],���1,������ټ���
    LF = fft2(lf);
    FC = LF .* A;
    fc = ifft2(FC);
    fc = real(fc); % ��ȡʵ��
    fc = exp(fc) - 1;
    % ת��Ϊuint8
    fc = uint8((fc - min(min(fc))) / (max(max(fc))-min(min(fc))) * 255);
    
end