%% Validation Inner Loop
% we compare flights with inner loop compensation with conventional INDI
% controller. We look for the tracking performance of thereference
% trajectory generated in the inner loop, therefore the attitude and higher
% derivatives tracking. 

%%% 1 : Process Data from Logger

folder = '04_05_22/';

start_log = 0.1;
end_log = 0.28;

log_1 = logger(strcat(folder,'drag_30_8'), start_log, end_log);

%%% 2 : control panel on showing figures or not

show_fig1 = true;
show_fig2 = true;
show_fig3 = true;

%%% 3 : filtering settings
f_sample = 200;
t_sample = 1/f_sample;

% get signals data
mean_act = mean(log_1.act_state_1);

% subtract mean to get pure noise
log_1.act_state_1 = log_1.act_state_1 - mean_act;

psd_act = periodogram(log_1.act_state_1,'psd');
mean_psd_act = mean(psd_act);

psd_q = periodogram(log_1.q_state,'psd');
mean_psd_q = mean(psd_q);

%% P1 : Plot the tracking performance of the pitching motion

figure_1 = figure('Visible', show_fig1, 'Position', [100 200 1000 800]);
set(figure_1,'defaulttextinterpreter','latex');

tiledlayout(3,1);

ax1 = nexttile;
plot(log_1.time, log_1.act_state_1,'LineWidth',1.5,'Color','b');
grid minor;
legend('a','Interpreter','latex');
xlabel("time [sec]");
ylabel("RPM [-]");
title("Actuator Noise");

ax2 = nexttile;
plot(log_1.time, log_1.q_state,'LineWidth',1.5,'Color','b');
grid minor;
legend('a','Interpreter','latex');
xlabel("time [sec]");
ylabel("$$q$$ [rad/sec]");
title("Pitch Velocity");

ax3 = nexttile;
plot(log_1.time, log_1.xd_state,'LineWidth',1.5,'Color','b');
grid minor;
legend('a','Interpreter','latex');
xlabel("time [sec]");
ylabel("$$\Delta \phi$$ [rad]");
title("Height");

linkaxes([ax1,ax2,ax3], 'x');






