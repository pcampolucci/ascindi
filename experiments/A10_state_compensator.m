%% Validation Inner Loop
% we compare flights with inner loop compensation with conventional INDI
% controller. We look for the tracking performance of thereference
% trajectory generated in the inner loop, therefore the attitude and higher
% derivatives tracking. 

%%% 1 : Process Data from Logger

folder = '05_16_22/';

start_log = 0.05;
end_log = 0.99;

log_1 = logger(strcat(folder,'doublet_indi_20'), start_log, end_log);
log_2 = logger(strcat(folder,'doublet_asc_20'), start_log, end_log);

legend_1 = 'INDI';
legend_2 = 'ASC';

% time shift between signals
shift_20 = 0;
shift_30 = 2.547;
shift_50_sim = -6.542;
shift_50 = 63.4648;
shift_50_no_filt = 0;
shift_50_sim_no_filt = -16.2143;
shift_comp = 0;

%%% 2 : control panel on showing figures or not

show_fig1 = true;
show_fig2 = true;
show_fig3 = true;

%%% 3 : filtering settings
f_sample = 1/0.002;

%%% 4 : align time
log_1.time = log_1.time + shift_20;

%% P1 : Plot the tracking performance of the pitching motion

figure_1 = figure('Visible', show_fig1, 'Position', [100 200 1000 800]);
set(figure_1,'defaulttextinterpreter','latex');

tiledlayout(2,1);

% Pitch Motion Tracking

indi_theta_err =  abs(log_1.theta_state - log_1.theta_ref);
asc_theta_err =  abs(log_2.theta_state - log_2.theta_ref);

ax1 = nexttile;
plot(log_1.time, rad2deg(indi_theta_err),'LineWidth',1.5,'Color','b'); hold on;
plot(log_2.time, rad2deg(asc_theta_err),'LineWidth',1.5,'Color','r');
grid minor;
legend(legend_1,legend_2,'Interpreter','latex');
xlabel("time [sec]");
ylabel("$$\Delta \theta$$ [rad]");
title("Theta Error");

indi_q_err =  abs(log_1.q_state - log_1.q_ref);
asc_q_err =  abs(log_2.q_state - log_2.q_ref);

ax2 = nexttile;
plot(log_1.time, rad2deg(indi_q_err),'LineWidth',1.5,'Color','b'); hold on;
plot(log_2.time, rad2deg(asc_q_err),'LineWidth',1.5,'Color','r');
grid minor;
legend(legend_1,legend_2,'Interpreter','latex');
xlabel("time [sec]");
ylabel("$$\Delta q$$ [rad/sec]");
title("Pitch Rate Tracking");

linkaxes([ax1,ax2], 'x');