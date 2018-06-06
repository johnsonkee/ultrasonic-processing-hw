function [delta_phase,delta_phase_array] = myhilbert(x1, x2)

%input x1, x2 are time series
% output delta_phase is the delay phase of x1 and x2
% if it is + ,x1 is preceeding, if it is -, x1 si delayed
hilbert1 = hilbert(x1);
hilbert2 = hilbert(x2);
r1 = atan2(imag(hilbert1),x1);
r2 = atan2(imag(hilbert2),x2);

delta_phase_array = r1 - r2;
delta_phase_array(delta_phase_array > pi) = delta_phase_array(delta_phase_array > pi) - 2*pi;
delta_phase_array(delta_phase_array < -pi) = delta_phase_array(delta_phase_array < -pi) + 2*pi;

len = length(delta_phase_array);
% extract the middle segment
middle_segment = delta_phase_array(ceil(0.3*len):ceil(0.7*len));
delta_phase = sum(middle_segment)/length(middle_segment);

end