% T6
% T6.3
clear 
a = 1e12;
tau = 5 * 1e-6;
f = 1e6;  % f =1Mhz
fs =  50 * 1e6; %sample frequency fs = 50Mhz
t = linspace(0,2*tau, 2*tau*fs);
s12 = sin(2*pi*f*t).*exp(-a*(t-tau).^2/2);

%ni liu
dt1 = 205*1e-9;
t1 = t-dt1;
% s21 is delay of s12, the time in this question
% is set as 205ns 210ns 215ns,
s21_1 = sin(2*pi*f*t1).*exp(-a*(t1-tau).^2/2);

%tip:使用myhilbert方法时，是使用hilbert TF方法计算时差
%使用myquadrature方法时，是使用正交解调法，
% delta_phase = myhilbert(s12, s21_1);
delta_phase = myquadrature(s12,s21_1,f,t);
delta_time = delta_phase/(2*pi*f)

%% T6.4
% with some noise
% insert rand signal
variances = linspace(0,0.5,1000);
% the second row of variances save the delta_t
for i = 1:length(variances)

    rand_signal = randn(size(s12))*sqrt(variances(1,i));
    
    % interpolate the s21_1, s21_2 ,s21_3
    % interpolation internal is one ns
    new_t = linspace(0,2*tau,2*tau*1e9);
    tempSeries = {s12 + rand_signal, s21_1 + rand_signal};
    %tip:使用myhilbert方法时，是使用hilbert TF方法计算时差
    %使用myquadrature方法时，是使用正交解调法，
%     delta_phase = myhilbert(tempSeries{1},tempSeries{2});
    delta_phase = myquadrature(tempSeries{1},tempSeries{2},f,t);
    delta_time = delta_phase/(2*pi*f);
    variances(2,i) = delta_time;
end
%paint
plot(variances(1,:),variances(2,:))
xlabel('variances of the random noise');
ylabel('interval of s12 and s21');
title('T6.4 使用正交解调方法');