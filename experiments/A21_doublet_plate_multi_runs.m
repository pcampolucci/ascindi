%% Doublet 

%%% 1 : Process Data from Logger

folder = '05_30_22_doublet_comp/';

start_log = 0.1;
end_log = 0.9;

log_1 = logger(strcat(folder,'doublet_no_comp_1'), start_log, end_log);
log_2 = logger(strcat(folder,'doublet_no_comp_2'), start_log, end_log);
log_3 = logger(strcat(folder,'doublet_no_comp_3'), start_log, end_log);
log_4 = logger(strcat(folder,'doublet_comp_1'), start_log, end_log);
log_5 = logger(strcat(folder,'doublet_comp_2'), start_log, end_log);
log_6 = logger(strcat(folder,'doublet_comp_3'), start_log, end_log);

legend_1 = 'No Compensation 1';
legend_2 = 'No Compensation 2';
legend_3 = 'No Compensation 3';
legend_4 = 'Compensation 1';
legend_5 = 'Compensation 2';
legend_6 = 'Compensation 3';

% time shift between signals
shift_comp_14 = -17.9552;
shift_comp_25 = -26.121;
shift_comp_36 = -65.831;

%%% 2 : control panel on showing figures or not

show_fig1 = true;

%%% 3 : align time
log_4.time = log_4.time + shift_comp_14;

log_2.time = log_2.time - 70.6723;
log_5.time = log_5.time - 70.6723 + shift_comp_25;

log_3.time = log_3.time - 246.2283;
log_6.time = log_6.time - 246.2283 + shift_comp_36;

%% P1 : Tracking Performance Overview
figure_1 = figure('Visible', show_fig1, 'Position', [100 200 1000 800]);
set(figure_1,'defaulttextinterpreter','latex');

plot(log_1.time, rad2deg(log_1.theta_cmd),'LineWidth',1.2,'Color','k'); hold on;
% plot(log_2.time, rad2deg(log_2.theta_cmd),'LineWidth',1.2,'Color','k'); hold on;
% plot(log_3.time, rad2deg(log_3.theta_cmd),'LineWidth',1.2,'Color','k'); hold on;
% plot(log_4.time, rad2deg(log_4.theta_cmd),'LineWidth',1.2,'Color','k'); hold on;
% plot(log_5.time, rad2deg(log_5.theta_cmd),'LineWidth',1.2,'Color','k'); hold on;
% plot(log_6.time, rad2deg(log_6.theta_cmd),'LineWidth',1.2,'Color','k'); hold on;
% comp files
plot(log_1.time, rad2deg(log_1.theta_state),'LineWidth',1.2,'Color','b','LineStyle','-'); hold on;
plot(log_2.time, rad2deg(log_2.theta_state),'LineWidth',1.2,'Color','b','LineStyle','--'); hold on;
plot(log_3.time, rad2deg(log_3.theta_state),'LineWidth',1.2,'Color','b','LineStyle','-.'); hold on;
plot(log_4.time, rad2deg(log_4.theta_state),'LineWidth',1.2,'Color','g','LineStyle','-'); hold on;
plot(log_5.time, rad2deg(log_5.theta_state),'LineWidth',1.2,'Color','g','LineStyle','--'); hold on;
plot(log_6.time, rad2deg(log_6.theta_state),'LineWidth',1.2,'Color','g','LineStyle','-.'); hold on;
grid minor;
legend('cmd',legend_1,legend_2,legend_3,legend_4,legend_5,legend_6,'Interpreter','latex');
xlabel("time [sec]");
ylabel("$$\theta$$ [deg]");
title("Pitch Doublet Tracking");

