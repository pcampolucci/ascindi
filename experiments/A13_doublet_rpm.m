%% Validation Inner Loop

%%% 1 : Process Data from Logger

folder = '05_17_22_rpm_filt/';

start_log = 0.05;
end_log = 0.99;

log_1 = logger(strcat(folder,'doublet_50_no_rpm'), start_log, end_log);
log_2 = logger(strcat(folder,'doublet_50_rpm'), start_log, end_log);

legend_1 = 'No RPM';
legend_2 = 'RPM';


% time shift between signals
shift_rpm = 3.7373;

%%% 2 : control panel on showing figures or not

show_fig1 = true;
show_fig4 = true;
show_fig7 = true;
show_fig9 = true;

%%% 3 : filtering settings
f_sample = 1/0.002;

%%% 4 : align time
log_1.time = log_1.time + shift_rpm;

%% P1 : Compare the reference trajectory tracking

figure_1 = figure('Visible', show_fig1, 'Position', [100 200 1000 800]);
set(figure_1,'defaulttextinterpreter','latex');

plot(log_1.time, rad2deg(log_1.theta_cmd),'LineWidth',0.8,'Color','k'); hold on;
plot(log_1.time, rad2deg(log_1.theta_ref),'LineWidth',0.8,'Color','b',LineStyle='--'); hold on;
plot(log_1.time, rad2deg(log_1.theta_state),'LineWidth',0.8,'Color','b'); hold on;
plot(log_2.time, rad2deg(log_2.theta_ref),'LineWidth',0.8,'Color','g',LineStyle='--'); hold on;
plot(log_2.time, rad2deg(log_2.theta_state),'LineWidth',0.8,'Color','g');
grid minor;
legend('cmd','ref',legend_1,'ref',legend_2,'Interpreter','latex');
xlabel("time [sec]");
ylabel("$$\theta$$ [deg]");
title("Pitch Doublet Tracking");

%% P4 : Complementary filters state estimation

figure_4 = figure('Visible', show_fig4, 'Position', [100 200 1000 800]);
set(figure_4,'defaulttextinterpreter','latex');

tiledlayout(2,1);

ax1 = nexttile;
plot(log_1.time, rad2deg(log_1.qd_ref),'LineWidth',1.5,'Color','g'); hold on;
plot(log_1.time, rad2deg(log_1.qd_state_f),'LineWidth',1.2,'Color','b','LineStyle','--'); hold on;
plot(log_1.time, rad2deg(log_1.qd_estimated),'LineWidth',1.2,'Color','r'); hold on;
plot(log_1.time, rad2deg(log_1.qd_estimated_f ),'LineWidth',1.2,'Color','r','LineStyle','--'); hold on;
plot(log_1.time, rad2deg(log_1.qd_state_f_undelayed ),'LineWidth',1.2,'Color','b');
grid minor;
legend('ref','state filt','estimated','estimated filt','undelayed','Interpreter','latex');
xlabel("time [sec]");
ylabel("$$q_d$$ [deg/sec^2]");
title("Complementary Filter Performance - ",legend_1);

ax2 = nexttile;
plot(log_2.time, rad2deg(log_2.qd_ref),'LineWidth',1.5,'Color','g'); hold on;
plot(log_2.time, rad2deg(log_2.qd_state_f),'LineWidth',1.2,'Color','b','LineStyle','--'); hold on;
plot(log_2.time, rad2deg(log_2.qd_estimated),'LineWidth',1.2,'Color','r'); hold on;
plot(log_2.time, rad2deg(log_2.qd_estimated_f ),'LineWidth',1.2,'Color','r','LineStyle','--'); hold on;
plot(log_2.time, rad2deg(log_2.qd_state_f_undelayed ),'LineWidth',1.2,'Color','b');
grid minor;
legend('ref','state filt','estimated','estimated filt','undelayed','Interpreter','latex');
xlabel("time [sec]");
ylabel("$$q_d$$ [deg/sec^2]");
title("Complementary Filter Performance - ",legend_2);

linkaxes([ax1,ax2], 'x');

%% P7 : Looking at actuators

figure_7 = figure('Visible', show_fig7, 'Position', [100 200 1000 800]);
set(figure_7,'defaulttextinterpreter','latex');

tiledlayout(2,1);

ax1 = nexttile;
plot(log_1.time, log_1.act_cmd_1,'LineWidth',1.2,'Color','b','LineStyle','--'); hold on;
plot(log_1.time, log_1.act_state_1,'LineWidth',1.2,'Color','b'); hold on;
plot(log_1.time, log_1.act_cmd_2,'LineWidth',1.2,'Color','g','LineStyle','--'); hold on;
plot(log_1.time, log_1.act_state_2,'LineWidth',1.2,'Color','g'); hold on;
plot(log_1.time, log_1.act_cmd_3,'LineWidth',1.2,'Color','c','LineStyle','--'); hold on;
plot(log_1.time, log_1.act_state_3,'LineWidth',1.2,'Color','c'); hold on;
plot(log_1.time, log_1.act_cmd_4,'LineWidth',1.2,'Color','r','LineStyle','--'); hold on;
plot(log_1.time, log_1.act_state_4,'LineWidth',1.2,'Color','r');
grid minor;
legend('cmd 1','state 1','cmd 2','state 2','cmd 3','state 3','cmd 4','state 4','Interpreter','latex');
xlabel("time [sec]");
ylabel("RPM");
title("Actuator States - ", legend_1);

ax2 = nexttile;
plot(log_2.time, log_2.act_cmd_1,'LineWidth',1.2,'Color','b','LineStyle','--'); hold on;
plot(log_2.time, log_2.act_state_1,'LineWidth',1.2,'Color','b'); hold on;
plot(log_2.time, log_2.act_cmd_2,'LineWidth',1.2,'Color','g','LineStyle','--'); hold on;
plot(log_2.time, log_2.act_state_2,'LineWidth',1.2,'Color','g'); hold on;
plot(log_2.time, log_2.act_cmd_3,'LineWidth',1.2,'Color','c','LineStyle','--'); hold on;
plot(log_2.time, log_2.act_state_3,'LineWidth',1.2,'Color','c'); hold on;
plot(log_2.time, log_2.act_cmd_4,'LineWidth',1.2,'Color','r','LineStyle','--'); hold on;
plot(log_2.time, log_2.act_state_4,'LineWidth',1.2,'Color','r');
grid minor;
legend('cmd 1','state 1','cmd 2','state 2','cmd 3','state 3','cmd 4','state 4','Interpreter','latex');
xlabel("time [sec]");
ylabel("RPM");
title("Actuator States - ", legend_2);

linkaxes([ax1,ax2], 'x');

%% P9 : Error Terms for Pseudo Control Input

figure_9 = figure('Visible', show_fig9, 'Position', [100 200 1000 800]);
set(figure_9,'defaulttextinterpreter','latex');

tiledlayout(2,1);

ax1 = nexttile;
plot(log_1.time, log_1.qdd_ref,'LineWidth',1.0,'Color','k','LineStyle','--'); hold on;
plot(log_1.time, log_1.theta_att_err,'LineWidth',1.2,'Color','b'); hold on;
plot(log_1.time, log_1.q_rate_err,'LineWidth',1.2,'Color','r'); hold on;
plot(log_1.time, log_1.q_acc_err,'LineWidth',1.2,'Color','g'); hold on;
grid minor;
legend('ref','error att','error rate','error acc','Interpreter','latex');
xlabel("time [sec]");
ylabel("acceleration");
title("Error Terms Sim - ", legend_1);

ax2 = nexttile;
plot(log_2.time, log_2.qdd_ref,'LineWidth',1.0,'Color','k','LineStyle','--'); hold on;
plot(log_2.time, log_2.theta_att_err,'LineWidth',1.2,'Color','b'); hold on;
plot(log_2.time, log_2.q_rate_err,'LineWidth',1.2,'Color','r'); hold on;
plot(log_2.time, log_2.q_acc_err,'LineWidth',1.2,'Color','g'); hold on;
grid minor;
legend('ref','error att','error rate','error acc','Interpreter','latex');
xlabel("time [sec]");
ylabel("acceleration");
title("Error Terms Sim - ", legend_2);

linkaxes([ax1,ax2], 'x');
