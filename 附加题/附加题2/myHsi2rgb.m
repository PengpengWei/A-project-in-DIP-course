function g = myHsi2rgb(f)
% 
% myHsi2rgb Convert hue-saturation-intensity to red-green-blue colors .
% MATLAB没有内置这一函数
% Ref: 
% [1] textbook P260
% [2] https://blog.csdn.net/shitao827194819/article/details/9465145
% [3] https://en.wikipedia.org/wiki/HSL_and_HSV#From_HSI
% 
    h = f(:,:,1);
    s = f(:,:,2);
    i = f(:,:,3);
    r = zeros(size(h));
    g = zeros(size(s));
    b = zeros(size(i));
    lowindex = find(h < pi * 120 / 180);
    midindex = find(h >= pi * 120 / 180 & h < pi * 240 / 180);
    highindex = find(h >= pi * 240 / 180);
    
    b(lowindex) = i(lowindex) .* (1 - s(lowindex));
    r(lowindex) = i(lowindex) .* (1 + s(lowindex) .* cos(h(lowindex)) ./ cos(pi/3 - h(lowindex)));
    g(lowindex) = 3 * i(lowindex) - (r(lowindex) + b(lowindex));
    
    h(midindex) = h(midindex) - pi * 2 / 3;
    r(midindex) = i(midindex) .* (1 - s(midindex));
    g(midindex) = i(midindex) .* (1 + s(midindex) .* cos(h(midindex)) ./ cos(pi/3 - h(midindex)));
    b(midindex) = 3 * i(midindex) - (r(midindex) + g(midindex));
    
    h(highindex) = h(highindex) - pi * 4 / 3;
    g(highindex) = i(highindex) .* (1 - s(highindex));
    b(highindex) = i(highindex) .* (1 + s(highindex) .* cos(h(highindex)) ./ cos(pi/3 - h(highindex)));
    r(highindex) = 3 * i(highindex) - (g(highindex) + b(highindex));
    
    g = cat(3,r,g,b);
    g = im2uint8(g);
end