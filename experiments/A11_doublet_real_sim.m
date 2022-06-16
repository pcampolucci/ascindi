%% Validation Inner Loop

%%% 1 : Process Data from Logger

folder = '05_16_22/';

start_log = 0.05;
end_log = 0.99;

log_1 = logger(strcat(folder,'doublet_50_indi_sim'), start_log, end_log);
log_2 = logger(strcat(folder,'doublet_50_asc_sim'), start_log, end_log);
log_3 = logger(strcat(folder,'doublet_indi_50'), start_log, end_log);
log_4 = logger(strcat(folder,'doublet_asc_50'), start_log, end_log);

legend_1 = 'INDI Sim';
legend_2 = 'ASC Sim';
legend_3 = 'INDI';
legend_4 = 'ASC';

% time shift between signals
shift_indi_sim = 68.7955;
shift_asc_sim = 75.3377;
shift_indi = 63.4609;

%%% 2 : control panel on showing figures or not

show_fig1 = false;
show_fig2 = false;
show_fig3 = false;
show_fig4 = false;
show_fig5 = true;
show_fig6 = false;
show_fig7 = false;
show_fig8 = true;
show_fig9 = true;
show_fig10 = false;
show_fig11 = true;

%%% 3 : filtering settings
f_sample = 1/0.002;

%%% 4 : align time
log_1.time = log_1.time + shift_indi_sim;
log_2.time = log_2.time + shift_asc_sim;
log_3.time = log_3.time + shift_indi;

%% P1 : Compare the reference trajectory tracking

figure_1 = figure('Visible', show_fig1, 'Position', [100 200 1000 800]);
set(figure_1,'defaulttextinterpreter','latex');

plot(log_1.time, rad2deg(log_1.theta_cmd),'LineWidth',0.8,'Color','k'); hold on;
% indi sim
plot(log_1.time, rad2deg(log_1.theta_ref),'LineWidth',0.8,'Color','b',LineStyle='--'); hold on;
plot(log_1.time, rad2deg(log_1.theta_state),'LineWidth',0.8,'Color','b'); hold on;
% asc sim
plot(log_2.time, rad2deg(log_2.theta_ref),'LineWidth',0.8,'Color','g',LineStyle='--'); hold on;
plot(log_2.time, rad2deg(log_2.theta_state),'LineWidth',0.8,'Color','g'); hold on;
% indi flight
plot(log_3.time, rad2deg(log_3.theta_ref),'LineWidth',0.8,'Color','r',LineStyle='--'); hold on;
plot(log_3.time, rad2deg(log_3.theta_state),'LineWidth',0.8,'Color','r'); hold on;
% asc flight
plot(log_4.time, rad2deg(log_4.theta_ref),'LineWidth',0.8,'Color','c',LineStyle='--'); hold on;
plot(log_4.time, rad2deg(log_4.theta_state),'LineWidth',0.8,'Color','c'); hold on;
grid minor;
legend('cmd','ref',legend_1,'ref',legend_2,'ref',legend_3,'ref',legend_4,'Interpreter','latex');
xlabel("time [sec]");
ylabel("$$\theta$$ [deg]");
title("Pitch Doublet Tracking");

%% P2 : Compare the reference trajectories

figure_2 = figure('Visible', show_fig2, 'Position', [100 200 1000 800]);
set(figure_2,'defaulttextinterpreter','latex');

plot(log_1.time, rad2deg(log_1.theta_cmd),'LineWidth',0.8,'Color','k'); hold on;
% indi sim
plot(log_1.time, rad2deg(log_1.theta_ref),'LineWidth',0.8,'Color','b'); hold on;
% asc sim
plot(log_2.time, rad2deg(log_2.theta_ref),'LineWidth',0.8,'Color','g'); hold on;
% indi flight
plot(log_3.time, rad2deg(log_3.theta_ref),'LineWidth',0.8,'Color','r'); hold on;
% asc flight
plot(log_4.time, rad2deg(log_4.theta_ref),'LineWidth',0.8,'Color','c'); 
grid minor;
legend('cmd',legend_1,legend_2,legend_3,legend_4,'Interpreter','latex');
xlabel("time [sec]");
ylabel("$$\theta$$ [deg]");
title("Reference Trajectories");

%% P3 : Complementary filters state estimation

figure_3 = figure('Visible', show_fig3, 'Position', [100 200 1000 800]);
set(figure_3,'defaulttextinterpreter','latex');

% ASC Sim
plot(log_2.time, rad2deg(log_2.qd_ref),'LineWidth',1,'Color','b','Marker','+'); hold on;
plot(log_2.time, rad2deg(log_2.qd_state_f),'LineWidth',0.8,'Color','b','LineStyle','--'); hold on;
plot(log_2.time, rad2deg(log_2.qd_state_f_undelayed ),'LineWidth',0.8,'Color','b','LineStyle','-.'); hold on;
plot(log_2.time, rad2deg(log_2.qd_estimated),'LineWidth',0.8,'Color','b','LineStyle',':'); hold on;
plot(log_2.time, rad2deg(log_2.qd_estimated_f ),'LineWidth',0.8,'Color','b','LineStyle','-'); 
% ASC Flight
plot(log_4.time, rad2deg(log_4.qd_ref),'LineWidth',1,'Color','r','Marker','+'); hold on;
plot(log_4.time, rad2deg(log_4.qd_state_f),'LineWidth',0.8,'Color','r','LineStyle','--'); hold on;
plot(log_4.time, rad2deg(log_4.qd_state_f_undelayed ),'LineWidth',0.8,'Color','r','LineStyle','-.'); hold on;
plot(log_4.time, rad2deg(log_4.qd_estimated),'LineWidth',0.8,'Color','r','LineStyle',':'); hold on;
plot(log_4.time, rad2deg(log_4.qd_estimated_f ),'LineWidth',0.8,'Color','r','LineStyle','-'); 
grid minor;
legend('sim ref','sim state filt','sim undelayed','sim estimated','sim estimated filt','ref','state filt','undelayed','estimated','estimated filt','Interpreter','latex');
xlabel("time [sec]");
ylabel("$$\theta$$ [deg]");
title("Reference Trajectories");

%% P4 : Complementary filters state estimation - Sim

figure_4 = figure('Visible', show_fig4, 'Position', [100 200 1000 800]);
set(figure_4,'defaulttextinterpreter','latex');

log_fig_4 = log_4;

% ASC Sim
plot(log_fig_4.time, rad2deg(log_fig_4.qd_ref),'LineWidth',1.5,'Color','g'); hold on;
plot(log_fig_4.time, rad2deg(log_fig_4.qd_state_f),'LineWidth',1.2,'Color','b','LineStyle','--'); hold on;
plot(log_fig_4.time, rad2deg(log_fig_4.qd_estimated)+1000,'LineWidth',1.2,'Color','r'); hold on;
plot(log_fig_4.time, rad2deg(log_fig_4.qd_estimated_f )+1000,'LineWidth',1.2,'Color','r','LineStyle','--'); hold on;
plot(log_fig_4.time, rad2deg(log_fig_4.qd_state_f_undelayed ),'LineWidth',1.2,'Color','b');
grid minor;
legend('ref','state filt','estimated','estimated filt','undelayed','Interpreter','latex');
xlabel("time [sec]");
ylabel("$$q_d$$ [deg/sec^2]");
title("Complementary Filter Performance");

%% P5 : State Effect on Step Response

figure_5 = figure('Visible', show_fig5, 'Position', [100 200 1000 800]);
set(figure_5,'defaulttextinterpreter','latex');

log_fig_5 = log_2;

ax1 = nexttile;
plot(log_fig_5.time, rad2deg(log_fig_5.qd_ref),'LineWidth',1.5,'Color','g'); hold on;
plot(log_fig_5.time, rad2deg(log_fig_5.qd_state_f),'LineWidth',1.2,'Color','b','LineStyle','--'); hold on;
plot(log_fig_5.time, rad2deg(log_fig_5.qd_estimated),'LineWidth',1.2,'Color','r'); hold on;
plot(log_fig_5.time, rad2deg(log_fig_5.qd_estimated_f ),'LineWidth',1.2,'Color','r','LineStyle','--'); hold on;
plot(log_fig_5.time, rad2deg(log_fig_5.qd_state_f_undelayed ),'LineWidth',1.2,'Color','b');
grid minor;
legend('ref','state filt','estimated','estimated filt','undelayed','Interpreter','latex');
xlabel("time [sec]");
ylabel("$$q_d$$ [deg/sec^2]");
title("Complementary Filter Performance");

ax2 = nexttile;
plot(log_fig_5.time, rad2deg(log_fig_5.theta_cmd),'LineWidth',0.8,'Color','k'); hold on;
plot(log_fig_5.time, rad2deg(log_fig_5.theta_ref),'LineWidth',1,'Color','b'); hold on;
plot(log_fig_5.time, rad2deg(log_fig_5.theta_state),'LineWidth',1,'Color','r'); hold on;
grid minor;
legend('cmd','ref','state','Interpreter','latex');
xlabel("time [sec]");
ylabel("$$q_d$$ [deg/sec^2]");
title("Theta Tracking");

linkaxes([ax1,ax2], 'x');

%% P6 : Looking at rotational speed

figure_6 = figure('Visible', show_fig6, 'Position', [100 200 1000 800]);
set(figure_6,'defaulttextinterpreter','latex');

log_fig_6 = log_2;

ax1 = nexttile;
plot(log_fig_6.time, rad2deg(log_fig_6.q_ref),'LineWidth',1.2,'Color','b','LineStyle','--'); hold on;
plot(log_fig_6.time, rad2deg(log_fig_6.q_state),'LineWidth',1.2,'Color','r');
grid minor;
legend('ref','state','Interpreter','latex');
xlabel("time [sec]");
ylabel("$$q_d$$ [deg/sec^2]");
title("Complementary Filter Performance");

ax2 = nexttile;
plot(log_fig_6.time, rad2deg(log_fig_6.theta_cmd),'LineWidth',0.8,'Color','k'); hold on;
plot(log_fig_6.time, rad2deg(log_fig_6.theta_ref),'LineWidth',1,'Color','b'); hold on;
plot(log_fig_6.time, rad2deg(log_fig_6.theta_state),'LineWidth',1,'Color','r'); hold on;
grid minor;
legend('cmd','ref','state','Interpreter','latex');
xlabel("time [sec]");
ylabel("$$q_d$$ [deg/sec^2]");
title("Theta Tracking");

linkaxes([ax1,ax2], 'x');

%% P7 : Looking at actuators

figure_7 = figure('Visible', show_fig7, 'Position', [100 200 1000 800]);
set(figure_7,'defaulttextinterpreter','latex');

log_fig_7 = log_4;

ax1 = nexttile;
plot(log_fig_7.time, log_fig_7.act_cmd_1,'LineWidth',1.2,'Color','b','LineStyle','--'); hold on;
plot(log_fig_7.time, log_fig_7.act_state_1,'LineWidth',1.2,'Color','b'); hold on;
plot(log_fig_7.time, log_fig_7.act_cmd_2,'LineWidth',1.2,'Color','g','LineStyle','--'); hold on;
plot(log_fig_7.time, log_fig_7.act_state_2,'LineWidth',1.2,'Color','g'); hold on;
plot(log_fig_7.time, log_fig_7.act_cmd_3,'LineWidth',1.2,'Color','c','LineStyle','--'); hold on;
plot(log_fig_7.time, log_fig_7.act_state_3,'LineWidth',1.2,'Color','c'); hold on;
plot(log_fig_7.time, log_fig_7.act_cmd_4,'LineWidth',1.2,'Color','r','LineStyle','--'); hold on;
plot(log_fig_7.time, log_fig_7.act_state_4,'LineWidth',1.2,'Color','r');
grid minor;
legend('cmd 1','state 1','cmd 2','state 2','cmd 3','state 3','cmd 4','state 4','Interpreter','latex');
xlabel("time [sec]");
ylabel("RPM");
title("Actuator States");

ax2 = nexttile;
plot(log_fig_7.time, rad2deg(log_fig_7.theta_cmd),'LineWidth',0.8,'Color','k'); hold on;
plot(log_fig_7.time, rad2deg(log_fig_7.theta_ref),'LineWidth',1,'Color','b'); hold on;
plot(log_fig_7.time, rad2deg(log_fig_7.theta_state),'LineWidth',1,'Color','r'); hold on;
grid minor;
legend('cmd','ref','state','Interpreter','latex');
xlabel("time [sec]");
ylabel("$$\theta$$ [deg]");
title("Theta Tracking");

linkaxes([ax1,ax2], 'x');

%% P8 : Looking at actuators delay difference

figure_8 = figure('Visible', show_fig8, 'Position', [100 200 1000 800]);
set(figure_8,'defaulttextinterpreter','latex');

ax1 = nexttile;
plot(log_2.time, log_2.act_cmd_1,'LineWidth',1.2,'Color','b','LineStyle','--'); hold on;
plot(log_2.time, log_2.act_state_1,'LineWidth',1.2,'Color','b'); hold on;
plot(log_4.time, log_4.act_cmd_1,'LineWidth',1.2,'Color','r','LineStyle','--'); hold on;
plot(log_4.time, log_4.act_state_1,'LineWidth',1.2,'Color','r'); hold on;
grid minor;
legend('cmd 1 sim','state 1 sim','cmd 1','state 1','Interpreter','latex');
xlabel("time [sec]");
ylabel("RPM");
title("Actuator States");

ax2 = nexttile;
plot(log_4.time, rad2deg(log_4.theta_cmd),'LineWidth',0.8,'Color','k'); hold on;
plot(log_4.time, rad2deg(log_4.theta_ref),'LineWidth',1,'Color','b'); hold on;
plot(log_4.time, rad2deg(log_4.theta_state),'LineWidth',1,'Color','r'); hold on;
grid minor;
legend('cmd','ref','state','Interpreter','latex');
xlabel("time [sec]");
ylabel("$$\theta$$ [deg]");
title("Theta Tracking");

linkaxes([ax1,ax2], 'x');

%% P9 : Error Terms for Pseudo Control Input

figure_9 = figure('Visible', show_fig9, 'Position', [100 200 1000 800]);
set(figure_9,'defaulttextinterpreter','latex');

ax1 = nexttile;
plot(log_2.time, log_2.qdd_ref,'LineWidth',1.0,'Color','k','LineStyle','--'); hold on;
plot(log_2.time, log_2.theta_att_err,'LineWidth',1.2,'Color','b'); hold on;
plot(log_2.time, log_2.q_rate_err,'LineWidth',1.2,'Color','r'); hold on;
plot(log_2.time, log_2.q_acc_err,'LineWidth',1.2,'Color','g'); hold on;
grid minor;
legend('ref','error att','error rate','error acc','Interpreter','latex');
xlabel("time [sec]");
ylabel("acceleration");
title("Error Terms Sim");

ax2 = nexttile;
plot(log_4.time, log_4.qdd_ref,'LineWidth',1.0,'Color','k','LineStyle','--'); hold on;
plot(log_4.time, log_4.theta_att_err,'LineWidth',1.2,'Color','b'); hold on;
plot(log_4.time, log_4.q_rate_err,'LineWidth',1.2,'Color','r'); hold on;
plot(log_4.time, log_4.q_acc_err,'LineWidth',1.2,'Color','g'); hold on;
grid minor;
legend('ref','error att','error rate','error acc','Interpreter','latex');
xlabel("time [sec]");
ylabel("acceleration");
title("Error Terms Real");

linkaxes([ax1,ax2], 'x');

%% P10 : Pseudo Control Inputs

figure_10 = figure('Visible', show_fig10, 'Position', [100 200 1000 800]);
set(figure_10,'defaulttextinterpreter','latex');

log_fig_10 = log_4;

ax1 = nexttile;
plot(log_fig_10.time, log_fig_10.qdd_ref,'LineWidth',1.0,'Color','k','LineStyle','--'); hold on;
plot(log_fig_10.time, log_fig_10.theta_att_err,'LineWidth',1.2,'Color','b'); hold on;
plot(log_fig_10.time, log_fig_10.q_rate_err,'LineWidth',1.2,'Color','r'); hold on;
plot(log_fig_10.time, log_fig_10.q_acc_err,'LineWidth',1.2,'Color','g'); hold on;
grid minor;
legend('ref','error att','error rate','error acc','Interpreter','latex');
xlabel("time [sec]");
ylabel("acceleration");
title("Error Terms Sim");

ax2 = nexttile;
plot(log_fig_10.time, log_fig_10.qdd_ref,'LineWidth',1.0,'Color','k','LineStyle','--'); hold on;
plot(log_fig_10.time, log_fig_10.theta_att_err,'LineWidth',1.2,'Color','b'); hold on;
plot(log_fig_10.time, log_fig_10.q_rate_err,'LineWidth',1.2,'Color','r'); hold on;
plot(log_fig_10.time, log_fig_10.q_acc_err,'LineWidth',1.2,'Color','g'); hold on;
grid minor;
legend('ref','error att','error rate','error acc','Interpreter','latex');
xlabel("time [sec]");
ylabel("acceleration");
title("Error Terms Real");

linkaxes([ax1,ax2], 'x');
