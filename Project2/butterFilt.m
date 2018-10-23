function fc = butterFilt(f,D0,order)
    if nargin == 2
        order = 2;
    end
    t = adjustSize(f);
    T = fft2(t);
    T = fftshift(T);
    A = butterworthGenerator(T,D0,order);
    Tc = T .* A;
    Tc = ifftshift(Tc);
    tc = ifft2(Tc);
    [M,N] = size(f);
    fc = tc(1:M,1:N);
    fc = uint8((fc - min(min(fc))) / (max(max(fc))-min(min(fc))) * 255);
end