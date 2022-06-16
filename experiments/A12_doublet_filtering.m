%% Validation Inner Loop

%%% 1 : Process Data from Logger

folder = '05_17_22_rpm_filt/';

start_log = 0.05;
end_log = 0.99;

log_1 = logger(strcat(folder,'doublet_50_no_rpm'), start_log, end_log);
log_2 = logger(strcat(folder,'doublet_50_filt_10'), start_log, end_log);
log_3 = logger(strcat(folder,'doublet_50_filt_20'), start_log, end_log);
log_4 = logger(strcat(folder,'doublet_50_filt_30'), start_log, end_log);
log_5 = logger(strcat(folder,'doublet_50_filt_40'), start_log, end_log);
log_6 = logger(strcat(folder,'doublet_50_filt_50'), start_log, end_log);

legend_1 = 'No Filt';
legend_2 = 'omega: 10';
legend_3 = 'omega: 20';
legend_4 = 'omega: 30';
legend_5 = 'omega: 40';
legend_6 = 'omega: 50';


% time shift between signals
shift_no = 3.7334;
shift_10 = -34.7725;
shift_20 = 8.7588;
shift_30 = -215.3679;
shift_40 = -110.0069;
shift_50 = 7.9971;

%%% 2 : control panel on showing figures or not

show_fig1 = true;
show_fig4 = true;
show_fig7 = true;
show_fig9 = true;

%%% 3 : align time
log_1.time = log_1.time + shift_no;
log_2.time = log_2.time + shift_10;
log_3.time = log_3.time + shift_20;
log_4.time = log_4.time + shift_30;
log_5.time = log_5.time + shift_40;
log_6.time = log_6.time + shift_50;

%% P1 : Compare the reference trajectory tracking

figure_1 = figure('Visible', show_fig1, 'Position', [100 200 1000 800]);
set(figure_1,'defaulttextinterpreter','latex');

plot(log_1.time, rad2deg(log_1.theta_cmd),'LineWidth',0.8,'Color','k'); hold on;
% inf filt
plot(log_1.time, rad2deg(log_1.theta_ref),'LineWidth',0.8,'Color','b',LineStyle='--'); hold on;
plot(log_1.time, rad2deg(log_1.theta_state),'LineWidth',0.8,'Color','b'); hold on;
% 10 filt
plot(log_2.time, rad2deg(log_2.theta_ref),'LineWidth',0.8,'Color','g',LineStyle='--'); hold on;
plot(log_2.time, rad2deg(log_2.theta_state),'LineWidth',0.8,'Color','g'); hold on;
% 20 filt
plot(log_3.time, rad2deg(log_3.theta_ref),'LineWidth',0.8,'Color','r',LineStyle='--'); hold on;
plot(log_3.time, rad2deg(log_3.theta_state),'LineWidth',0.8,'Color','r'); hold on;
% 30 filt
plot(log_4.time, rad2deg(log_4.theta_ref),'LineWidth',0.8,'Color','c',LineStyle='--'); hold on;
plot(log_4.time, rad2deg(log_4.theta_state),'LineWidth',0.8,'Color','c'); hold on;
% 40 filt
plot(log_5.time, rad2deg(log_5.theta_ref),'LineWidth',0.8,'Color','m',LineStyle='--'); hold on;
plot(log_5.time, rad2deg(log_5.theta_state),'LineWidth',0.8,'Color','m'); hold on;
% 50 filt
plot(log_6.time, rad2deg(log_6.theta_ref),'LineWidth',0.8,'Color','y',LineStyle='--'); hold on;
plot(log_6.time, rad2deg(log_6.theta_state),'LineWidth',0.8,'Color','y'); hold on;
grid minor;
legend('cmd','ref',legend_1,'ref',legend_2,'ref',legend_3,'ref',legend_4,'ref',legend_5,'ref',legend_6,'Interpreter','latex');
xlabel("time [sec]");
ylabel("$$\theta$$ [deg]");
title("Pitch Doublet Tracking");

%% P4 : Complementary filters state estimation

figure_4 = figure('Visible', show_fig4, 'Position', [100 200 1000 800]);
set(figure_4,'defaulttextinterpreter','latex');

tiledlayout(3,2);

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

ax3 = nexttile;
plot(log_3.time, rad2deg(log_3.qd_ref),'LineWidth',1.5,'Color','g'); hold on;
plot(log_3.time, rad2deg(log_3.qd_state_f),'LineWidth',1.2,'Color','b','LineStyle','--'); hold on;
plot(log_3.time, rad2deg(log_3.qd_estimated),'LineWidth',1.2,'Color','r'); hold on;
plot(log_3.time, rad2deg(log_3.qd_estimated_f ),'LineWidth',1.2,'Color','r','LineStyle','--'); hold on;
plot(log_3.time, rad2deg(log_3.qd_state_f_undelayed ),'LineWidth',1.2,'Color','b');
grid minor;
legend('ref','state filt','estimated','estimated filt','undelayed','Interpreter','latex');
xlabel("time [sec]");
ylabel("$$q_d$$ [deg/sec^2]");
title("Complementary Filter Performance - ",legend_3);

ax4 = nexttile;
plot(log_4.time, rad2deg(log_4.qd_ref),'LineWidth',1.5,'Color','g'); hold on;
plot(log_4.time, rad2deg(log_4.qd_state_f),'LineWidth',1.2,'Color','b','LineStyle','--'); hold on;
plot(log_4.time, rad2deg(log_4.qd_estimated),'LineWidth',1.2,'Color','r'); hold on;
plot(log_4.time, rad2deg(log_4.qd_estimated_f ),'LineWidth',1.2,'Color','r','LineStyle','--'); hold on;
plot(log_4.time, rad2deg(log_4.qd_state_f_undelayed ),'LineWidth',1.2,'Color','b');
grid minor;
legend('ref','state filt','estimated','estimated filt','undelayed','Interpreter','latex');
xlabel("time [sec]");
ylabel("$$q_d$$ [deg/sec^2]");
title("Complementary Filter Performance - ",legend_4);

ax5 = nexttile;
plot(log_5.time, rad2deg(log_5.qd_ref),'LineWidth',1.5,'Color','g'); hold on;
plot(log_5.time, rad2deg(log_5.qd_state_f),'LineWidth',1.2,'Color','b','LineStyle','--'); hold on;
plot(log_5.time, rad2deg(log_5.qd_estimated),'LineWidth',1.2,'Color','r'); hold on;
plot(log_5.time, rad2deg(log_5.qd_estimated_f ),'LineWidth',1.2,'Color','r','LineStyle','--'); hold on;
plot(log_5.time, rad2deg(log_5.qd_state_f_undelayed ),'LineWidth',1.2,'Color','b');
grid minor;
legend('ref','state filt','estimated','estimated filt','undelayed','Interpreter','latex');
xlabel("time [sec]");
ylabel("$$q_d$$ [deg/sec^2]");
title("Complementary Filter Performance - ",legend_5);

ax6 = nexttile;
plot(log_6.time, rad2deg(log_6.qd_ref),'LineWidth',1.5,'Color','g'); hold on;
plot(log_6.time, rad2deg(log_6.qd_state_f),'LineWidth',1.2,'Color','b','LineStyle','--'); hold on;
plot(log_6.time, rad2deg(log_6.qd_estimated),'LineWidth',1.2,'Color','r'); hold on;
plot(log_6.time, rad2deg(log_6.qd_estimated_f ),'LineWidth',1.2,'Color','r','LineStyle','--'); hold on;
plot(log_6.time, rad2deg(log_6.qd_state_f_undelayed ),'LineWidth',1.2,'Color','b');
grid minor;
legend('ref','state filt','estimated','estimated filt','undelayed','Interpreter','latex');
xlabel("time [sec]");
ylabel("$$q_d$$ [deg/sec^2]");
title("Complementary Filter Performance - ",legend_6);

linkaxes([ax1,ax2,ax3,ax4,ax5,ax6], 'x');

%% P7 : Looking at actuators

figure_7 = figure('Visible', show_fig7, 'Position', [100 200 1000 800]);
set(figure_7,'defaulttextinterpreter','latex');

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

ax3 = nexttile;
plot(log_3.time, log_3.act_cmd_1,'LineWidth',1.2,'Color','b','LineStyle','--'); hold on;
plot(log_3.time, log_3.act_state_1,'LineWidth',1.2,'Color','b'); hold on;
plot(log_3.time, log_3.act_cmd_2,'LineWidth',1.2,'Color','g','LineStyle','--'); hold on;
plot(log_3.time, log_3.act_state_2,'LineWidth',1.2,'Color','g'); hold on;
plot(log_3.time, log_3.act_cmd_3,'LineWidth',1.2,'Color','c','LineStyle','--'); hold on;
plot(log_3.time, log_3.act_state_3,'LineWidth',1.2,'Color','c'); hold on;
plot(log_3.time, log_3.act_cmd_4,'LineWidth',1.2,'Color','r','LineStyle','--'); hold on;
plot(log_3.time, log_3.act_state_4,'LineWidth',1.2,'Color','r');
grid minor;
legend('cmd 1','state 1','cmd 2','state 2','cmd 3','state 3','cmd 4','state 4','Interpreter','latex');
xlabel("time [sec]");
ylabel("RPM");
title("Actuator States - ", legend_3);

ax4 = nexttile;
plot(log_4.time, log_4.act_cmd_1,'LineWidth',1.2,'Color','b','LineStyle','--'); hold on;
plot(log_4.time, log_4.act_state_1,'LineWidth',1.2,'Color','b'); hold on;
plot(log_4.time, log_4.act_cmd_2,'LineWidth',1.2,'Color','g','LineStyle','--'); hold on;
plot(log_4.time, log_4.act_state_2,'LineWidth',1.2,'Color','g'); hold on;
plot(log_4.time, log_4.act_cmd_3,'LineWidth',1.2,'Color','c','LineStyle','--'); hold on;
plot(log_4.time, log_4.act_state_3,'LineWidth',1.2,'Color','c'); hold on;
plot(log_4.time, log_4.act_cmd_4,'LineWidth',1.2,'Color','r','LineStyle','--'); hold on;
plot(log_4.time, log_4.act_state_4,'LineWidth',1.2,'Color','r');
grid minor;
legend('cmd 1','state 1','cmd 2','state 2','cmd 3','state 3','cmd 4','state 4','Interpreter','latex');
xlabel("time [sec]");
ylabel("RPM");
title("Actuator States - ", legend_4);

ax5 = nexttile;
plot(log_5.time, log_5.act_cmd_1,'LineWidth',1.2,'Color','b','LineStyle','--'); hold on;
plot(log_5.time, log_5.act_state_1,'LineWidth',1.2,'Color','b'); hold on;
plot(log_5.time, log_5.act_cmd_2,'LineWidth',1.2,'Color','g','LineStyle','--'); hold on;
plot(log_5.time, log_5.act_state_2,'LineWidth',1.2,'Color','g'); hold on;
plot(log_5.time, log_5.act_cmd_3,'LineWidth',1.2,'Color','c','LineStyle','--'); hold on;
plot(log_5.time, log_5.act_state_3,'LineWidth',1.2,'Color','c'); hold on;
plot(log_5.time, log_5.act_cmd_4,'LineWidth',1.2,'Color','r','LineStyle','--'); hold on;
plot(log_5.time, log_5.act_state_4,'LineWidth',1.2,'Color','r');
grid minor;
legend('cmd 1','state 1','cmd 2','state 2','cmd 3','state 3','cmd 4','state 4','Interpreter','latex');
xlabel("time [sec]");
ylabel("RPM");
title("Actuator States - ", legend_5);

ax6 = nexttile;
plot(log_6.time, log_6.act_cmd_1,'LineWidth',1.2,'Color','b','LineStyle','--'); hold on;
plot(log_6.time, log_6.act_state_1,'LineWidth',1.2,'Color','b'); hold on;
plot(log_6.time, log_6.act_cmd_2,'LineWidth',1.2,'Color','g','LineStyle','--'); hold on;
plot(log_6.time, log_6.act_state_2,'LineWidth',1.2,'Color','g'); hold on;
plot(log_6.time, log_6.act_cmd_3,'LineWidth',1.2,'Color','c','LineStyle','--'); hold on;
plot(log_6.time, log_6.act_state_3,'LineWidth',1.2,'Color','c'); hold on;
plot(log_6.time, log_6.act_cmd_4,'LineWidth',1.2,'Color','r','LineStyle','--'); hold on;
plot(log_6.time, log_6.act_state_4,'LineWidth',1.2,'Color','r');
grid minor;
legend('cmd 1','state 1','cmd 2','state 2','cmd 3','state 3','cmd 4','state 4','Interpreter','latex');
xlabel("time [sec]");
ylabel("RPM");
title("Actuator States - ", legend_6);

linkaxes([ax1,ax2,ax3,ax4,ax5,ax6], 'x');

%% P9 : Error Terms for Pseudo Control Input

figure_9 = figure('Visible', show_fig9, 'Position', [100 200 1000 800]);
set(figure_9,'defaulttextinterpreter','latex');

tiledlayout(3,2);

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

ax3 = nexttile;
plot(log_3.time, log_3.qdd_ref,'LineWidth',1.0,'Color','k','LineStyle','--'); hold on;
plot(log_3.time, log_3.theta_att_err,'LineWidth',1.2,'Color','b'); hold on;
plot(log_3.time, log_3.q_rate_err,'LineWidth',1.2,'Color','r'); hold on;
plot(log_3.time, log_3.q_acc_err,'LineWidth',1.2,'Color','g'); hold on;
grid minor;
legend('ref','error att','error rate','error acc','Interpreter','latex');
xlabel("time [sec]");
ylabel("acceleration");
title("Error Terms Sim - ", legend_3);

ax4 = nexttile;
plot(log_4.time, log_4.qdd_ref,'LineWidth',1.0,'Color','k','LineStyle','--'); hold on;
plot(log_4.time, log_4.theta_att_err,'LineWidth',1.2,'Color','b'); hold on;
plot(log_4.time, log_4.q_rate_err,'LineWidth',1.2,'Color','r'); hold on;
plot(log_4.time, log_4.q_acc_err,'LineWidth',1.2,'Color','g'); hold on;
grid minor;
legend('ref','error att','error rate','error acc','Interpreter','latex');
xlabel("time [sec]");
ylabel("acceleration");
title("Error Terms Sim - ", legend_4);

ax5 = nexttile;
plot(log_5.time, log_5.qdd_ref,'LineWidth',1.0,'Color','k','LineStyle','--'); hold on;
plot(log_5.time, log_5.theta_att_err,'LineWidth',1.2,'Color','b'); hold on;
plot(log_5.time, log_5.q_rate_err,'LineWidth',1.2,'Color','r'); hold on;
plot(log_5.time, log_5.q_acc_err,'LineWidth',1.2,'Color','g'); hold on;
grid minor;
legend('ref','error att','error rate','error acc','Interpreter','latex');
xlabel("time [sec]");
ylabel("acceleration");
title("Error Terms Sim - ", legend_5);

ax6 = nexttile;
plot(log_6.time, log_6.qdd_ref,'LineWidth',1.0,'Color','k','LineStyle','--'); hold on;
plot(log_6.time, log_6.theta_att_err,'LineWidth',1.2,'Color','b'); hold on;
plot(log_6.time, log_6.q_rate_err,'LineWidth',1.2,'Color','r'); hold on;
plot(log_6.time, log_6.q_acc_err,'LineWidth',1.2,'Color','g'); hold on;
grid minor;
legend('ref','error att','error rate','error acc','Interpreter','latex');
xlabel("time [sec]");
ylabel("acceleration");
title("Error Terms Sim - ", legend_6);

linkaxes([ax1,ax2,ax3,ax4,ax5,ax6], 'x');


