function [f,g] = fBSS_example(x)%% Example 9.4.4 pg 509, Nonlinear Programming Theory and Applications, Bazaraa, Sherali, Shettyf = (x(1) - 2).^4 + (x(1) - 2.*x(2)).^2;g = x(1).^2 - x(2);end