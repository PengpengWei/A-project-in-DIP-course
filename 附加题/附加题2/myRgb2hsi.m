function g = myRgb2hsi(f)
% 
% myRgb2hsi Convert red-green-blue colors to hue-saturation-intensity.
% MATLAB没有内置这一函数
% Ref: 
% [1] textbook P260
% [2] https://blog.csdn.net/shitao827194819/article/details/9465145
%
    f = im2double(f);
    r = double(f(:,:,1));
    g = double(f(:,:,2));
    b = double(f(:,:,3));
    
    theta = acos( 0.5 * ((r - g) + (r - b)) ./ ((r - g) .^ 2 + (r - b) .* (g - b)) .^ 0.5 + eps);
    h = theta;
    h(b <= g) = h(b <= g);
    h(b > g) = 2 * pi - h(b > g);
    s = 1 - 3 ./ (r + g + b + eps) .* min(min(r,g),b);
    i = (r + g + b) / 3;
    
    g = cat(3,h,s,i);
    g = abs(g);
    
end