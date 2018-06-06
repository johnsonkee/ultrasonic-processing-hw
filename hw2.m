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
dt1 = 205*1e-9;
dt2 = 210*1e-9;
dt3 = 215*1e-9;
t1 = t-dt1;
t2 = t-dt2;
t3 = t-dt3;
s21_1 = sin(2*pi*f*t1).*exp(-a*(t1-tau).^2/2);
s21_2 = sin(2*pi*f*t2).*exp(-a*(t2-tau).^2/2);
s21_3 = sin(2*pi*f*t3).*exp(-a*(t3-tau).^2/2);

hold on 
plot(t, s21_1,'r') %s21_205
plot(t, s21_2,'k') %s21_210
plot(t, s21_3,'g') %s21_215

title('T2');
xlabel('t/s');ylabel('mag/v');
legend('s12','s21-205ns','s21-210ns','s21-215ns')
