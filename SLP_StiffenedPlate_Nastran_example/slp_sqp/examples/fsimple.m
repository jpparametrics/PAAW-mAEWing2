function [f,g]=fsimple(x)
f = [0.1, 0.2, 0.3]*x(:);
g = [ 20 - [1, 2, 3]*x(:)
     375 - [4, 5, 6]*x(:).^2
    0.15 - [7, 8, 9]*x(:).^-3 ];
end