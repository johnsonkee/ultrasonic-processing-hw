% Detection principle homework T1
a = 1e12;
tau = 5 * 1e-6;
f = 1e6;  % f =1Mhz
fs =  1e9; %sample frequency fs = 1Ghz
t = linspace(0,2*tau, 2*tau*fs);
s12 = sin(2*pi*f*t).*exp(-a*(t-tau).^2/2);

plot(t,s12)
title('T1');
xlabel('t/s');ylabel('mag/v');
legend('s12')

