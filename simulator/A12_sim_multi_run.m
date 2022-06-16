%% Script to run multiple simulations and store data

% run the script

sampling_time = 0.002;
sim_time = 6;
n_samples = sim_time/sampling_time + 1;
n_intervals = 11;
coeff_list = linspace(0,2,n_intervals);
response_list = zeros(n_samples,n_intervals);
reference_list = out.simout.Data(:,3);
time = out.simout.Time;

for i = 1:length(coeff_list)
    coeff = coeff_list(i);
    out = sim('B5_simulation_paparazzi.slx');
    response_list(:,i) = out.simout.Data(:,6);
end