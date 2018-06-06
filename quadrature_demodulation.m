function phase = quadrature_demodulation(x,f,t)
% 正交解调方法
%input x:time series, f：the frequency of x, t: the length of series
sin_series = 2*sin(2*pi*f*t);
cos_series = 2*cos(2*pi*f*t);
u = x.*sin_series;
w = x.*cos_series;
% 低通滤波
fu = fft(u);
abs_fu = abs(fu);
img_fu = imag(fu);
abs_fu(16:485) = 0;
u = ifft(abs_fu + j*img_fu);

fw = fft(w);
abs_fw = abs(fw);
img_fw = imag(fw);
abs_fw(16:485) = 0;
w = ifft(abs_fw + j*img_fw);

phase = atan2(u,w);
end