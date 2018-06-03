% Detection principle homework T5
clear 
a = 1e12;
tau = 5 * 1e-6;
f = 1e6;  % f =1Mhz
fs =  50 * 1e6; %sample frequency fs = 1Ghz
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

s22_1 = sin(2*pi*f*t1).*exp(-a*(t1-tau).^2/2);
s22_2 = sin(2*pi*f*t2).*exp(-a*(t2-tau).^2/2);
s22_3 = sin(2*pi*f*t3).*exp(-a*(t3-tau).^2/2);

% insert rand signal
varience = [0.0001,0.0003,0.0007,0.001,0.003,0.007,0.01,0.03,0.05,0.07,0.09,...
    0.1,0.3,0.5,0.6];

for i = 1:length(varience)
    
    rand_signal = randn(size(s12))*sqrt(varience(i));
    [c, lags]=xcorr(s12+rand_signal,s22_1+rand_signal); 
    [c_max, t_max]=max(c);
    N=t_max-length(s12); 
    varience(2,i) = N/fs;
end

plot(t,s12)





