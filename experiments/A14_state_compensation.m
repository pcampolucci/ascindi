%% Validation Inner Loop

%%% 1 : Process Data from Logger

folder = '05_17_22_state_comp/';

start_log = 0.05;
end_log = 0.99;

log_1 = logger(strcat(folder,'step_no_plate_no_model'), start_log, end_log);
log_2 = logger(strcat(folder,'step_no_plate_yes_model'), start_log, end_log);
log_3 = logger(strcat(folder,'step_yes_plate_no_model'), start_log, end_log);
log_4 = logger(strcat(folder,'step_yes_plate_yes_model'), start_log, end_log);
log_5 = logger(strcat(folder,'step_yes_plate_yes_model_yes_comp'), start_log, end_log);

legend_1 = 'Plain';
legend_2 = 'Model';
legend_3 = 'Plate';
legend_4 = 'Plate + Model';
legend_5 = 'Plate + Model + Comp';

% time shift between signals
shift_2 = 24.502;
shift_3 = -27.7929;
shift_4 = 13.8418;
shift_5 = 25.7852;

%%% 2 : control panel on showing figures or not

show_fig1 = false;
show_fig4 = false;
show_fig7 = false;
show_fig9 = false;
show_fig10 = true;

%%% 3 : filtering settings
f_sample = 1/0.002;

%%% 4 : align time
log_2.time = log_2.time + shift_2;
log_3.time = log_3.time + shift_3;
log_4.time = log_4.time + shift_4;
log_5.time = log_5.time + shift_5;

%% P1 : Compare the reference trajectory tracking

figure_1 = figure('Visible', show_fig1, 'Position', [100 200 1000 800]);
set(figure_1,'defaulttextinterpreter','latex');

plot(log_1.time, rad2deg(log_1.psi_cmd),'LineWidth',0.8,'Color','k'); hold on;
% plot(log_2.time, rad2deg(log_2.psi_cmd),'LineWidth',0.8,'Color','k'); hold on;
% plot(log_3.time, rad2deg(log_3.psi_cmd),'LineWidth',0.8,'Color','k'); hold on;
% plot(log_4.time, rad2deg(log_4.psi_cmd),'LineWidth',0.8,'Color','k'); hold on;
% plot(log_5.time, rad2deg(log_5.psi_cmd),'LineWidth',0.8,'Color','k'); hold on;
plot(log_1.time, rad2deg(log_1.psi_ref),'LineWidth',0.8,'Color','b',LineStyle='--'); hold on;
plot(log_1.time, rad2deg(log_1.psi_state),'LineWidth',0.8,'Color','b'); hold on;
plot(log_2.time, rad2deg(log_2.psi_ref),'LineWidth',0.8,'Color','g',LineStyle='--'); hold on;
plot(log_2.time, rad2deg(log_2.psi_state),'LineWidth',0.8,'Color','g'); hold on;
plot(log_3.time, rad2deg(log_3.psi_ref),'LineWidth',0.8,'Color','m',LineStyle='--'); hold on;
plot(log_3.time, rad2deg(log_3.psi_state),'LineWidth',0.8,'Color','m'); hold on;
plot(log_4.time, rad2deg(log_4.psi_ref),'LineWidth',0.8,'Color','r',LineStyle='--'); hold on;
plot(log_4.time, rad2deg(log_4.psi_state),'LineWidth',0.8,'Color','r'); hold on;
plot(log_5.time, rad2deg(log_5.psi_ref),'LineWidth',0.8,'Color','c',LineStyle='--'); hold on;
plot(log_5.time, rad2deg(log_5.psi_state),'LineWidth',0.8,'Color','c'); 
grid minor;
legend('cmd','ref',legend_1,'ref',legend_2,'ref',legend_3,'ref',legend_4,'ref',legend_5,'Interpreter','latex');
xlabel("time [sec]");
ylabel("$$\psi$$ [deg]");
title("Yaw Tracking");

%% P4 : Complementary filters state estimation

figure_4 = figure('Visible', show_fig4, 'Position', [100 200 1000 800]);
set(figure_4,'defaulttextinterpreter','latex');

tiledlayout(3,2);

ax1 = nexttile;
plot(log_1.time, rad2deg(log_1.rd_ref),'LineWidth',1.5,'Color','g'); hold on;
plot(log_1.time, rad2deg(log_1.rd_state_f),'LineWidth',1.2,'Color','b','LineStyle','--'); hold on;
plot(log_1.time, rad2deg(log_1.rd_estimated),'LineWidth',1.2,'Color','r'); hold on;
plot(log_1.time, rad2deg(log_1.rd_estimated_f ),'LineWidth',1.2,'Color','r','LineStyle','--'); hold on;
plot(log_1.time, rad2deg(log_1.rd_state_f_undelayed ),'LineWidth',1.2,'Color','b');
grid minor;
legend('ref','state filt','estimated','estimated filt','undelayed','Interpreter','latex');
xlabel("time [sec]");
ylabel("$$r_d$$ [deg/sec^2]");
title("Complementary Filter Performance - ",legend_1);

ax2 = nexttile;
plot(log_2.time, rad2deg(log_2.rd_ref),'LineWidth',1.5,'Color','g'); hold on;
plot(log_2.time, rad2deg(log_2.rd_state_f),'LineWidth',1.2,'Color','b','LineStyle','--'); hold on;
plot(log_2.time, rad2deg(log_2.rd_estimated),'LineWidth',1.2,'Color','r'); hold on;
plot(log_2.time, rad2deg(log_2.rd_estimated_f ),'LineWidth',1.2,'Color','r','LineStyle','--'); hold on;
plot(log_2.time, rad2deg(log_2.rd_state_f_undelayed ),'LineWidth',1.2,'Color','b');
grid minor;
legend('ref','state filt','estimated','estimated filt','undelayed','Interpreter','latex');
xlabel("time [sec]");
ylabel("$$r_d$$ [deg/sec^2]");
title("Complementary Filter Performance - ",legend_2);

ax3 = nexttile;
plot(log_3.time, rad2deg(log_3.rd_ref),'LineWidth',1.5,'Color','g'); hold on;
plot(log_3.time, rad2deg(log_3.rd_state_f),'LineWidth',1.2,'Color','b','LineStyle','--'); hold on;
plot(log_3.time, rad2deg(log_3.rd_estimated),'LineWidth',1.2,'Color','r'); hold on;
plot(log_3.time, rad2deg(log_3.rd_estimated_f ),'LineWidth',1.2,'Color','r','LineStyle','--'); hold on;
plot(log_3.time, rad2deg(log_3.rd_state_f_undelayed ),'LineWidth',1.2,'Color','b');
grid minor;
legend('ref','state filt','estimated','estimated filt','undelayed','Interpreter','latex');
xlabel("time [sec]");
ylabel("$$r_d$$ [deg/sec^2]");
title("Complementary Filter Performance - ",legend_3);

ax4 = nexttile;
plot(log_4.time, rad2deg(log_4.rd_ref),'LineWidth',1.5,'Color','g'); hold on;
plot(log_4.time, rad2deg(log_4.rd_state_f),'LineWidth',1.2,'Color','b','LineStyle','--'); hold on;
plot(log_4.time, rad2deg(log_4.rd_estimated),'LineWidth',1.2,'Color','r'); hold on;
plot(log_4.time, rad2deg(log_4.rd_estimated_f ),'LineWidth',1.2,'Color','r','LineStyle','--'); hold on;
plot(log_4.time, rad2deg(log_4.rd_state_f_undelayed ),'LineWidth',1.2,'Color','b');
grid minor;
legend('ref','state filt','estimated','estimated filt','undelayed','Interpreter','latex');
xlabel("time [sec]");
ylabel("$$r_d$$ [deg/sec^2]");
title("Complementary Filter Performance - ",legend_4);

ax5 = nexttile;
plot(log_5.time, rad2deg(log_5.rd_ref),'LineWidth',1.5,'Color','g'); hold on;
plot(log_5.time, rad2deg(log_5.rd_state_f),'LineWidth',1.2,'Color','b','LineStyle','--'); hold on;
plot(log_5.time, rad2deg(log_5.rd_estimated),'LineWidth',1.2,'Color','r'); hold on;
plot(log_5.time, rad2deg(log_5.rd_estimated_f ),'LineWidth',1.2,'Color','r','LineStyle','--'); hold on;
plot(log_5.time, rad2deg(log_5.rd_state_f_undelayed ),'LineWidth',1.2,'Color','b');
grid minor;
legend('ref','state filt','estimated','estimated filt','undelayed','Interpreter','latex');
xlabel("time [sec]");
ylabel("$$r_d$$ [deg/sec^2]");
title("Complementary Filter Performance - ",legend_5);

ax6 = nexttile;
plot(log_1.time, rad2deg(log_1.psi_cmd),'LineWidth',0.8,'Color','k'); hold on;
% plot(log_2.time, rad2deg(log_2.psi_cmd),'LineWidth',0.8,'Color','k'); hold on;
% plot(log_3.time, rad2deg(log_3.psi_cmd),'LineWidth',0.8,'Color','k'); hold on;
% plot(log_4.time, rad2deg(log_4.psi_cmd),'LineWidth',0.8,'Color','k'); hold on;
% plot(log_5.time, rad2deg(log_5.psi_cmd),'LineWidth',0.8,'Color','k'); hold on;
plot(log_1.time, rad2deg(log_1.psi_ref),'LineWidth',0.8,'Color','b',LineStyle='--'); hold on;
plot(log_1.time, rad2deg(log_1.psi_state),'LineWidth',0.8,'Color','b'); hold on;
plot(log_2.time, rad2deg(log_2.psi_ref),'LineWidth',0.8,'Color','g',LineStyle='--'); hold on;
plot(log_2.time, rad2deg(log_2.psi_state),'LineWidth',0.8,'Color','g'); hold on;
plot(log_3.time, rad2deg(log_3.psi_ref),'LineWidth',0.8,'Color','m',LineStyle='--'); hold on;
plot(log_3.time, rad2deg(log_3.psi_state),'LineWidth',0.8,'Color','m'); hold on;
plot(log_4.time, rad2deg(log_4.psi_ref),'LineWidth',0.8,'Color','r',LineStyle='--'); hold on;
plot(log_4.time, rad2deg(log_4.psi_state),'LineWidth',0.8,'Color','r'); hold on;
plot(log_5.time, rad2deg(log_5.psi_ref),'LineWidth',0.8,'Color','c',LineStyle='--'); hold on;
plot(log_5.time, rad2deg(log_5.psi_state),'LineWidth',0.8,'Color','c'); 
grid minor;
legend('cmd','ref',legend_1,'ref',legend_2,'ref',legend_3,'ref',legend_4,'ref',legend_5,'Interpreter','latex');
xlabel("time [sec]");
ylabel("$$\psi$$ [deg]");
title("Yaw Tracking");

linkaxes([ax1,ax2,ax3,ax4,ax5,ax6], 'x');

%% P7 : Looking at actuators

figure_7 = figure('Visible', show_fig7, 'Position', [100 200 1000 800]);
set(figure_7,'defaulttextinterpreter','latex');

tiledlayout(3,2);

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
plot(log_1.time, rad2deg(log_1.psi_cmd),'LineWidth',0.8,'Color','k'); hold on;
% plot(log_2.time, rad2deg(log_2.psi_cmd),'LineWidth',0.8,'Color','k'); hold on;
% plot(log_3.time, rad2deg(log_3.psi_cmd),'LineWidth',0.8,'Color','k'); hold on;
% plot(log_4.time, rad2deg(log_4.psi_cmd),'LineWidth',0.8,'Color','k'); hold on;
% plot(log_5.time, rad2deg(log_5.psi_cmd),'LineWidth',0.8,'Color','k'); hold on;
plot(log_1.time, rad2deg(log_1.psi_ref),'LineWidth',0.8,'Color','b',LineStyle='--'); hold on;
plot(log_1.time, rad2deg(log_1.psi_state),'LineWidth',0.8,'Color','b'); hold on;
plot(log_2.time, rad2deg(log_2.psi_ref),'LineWidth',0.8,'Color','g',LineStyle='--'); hold on;
plot(log_2.time, rad2deg(log_2.psi_state),'LineWidth',0.8,'Color','g'); hold on;
plot(log_3.time, rad2deg(log_3.psi_ref),'LineWidth',0.8,'Color','m',LineStyle='--'); hold on;
plot(log_3.time, rad2deg(log_3.psi_state),'LineWidth',0.8,'Color','m'); hold on;
plot(log_4.time, rad2deg(log_4.psi_ref),'LineWidth',0.8,'Color','r',LineStyle='--'); hold on;
plot(log_4.time, rad2deg(log_4.psi_state),'LineWidth',0.8,'Color','r'); hold on;
plot(log_5.time, rad2deg(log_5.psi_ref),'LineWidth',0.8,'Color','c',LineStyle='--'); hold on;
plot(log_5.time, rad2deg(log_5.psi_state),'LineWidth',0.8,'Color','c'); 
grid minor;
legend('cmd','ref',legend_1,'ref',legend_2,'ref',legend_3,'ref',legend_4,'ref',legend_5,'Interpreter','latex');
xlabel("time [sec]");
ylabel("$$\psi$$ [deg]");
title("Yaw Tracking");

linkaxes([ax1,ax2,ax3,ax4,ax5,ax6], 'x');

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

%% P10 : Error Terms for Pseudo Control Input

figure_10 = figure('Visible', show_fig10, 'Position', [100 200 1000 800]);
set(figure_10,'defaulttextinterpreter','latex');

tiledlayout(2,1);

ax1 = nexttile;
plot(log_2.time, (log_2.rd_estimated),'LineWidth',1.2,'Color','r'); hold on;
plot(log_2.time, (log_2.rd_estimated_f ),'LineWidth',1.2,'Color','r','LineStyle','--'); hold on;
plot(log_3.time, (log_3.rd_estimated),'LineWidth',1.2,'Color','b'); hold on;
plot(log_3.time, (log_3.rd_estimated_f ),'LineWidth',1.2,'Color','b','LineStyle','--'); hold on;
plot(log_4.time, (log_4.rd_estimated),'LineWidth',1.2,'Color','g'); hold on;
plot(log_4.time, (log_4.rd_estimated_f ),'LineWidth',1.2,'Color','g','LineStyle','--'); hold on;
grid minor;
legend(legend_2,'filtered',legend_3,'filtered',legend_4,'filtered','Interpreter','latex');
xlabel("time [sec]");
ylabel("acceleration");
title("Estimated Signals");

ax2 = nexttile;
plot(log_1.time, rad2deg(log_1.psi_cmd),'LineWidth',0.8,'Color','k'); hold on;
% plot(log_2.time, rad2deg(log_2.psi_cmd),'LineWidth',0.8,'Color','k'); hold on;
% plot(log_3.time, rad2deg(log_3.psi_cmd),'LineWidth',0.8,'Color','k'); hold on;
% plot(log_4.time, rad2deg(log_4.psi_cmd),'LineWidth',0.8,'Color','k'); hold on;
% plot(log_5.time, rad2deg(log_5.psi_cmd),'LineWidth',0.8,'Color','k'); hold on;
plot(log_1.time, rad2deg(log_1.psi_ref),'LineWidth',0.8,'Color','b',LineStyle='--'); hold on;
plot(log_1.time, rad2deg(log_1.psi_state),'LineWidth',0.8,'Color','b'); hold on;
plot(log_2.time, rad2deg(log_2.psi_ref),'LineWidth',0.8,'Color','g',LineStyle='--'); hold on;
plot(log_2.time, rad2deg(log_2.psi_state),'LineWidth',0.8,'Color','g'); hold on;
plot(log_3.time, rad2deg(log_3.psi_ref),'LineWidth',0.8,'Color','m',LineStyle='--'); hold on;
plot(log_3.time, rad2deg(log_3.psi_state),'LineWidth',0.8,'Color','m'); hold on;
plot(log_4.time, rad2deg(log_4.psi_ref),'LineWidth',0.8,'Color','r',LineStyle='--'); hold on;
plot(log_4.time, rad2deg(log_4.psi_state),'LineWidth',0.8,'Color','r'); hold on;
plot(log_5.time, rad2deg(log_5.psi_ref),'LineWidth',0.8,'Color','c',LineStyle='--'); hold on;
plot(log_5.time, rad2deg(log_5.psi_state),'LineWidth',0.8,'Color','c'); 
grid minor;
legend('cmd','ref',legend_1,'ref',legend_2,'ref',legend_3,'ref',legend_4,'ref',legend_5,'Interpreter','latex');
xlabel("time [sec]");
ylabel("$$\psi$$ [deg]");
title("Yaw Tracking");

linkaxes([ax1,ax2], 'x');