function fc = gaussFilt(f,D0)
    t = adjustSize(f);
    T = fft2(t);
    T = fftshift(T);
    A = gaussianGenerator(T,D0);
    Tc = T .* A;
    Tc = ifftshift(Tc);
    tc = ifft2(Tc);
    [M,N] = size(f);
    fc = tc(1:M,1:N);
    fc = uint8((fc - min(min(fc))) / (max(max(fc))-min(min(fc))) * 255);
end