% Detection principle homework T5
% T5.1
clear 
a = 1e12;
tau = 5 * 1e-6;
f = 1e6;  % f =1Mhz
fs =  50 * 1e6; %sample frequency fs = 50Mhz
t = linspace(0,2*tau, 2*tau*fs);
s12 = sin(2*pi*f*t).*exp(-a*(t-tau).^2/2);
plot(t,s12);
title('T5');
xlabel('t/s');ylabel('s12');
%%
% T5.2
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
hold on 
plot(t, s21_1,'r') %s21_205
plot(t, s21_2,'k') %s21_210
plot(t, s21_3,'g') %s21_215

legend('s12','s21-205ns','s21-210ns','s21-215ns')

%% 
%T5.3

delaySeries = {s21_1, s21_2, s21_3};
for i = 1:3
    
    [c lags]=xcorr(s12,delaySeries{i}); %c返回各点偏移相乘累加的值
    [c_max t_max]=max(c);
    N=t_max-length(s12); 
    delayTime(i) = N/fs;
end
fprintf('the internal of s12 and s21:,%ld\n',delayTime(1));
%% 
% updatedd T5.3
% interpolate the s21_1, s21_2 ,s21_3
% interpolation internal is 1ns
new_t = linspace(0,2*tau,2*tau*1e9);
tempSeries = {s12,s21_1, s21_2, s21_3};
delaySeries = {0,0,0,0};
for i = 1:length(tempSeries)
    delaySeries{i} = interp1(t,tempSeries{i},new_t,'PCHIP');
end
% delaySeries{1} is the result of interpolation of s12
% and the later 3 element is result of s21_1, s21_2, s21_3
for i = 1:3
    [c,lags]=xcorr(delaySeries{1},delaySeries{i+1}); 
    % r = xcorr(x,y) 
    % c returns the cross-correlation of two discrete-time sequences, x and y
    % returns a vector with the lags at which the correlations are computed.
    [c_max,t_max]=max(c);
    N=t_max-length(delaySeries{1}); 
    delayTime(i) = N/1e9;
end
fprintf('the internal of s12 and s21:,%ld\n',delayTime(1));
%%
% T5.4
% insert rand signal
variances = linspace(0,0.1,1000);
% the second row of variances save the delta_t
for i = 1:length(variances)

    rand_signal = randn(size(s12))*sqrt(variances(1,i));
    
    % interpolate the s21_1, s21_2 ,s21_3
    % interpolation internal is one ns
    new_t = linspace(0,2*tau,2*tau*1e9);
    tempSeries = {s12 + rand_signal, s21_1 + rand_signal};
    delaySeries = {0,0};
    for temp_i = 1:length(tempSeries)
        delaySeries{temp_i} = interp1(t,tempSeries{temp_i},new_t,'spline');
    end
    
    % delaySeries{1,2} is equel to s12 and s21_1 while they contain noise
    [c, lags]=xcorr(delaySeries{1},delaySeries{2}); 
    [c_max, t_max]=max(c);
    N=t_max-length(delaySeries{1}); 
    variances(2,i) = N/1e9;
end
%paint
plot(variances(1,:),variances(2,:))
xlabel('variances of the random noise');
ylabel('interval of s12 and s21');
title('T5.4');
