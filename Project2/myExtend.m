function A = myExtend(I)
%myExtend
% myExtend(I) ��ͼ��I���жԳƵ����أ��Է��㴦���Ե�����ص�
% ���ԭʼ�ߴ�ΪM,N����ô���ͼ��ĳߴ�Ϊ3M,3N
%
    symlr = fliplr(I);
    midr = [symlr,I,symlr];
    udr = flipud(midr);
    A = [udr;midr;udr];
end