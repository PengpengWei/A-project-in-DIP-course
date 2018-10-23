function fc = colorHomoFilt(I,A)
    I1 = I(:,:,1); I2 = I(:,:,2); I3 = I(:,:,3);
    fc =  uint8(zeros(size(I)));
    fc(:,:,1) = homoFilt(I1,A);
    fc(:,:,2) = homoFilt(I2,A);
    fc(:,:,3) = homoFilt(I3,A);
end