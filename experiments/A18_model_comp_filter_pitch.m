%% Validation Inner Loop

%%% 1 : Process Data from Logger

folder = '05_25_22_doublet/';

start_log = 0.2;
end_log = 0.8;

log_1 = logger(strcat(folder,'doublet_plate_model_low_gains'), start_log, end_log);

legend_1 = 'Model';

%%% 2 : control panel on showing figures or not

show_fig1 = true;
show_fig2 = true;

%% P4 : Complementary filters state estimation

figure_1 = figure('Visible', show_fig1, 'Position', [100 200 1000 800]);
set(figure_1,'defaulttextinterpreter','latex');

tiledlayout(3,1);

ax1 = nexttile;
plot(log_1.time, (log_1.qd_ref),'LineWidth',1.5,'Color','g'); hold on;
plot(log_1.time, (log_1.qd_state_f),'LineWidth',1.2,'Color','m'); hold on;
plot(log_1.time, (log_1.qd_estimated),'LineWidth',1.2,'Color','r',LineStyle='--'); hold on;
plot(log_1.time, (log_1.qd_estimated_f),'LineWidth',1.2,'Color','r'); hold on;
plot(log_1.time, (log_1.qd_state_f_undelayed),'LineWidth',1.2,'Color','b'); 
grid minor;
legend('ref','state filt','estimated','estimated filt','undelayed','Interpreter','latex');
xlabel("time [sec]");
ylabel("$$r_d$$ [deg/sec^2]");
title("Complementary Filter Performance - ",legend_1);

ax2 = nexttile;
plot(log_1.time, (log_1.theta_ref),'LineWidth',0.8,'Color','b',LineStyle='--'); hold on;
plot(log_1.time, (log_1.theta_state),'LineWidth',0.8,'Color','b');
grid minor;
legend('cmd','ref',legend_1,'Interpreter','latex');
xlabel("time [sec]");
ylabel("$$\theta$$ [deg]");
title("Theta Tracking");

ax3 = nexttile;
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

linkaxes([ax1,ax2,ax3], 'x');

%% P9 : Error Terms for Pseudo Control Input

figure_2 = figure('Visible', show_fig2, 'Position', [100 200 1000 800]);
set(figure_2,'defaulttextinterpreter','latex');

tiledlayout(1,1);

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

linkaxes([ax1], 'x');