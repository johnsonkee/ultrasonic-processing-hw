function y = hw4()
% Detection principle homework T4
a = 1e12;
tau = 5 * 1e-6;
f = 1e6;  % f =1Mhz
fs =  1e9; %sample frequency fs = 1Ghz
t = linspace(0,2*tau, 2*tau*fs);
s12 = sin(2*pi*f*t).*exp(-a*(t-tau).^2/2);
dt1 = 205*1e-9;
dt2 = 210*1e-9;
dt3 = 215*1e-9;
t1 = t-dt1;
t2 = t-dt2;
t3 = t-dt3;

% s21 is delay of s12, the time in this question
% is set as 205ns 210ns 215ns,
s21_1 = sin(2*pi*f*t1).*exp(-a*(t1-tau).^2/2);
s21_2 = sin(2*pi*f*t2).*exp(-a*(t2-tau).^2/2);
s21_3 = sin(2*pi*f*t3).*exp(-a*(t3-tau).^2/2);

% insert rand signal
variances = linspace(0,0.1,1000);
for i = 1:length(variances)
    
    rand_signal = randn(size(s12))*sqrt(variances(1,i));
    [c, lags]=xcorr(s12+rand_signal,s21_1+rand_signal); 
    [c_max, t_max]=max(c);
    N=t_max-length(s12); 
    variances(2,i) = N/fs;
end
plot(variances(1,:),variances(2,:))
xlabel('variances of the random noise');
ylabel('interval of s12 and s21');
title('T4');
end





