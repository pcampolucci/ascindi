%% Doublet 

%%% 1 : Process Data from Logger

folder = '06_03_22_doublet/';

start_log = 0.1;
end_log = 0.99;

log_1 = logger(strcat(folder,'doublet_no_comp_agg'), start_log, end_log);
log_2 = logger(strcat(folder,'doublet_comp_agg'), start_log, end_log);

legend_1 = 'No Compensation';
legend_2 = 'Compensation';

% time shift between signals
shift_comp_aggr = -26.32;
shift_comp = -49.083;

%%% 2 : control panel on showing figures or not

show_fig1 = true;
show_fig2 = false;
show_fig3 = false;
show_fig4 = false;
show_fig5 = false;
show_fig6 = false;

%%% 3 : align time
log_2.time = log_2.time + shift_comp_aggr;

%% P1 : Tracking Performance Overview
figure_1 = figure('Visible', show_fig1, 'Position', [100 200 1000 800]);
set(figure_1,'defaulttextinterpreter','latex');

plot(log_1.time, rad2deg(log_1.theta_cmd),'LineWidth',1.2,'Color','k'); hold on;
% plot(log_2.time, rad2deg(log_2.theta_cmd),'LineWidth',1.2,'Color','k'); hold on;
% plate, no comp
plot(log_1.time, rad2deg(log_1.theta_ref),'LineWidth',1.2,'Color','b',LineStyle='--'); hold on;
plot(log_1.time, rad2deg(log_1.theta_state),'LineWidth',1.2,'Color','b'); hold on;
% plate, comp
plot(log_2.time, rad2deg(log_2.theta_ref),'LineWidth',1.2,'Color','g',LineStyle='--'); hold on;
plot(log_2.time, rad2deg(log_2.theta_state),'LineWidth',1.2,'Color','g'); hold on;
grid minor;
legend('cmd','ref',legend_1,'ref',legend_2,'Interpreter','latex');
xlabel("time [sec]");
ylabel("$$\theta$$ [deg]");
title("Pitch Doublet Tracking");

%% P2 : Pseudo Control Input Generation
figure_2 = figure('Visible', show_fig2, 'Position', [100 200 1000 800]);
set(figure_2,'defaulttextinterpreter','latex');

tiledlayout(2,2);

ax1 = nexttile;
plot(log_1.time, rad2deg(log_1.theta_cmd),'LineWidth',1.2,'Color','k'); hold on;
% plate, no comp
plot(log_1.time, rad2deg(log_1.theta_ref),'LineWidth',1.2,'Color','b',LineStyle='--'); hold on;
plot(log_1.time, rad2deg(log_1.theta_state),'LineWidth',1.2,'Color','b'); hold on;
% plate, comp
plot(log_2.time, rad2deg(log_2.theta_ref),'LineWidth',1.2,'Color','g',LineStyle='--'); hold on;
plot(log_2.time, rad2deg(log_2.theta_state),'LineWidth',1.2,'Color','g'); hold on;
grid minor;
legend('cmd','ref',legend_1,'ref',legend_2,'Interpreter','latex');
xlabel("time [sec]");
ylabel("$$\theta$$ [deg]");
title("Pitch Doublet Tracking");

ax2 = nexttile;
plot(log_1.time, (log_1.xd_state),'LineWidth',1.5,'Color','b',Marker='+'); hold on;
plot(log_1.time, (log_1.yd_state),'LineWidth',1.5,'Color','b',Marker='*'); hold on;
plot(log_2.time, (log_2.xd_state),'LineWidth',1.5,'Color','g',Marker='+'); hold on;
plot(log_2.time, (log_2.yd_state),'LineWidth',1.5,'Color','g',Marker='*'); hold on;
grid minor;
legend('Vx plate','Vy plate','Vx model','Vy model','Interpreter','latex');
xlabel("time [sec]");
ylabel("$$V$$ [m/sec]");
title("Velocity in Earth Frame");

ax3 = nexttile;
plot(log_1.time, log_1.qdd_ref,'LineWidth',1.0,'Color','k','LineStyle','--'); hold on;
plot(log_1.time, log_1.theta_att_err,'LineWidth',1.2,'Color','b'); hold on;
plot(log_1.time, log_1.q_rate_err,'LineWidth',1.2,'Color','r'); hold on;
plot(log_1.time, log_1.q_acc_err,'LineWidth',1.2,'Color','g'); hold on;
plot(log_1.time, log_1.q_jerk_comp,'LineWidth',1.2,'Color','m');
grid minor;
legend('ref','attitude','rate','acc','compensator','Interpreter','latex');
xlabel("time [sec]");
ylabel("$$\nu_{theta}$$ [deg/sec^3]");
title("Pseudo Control Input", legend_1);

ax4 = nexttile;
plot(log_2.time, log_2.qdd_ref,'LineWidth',1.0,'Color','k','LineStyle','--'); hold on;
plot(log_2.time, log_2.theta_att_err,'LineWidth',1.2,'Color','b'); hold on;
plot(log_2.time, log_2.q_rate_err,'LineWidth',1.2,'Color','r'); hold on;
plot(log_2.time, log_2.q_acc_err,'LineWidth',1.2,'Color','g'); hold on;
plot(log_2.time, log_2.q_jerk_comp,'LineWidth',1.2,'Color','m');
grid minor;
legend('ref','attitude','rate','acc','compensator','Interpreter','latex');
xlabel("time [sec]");
ylabel("$$\nu_{theta}$$ [deg/sec^3]");
title("Pseudo Control Input", legend_2);

linkaxes([ax1,ax2,ax3,ax4], 'x');

%% P3 : Complementary filters state estimation

figure_3 = figure('Visible', show_fig3, 'Position', [100 200 1000 800]);
set(figure_3,'defaulttextinterpreter','latex');

tiledlayout(2,2);

ax1 = nexttile;
plot(log_1.time, (log_1.qd_ref),'LineWidth',1.5,'Color','g'); hold on;
plot(log_1.time, (log_1.qd_state_f),'LineWidth',1.2,'Color','m'); hold on;
plot(log_1.time, (log_1.qd_estimated_f),'LineWidth',1.2,'Color','r'); hold on;
plot(log_1.time, (log_1.qd_state_f_undelayed),'LineWidth',1.2,'Color','b'); 
grid minor;
legend('ref','state filt','estimated filt','undelayed','Interpreter','latex');
xlabel("time [sec]");
ylabel("$$r_d$$ [deg/sec^2]");
title("Complementary Filter Performance - ",legend_1);

ax2 = nexttile;
plot(log_2.time, (log_2.qd_ref),'LineWidth',1.5,'Color','g'); hold on;
plot(log_2.time, (log_2.qd_state_f),'LineWidth',1.2,'Color','m'); hold on;
plot(log_2.time, (log_2.qd_estimated_f),'LineWidth',1.2,'Color','r'); hold on;
plot(log_2.time, (log_2.qd_state_f_undelayed),'LineWidth',1.2,'Color','b'); 
grid minor;
legend('ref','state filt','estimated filt','undelayed','Interpreter','latex');
xlabel("time [sec]");
ylabel("$$r_d$$ [deg/sec^2]");
title("Complementary Filter Performance - ",legend_2);

ax3 = nexttile;
plot(log_1.time, (log_1.xd_state_f),'LineWidth',1.5,'Color','b',Marker='+'); hold on;
plot(log_1.time, (log_1.yd_state_f),'LineWidth',1.5,'Color','b',Marker='*'); hold on;
plot(log_1.time, (log_1.zd_state_f),'LineWidth',1.5,'Color','b'); hold on;
plot(log_2.time, (log_2.xd_state_f),'LineWidth',1.5,'Color','g',Marker='+'); hold on;
plot(log_2.time, (log_2.yd_state_f),'LineWidth',1.5,'Color','g',Marker='*'); hold on;
plot(log_2.time, (log_2.zd_state_f),'LineWidth',1.5,'Color','g'); hold on;
yline(0);
grid minor;
legend('Vx plate','Vy plate','Vz plate','Vx model','Vy model','Vz model','Interpreter','latex');
xlabel("time [sec]");
ylabel("$$V$$ [m/sec]");
title("Velocity in Earth Frame");

ax4 = nexttile;
plot(log_1.time, (log_1.theta_state),'LineWidth',1.5,'Color','b'); hold on;
plot(log_2.time, (log_2.theta_state),'LineWidth',1.5,'Color','r');
grid minor;
legend(legend_1,legend_2,'Interpreter','latex');
xlabel("time [sec]");
ylabel("$$\theta$$ [deg]");
title("Pitch Attitude");

linkaxes([ax1,ax2,ax3,ax4], 'x');

%% P4 : Pitch Jerk Generation

figure_4 = figure('Visible', show_fig4, 'Position', [100 200 1000 800]);
set(figure_4,'defaulttextinterpreter','latex');

tiledlayout(3,1);

ax1 = nexttile;
plot(log_1.time, (log_1.q_jerk_comp),'LineWidth',1.5,'Color','g'); hold on;
plot(log_2.time, (log_2.q_jerk_comp),'LineWidth',1.5,'Color','m');
grid minor;
legend(legend_1,legend_2,'Interpreter','latex');
xlabel("time [sec]");
ylabel("$$qdd_{comp}$$ [deg/sec^3]");
title("Compensation Signal");

ax2 = nexttile;
plot(log_1.time, (log_1.xd_state),'LineWidth',1.5,'Color','b',Marker='+'); hold on;
plot(log_1.time, (log_1.yd_state),'LineWidth',1.5,'Color','b',Marker='*'); hold on;
plot(log_2.time, (log_2.xd_state),'LineWidth',1.5,'Color','g',Marker='+'); hold on;
plot(log_2.time, (log_2.yd_state),'LineWidth',1.5,'Color','g',Marker='*'); hold on;
grid minor;
legend('Vx plate','Vy plate','Vx model','Vy model','Interpreter','latex');
xlabel("time [sec]");
ylabel("$$V$$ [m/sec]");
title("Velocity in Earth Frame");

ax3 = nexttile;
plot(log_1.time, (log_1.theta_state),'LineWidth',1.5,'Color','b'); hold on;
plot(log_2.time, (log_2.theta_state),'LineWidth',1.5,'Color','r');
grid minor;
legend(legend_1,legend_2,'Interpreter','latex');
xlabel("time [sec]");
ylabel("$$\theta$$ [deg]");
title("Pitch Attitude");

linkaxes([ax1,ax2,ax3], 'x');

%% P5 : Complementary filter for Model Based Solution

figure_5 = figure('Visible', show_fig5, 'Position', [100 200 1000 800]);
set(figure_5,'defaulttextinterpreter','latex');

tiledlayout(2,1);

ax1 = nexttile;
plot(log_2.time, (log_2.qd_ref),'LineWidth',1.5,'Color','g'); hold on;
plot(log_2.time, (log_2.qd_state_f),'LineWidth',1.2,'Color','m'); hold on;
plot(log_2.time, (log_2.qd_estimated_f),'LineWidth',1.2,'Color','r'); hold on;
plot(log_2.time, (log_2.qd_state_f_undelayed),'LineWidth',1.2,'Color','b'); 
grid minor;
legend('ref','state filt','estimated filt','undelayed','Interpreter','latex');
xlabel("time [sec]");
ylabel("$$r_d$$ [deg/sec^2]");
title("Complementary Filter Performance");

ax2 = nexttile;
plot(log_2.time, rad2deg(log_2.theta_state),'LineWidth',1.2,'Color','k'); hold on;
grid minor;
legend('cmd','ref','state','undelayed','Interpreter','latex');
xlabel("time [sec]");
ylabel("$$\theta$$ [deg]");
title("Theta Tracking");

linkaxes([ax1,ax2], 'x');

%% P6 : Pseudo Control Input

figure_6 = figure('Visible', show_fig6, 'Position', [100 200 1000 800]);
set(figure_6,'defaulttextinterpreter','latex');

tiledlayout(2,1);

ax1 = nexttile;
plot(log_1.time, (log_1.theta_state),'LineWidth',1.5,'Color','b'); hold on;
plot(log_2.time, (log_2.theta_state),'LineWidth',1.5,'Color','r');
grid minor;
legend(legend_1,legend_2,'Interpreter','latex');
xlabel("time [sec]");
ylabel("$$\theta$$ [deg]");
title("Pitch Attitude");

ax2 = nexttile;
plot(log_1.time, (log_1.v_3),'LineWidth',1.5,'Color','b'); hold on;
plot(log_2.time, (log_2.v_3),'LineWidth',1.5,'Color','r');
grid minor;
legend(legend_1,legend_2,'Interpreter','latex');
xlabel("time [sec]");
ylabel("$$v$$ [m/sec]");
title("Velocity in Earth Frame");

linkaxes([ax1,ax2], 'x');