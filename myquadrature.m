function delta_phase = myquadrature(x1,x2,f,t)
% output = delta_phase
phase1 = quadrature_demodulation(x1,f,t);
phase2 = quadrature_demodulation(x2,f,t);
delta_phase_array = phase1 - phase2;
delta_phase_array(delta_phase_array > pi) = delta_phase_array(delta_phase_array > pi) - 2*pi;
delta_phase_array(delta_phase_array < -pi) = delta_phase_array(delta_phase_array < -pi) + 2*pi;

len = length(delta_phase_array);
% extract the middle segment
middle_segment = delta_phase_array(1:ceil(0.1*len));
delta_phase = sum(middle_segment)/length(middle_segment);

end