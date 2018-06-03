% Detection principle homework T2
a = 1e12;
tau = 5 * 1e-6;
f = 1e6;  % f =1Mhz
fs =  1e9; %sample frequency fs = 1Ghz
t = linspace(0,2*tau, 2*tau*fs);
s12 = sin(2*pi*f*t).*exp(-a*(t-tau).^2/2);

plot(t,s12)
% s21 is delay of s12, the time in this question
% is set as 205ns 210ns 215ns,
%draw four curve in one picture

hold on 
plot(t-205*1e-9, s12,'r') %s21_205
plot(t-210*1e-9, s12,'k') %s21_210
plot(t-215*1e-9, s12,'g') %s21_215

legend('s12','s21-205ns','s21-210ns','s21-215ns')
