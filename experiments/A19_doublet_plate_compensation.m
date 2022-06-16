%% Doublet 

%%% 1 : Process Data from Logger

folder = '05_25_22_doublet/';

start_log = 0.05;
end_log = 0.3;

log_1 = logger(strcat(folder,'doublet_no_plate'), start_log, end_log);
log_2 = logger(strcat(folder,'doublet_plate_no_model'), start_log, end_log);
log_3 = logger(strcat(folder,'doublet_plate_model'), start_log, end_log);

legend_1 = 'No Plate';
legend_2 = 'No Compensation';
legend_3 = 'Compensation';

% time shift between signals
shift_no_comp = 76.0293;
shift_comp = 28.525;

%%% 2 : control panel on showing figures or not

show_fig1 = true;
show_fig2 = true;
show_fig3 = false;
show_fig9 = false;

%%% 3 : align time
log_2.time = log_2.time + shift_no_comp;
log_3.time = log_3.time + shift_comp;

%% P1 : Overview of Tracking Performance
figure_1 = figure('Visible', show_fig1, 'Position', [100 200 1000 800]);
set(figure_1,'defaulttextinterpreter','latex');

tiledlayout(3,1);

ax1 = nexttile;
plot(log_1.time, rad2deg(log_1.theta_cmd),'LineWidth',1.2,'Color','k'); hold on;
% no plate, no comp
plot(log_1.time, rad2deg(log_1.theta_ref),'LineWidth',1.2,'Color','b',LineStyle='--'); hold on;
plot(log_1.time, rad2deg(log_1.theta_state),'LineWidth',1.2,'Color','b'); hold on;
% plate, no comp
plot(log_2.time, rad2deg(log_2.theta_ref),'LineWidth',1.2,'Color','g',LineStyle='--'); hold on;
plot(log_2.time, rad2deg(log_2.theta_state),'LineWidth',1.2,'Color','g'); hold on;
% plate, no comp
plot(log_3.time, rad2deg(log_3.theta_ref),'LineWidth',1.2,'Color','r',LineStyle='--'); hold on;
plot(log_3.time, rad2deg(log_3.theta_state),'LineWidth',1.2,'Color','r');
grid minor;
legend('cmd','ref',legend_1,'ref',legend_2,'ref',legend_3,'Interpreter','latex');
xlabel("time [sec]");
ylabel("$$\theta$$ [deg]");
title("Pitch Doublet Tracking");

ax2 = nexttile;
plot(log_1.time, log_1.act_state_1,'LineWidth',1.2,'Color','b','LineStyle','--'); hold on;
plot(log_1.time, log_1.act_state_2,'LineWidth',1.2,'Color','b','LineStyle','-.'); hold on;
plot(log_1.time, log_1.act_state_3,'LineWidth',1.2,'Color','b','LineStyle',':'); hold on;
plot(log_1.time, log_1.act_state_4,'LineWidth',1.2,'Color','b','Marker','.'); hold on;
plot(log_2.time, log_2.act_state_1,'LineWidth',1.2,'Color','g','LineStyle','--'); hold on;
plot(log_2.time, log_2.act_state_2,'LineWidth',1.2,'Color','g','LineStyle','-.'); hold on;
plot(log_2.time, log_2.act_state_3,'LineWidth',1.2,'Color','g','LineStyle',':'); hold on;
plot(log_2.time, log_2.act_state_4,'LineWidth',1.2,'Color','g','Marker','.'); hold on;
plot(log_3.time, log_3.act_state_1,'LineWidth',1.2,'Color','r','LineStyle','--'); hold on;
plot(log_3.time, log_3.act_state_2,'LineWidth',1.2,'Color','r','LineStyle','-.'); hold on;
plot(log_3.time, log_3.act_state_3,'LineWidth',1.2,'Color','r','LineStyle',':'); hold on;
plot(log_3.time, log_3.act_state_4,'LineWidth',1.2,'Color','r','Marker','.'); hold on;
grid minor;
legend('1 plain','2 plain','3 plain','4 plain','1 plate','2 plate','3 plate','4 plate','1 model','2 model','3 model','4 model','Interpreter','latex');
xlabel("time [sec]");
ylabel("RPM");
title("Actuator States");

ax3 = nexttile;
% no plate
plot(log_1.time, (log_1.xd_state),'LineWidth',1.5,'Color','b',Marker='+'); hold on;
plot(log_1.time, (log_1.yd_state),'LineWidth',1.5,'Color','b',Marker='*'); hold on;
% plate no compensation
plot(log_2.time, (log_2.xd_state),'LineWidth',1.5,'Color','g',Marker='+'); hold on;
plot(log_2.time, (log_2.yd_state),'LineWidth',1.5,'Color','g',Marker='*'); hold on;
% plate compensation
plot(log_3.time, (log_3.xd_state),'LineWidth',1.5,'Color','r',Marker='+'); hold on;
plot(log_3.time, (log_3.yd_state),'LineWidth',1.5,'Color','r',Marker='*');
grid minor;
legend('Vx plain','Vy plain','Vx plate','Vy plate','Vx model','Vy model','Interpreter','latex');
xlabel("time [sec]");
ylabel("$$V$$ [m/sec]");
title("Velocity in Earth Frame");

linkaxes([ax1,ax2,ax3], 'x');

%% P2 : Pseudo Control Input Generation
figure_2 = figure('Visible', show_fig2, 'Position', [100 200 1000 800]);
set(figure_2,'defaulttextinterpreter','latex');

tiledlayout(3,1);

ax1 = nexttile;
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

ax2 = nexttile;
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

ax3 = nexttile;
plot(log_3.time, log_3.qdd_ref,'LineWidth',1.0,'Color','k','LineStyle','--'); hold on;
plot(log_3.time, log_3.theta_att_err,'LineWidth',1.2,'Color','b'); hold on;
plot(log_3.time, log_3.q_rate_err,'LineWidth',1.2,'Color','r'); hold on;
plot(log_3.time, log_3.q_acc_err,'LineWidth',1.2,'Color','g'); hold on;
plot(log_3.time, log_3.q_jerk_comp,'LineWidth',1.2,'Color','m');
grid minor;
legend('ref','attitude','rate','acc','compensator','Interpreter','latex');
xlabel("time [sec]");
ylabel("$$\nu_{theta}$$ [deg/sec^3]");
title("Pseudo Control Input", legend_3);

linkaxes([ax1,ax2,ax3], 'x');




