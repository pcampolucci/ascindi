%% Doublet 

%%% 1 : Process Data from Logger

folder = '06_03_22_doublet/';

start_log = 0.1;
end_log = 0.99;

log_1 = logger(strcat(folder,'doublet_no_comp_agg'), start_log, end_log);
log_2 = logger(strcat(folder,'doublet_comp_agg'), start_log, end_log);
log_3 = logger(strcat(folder,'doublet_no_comp_agg'), start_log, end_log);
log_4 = logger(strcat(folder,'doublet_comp_agg'), start_log, end_log);
log_5 = logger(strcat(folder,'doublet_no_comp_agg'), start_log, end_log);

legend_1 = 'INDI';
legend_2 = 'ACINDI';
legend_3 = 'ACINDI+';
legend_4 = 'ASCINDI';
legend_5 = 'ASCINDI+';

% time shift between signals
shift_1 = 0;
shift_2 = 0;
shift_3 = 0;
shift_4 = 0;
shift_5 = 0;

%%% 2 : control panel on showing figures or not
show_fig1 = true;

%%% 3 : align time
log_2.time = log_2.time + shift_1;

%% P1 : Tracking Performance Overview
figure_1 = figure('Visible', show_fig1, 'Position', [100 200 1000 800]);
set(figure_1,'defaulttextinterpreter','latex');

plot(log_1.time, rad2deg(log_1.theta_cmd),'LineWidth',1.2,'Color','k'); hold on;
% plot(log_2.time, rad2deg(log_2.theta_cmd),'LineWidth',1.2,'Color','k'); hold on;
% plot(log_3.time, rad2deg(log_3.theta_cmd),'LineWidth',1.2,'Color','k'); hold on;
% plot(log_4.time, rad2deg(log_4.theta_cmd),'LineWidth',1.2,'Color','k'); hold on;
% plot(log_5.time, rad2deg(log_5.theta_cmd),'LineWidth',1.2,'Color','k'); hold on;
plot(log_1.time, rad2deg(log_1.theta_ref),'LineWidth',1.2,'Color','b',LineStyle='--'); hold on;
plot(log_1.time, rad2deg(log_1.theta_state),'LineWidth',1.2,'Color','b'); hold on;
plot(log_2.time, rad2deg(log_2.theta_ref),'LineWidth',1.2,'Color','g',LineStyle='--'); hold on;
plot(log_2.time, rad2deg(log_2.theta_state),'LineWidth',1.2,'Color','g'); hold on;
plot(log_3.time, rad2deg(log_3.theta_ref),'LineWidth',1.2,'Color','m',LineStyle='--'); hold on;
plot(log_3.time, rad2deg(log_3.theta_state),'LineWidth',1.2,'Color','m'); hold on;
plot(log_4.time, rad2deg(log_4.theta_ref),'LineWidth',1.2,'Color','r',LineStyle='--'); hold on;
plot(log_4.time, rad2deg(log_4.theta_state),'LineWidth',1.2,'Color','r'); hold on;
plot(log_5.time, rad2deg(log_5.theta_ref),'LineWidth',1.2,'Color','c',LineStyle='--'); hold on;
plot(log_5.time, rad2deg(log_5.theta_state),'LineWidth',1.2,'Color','c'); hold on;
grid minor;
legend('cmd','ref',legend_1,'ref',legend_2,'ref',legend_3,'ref',legend_4,'ref',legend_5,'Interpreter','latex');
xlabel("time [sec]");
ylabel("$$\theta$$ [deg]");
