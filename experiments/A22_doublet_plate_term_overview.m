%% Doublet 

%%% 1 : Process Data from Logger

folder = '06_01_22_doublet_test/';

start_log = 0.01;
end_log = 0.99;

log_1 = logger(strcat(folder,'doublet_multi'), start_log, end_log);

legend_1 = 'No Compensation';
legend_2 = 'Compensation';

%%% 2 : control panel on showing figures or not

show_fig1 = true;

%% P1 : Tracking Performance Overview
figure_1 = figure('Visible', show_fig1, 'Position', [100 200 1000 800]);
set(figure_1,'defaulttextinterpreter','latex');

tiledlayout(3,2);

ax1 = nexttile;
plot(log_1.time, rad2deg(log_1.theta_cmd),'LineWidth',1.2,'Color','k'); hold on;
plot(log_1.time, rad2deg(log_1.theta_ref),'LineWidth',1.2,'Color','r'); hold on;
plot(log_1.time, rad2deg(log_1.theta_state),'LineWidth',1.2,'Color','b',LineStyle='--');
grid minor;
legend('cmd','ref','state','Interpreter','latex');
xlabel("time [sec]");
ylabel("$$\theta$$ [deg]");
title("Pitch Doublet Tracking");

ax2 = nexttile;
plot(log_1.time, (log_1.act_state_1),'LineWidth',1.2,'Color','b'); hold on;
plot(log_1.time, (log_1.act_state_2),'LineWidth',1.2,'Color','r'); hold on;
plot(log_1.time, (log_1.act_state_3),'LineWidth',1.2,'Color','g'); hold on;
plot(log_1.time, (log_1.act_state_4),'LineWidth',1.2,'Color','m'); hold on;
grid minor;
legend('1','2','3','4','Interpreter','latex');
xlabel("time [sec]");
ylabel("$$dtheta$$ [deg/sec]");
title("Euler Rate (Theta)");

ax3 = nexttile;
plot(log_1.time, rad2deg(log_1.theta_state),'LineWidth',1.2,'Color','b');
grid minor;
xlabel("time [sec]");
ylabel("$$theta$$ [deg]");
title("Euler (Theta)");

ax4 = nexttile;
plot(log_1.time, rad2deg(log_1.xd_state),'LineWidth',1.2,'Color','b'); hold on;
plot(log_1.time, rad2deg(log_1.yd_state),'LineWidth',1.2,'Color','r');
grid minor;
legend('x','y','Interpreter','latex');
xlabel("time [sec]");
ylabel("$$V$$ [m/sec]");
title("Earth Velocity");

ax5 = nexttile;
plot(log_1.time, rad2deg(log_1.xddd_f_undelayed),'LineWidth',1.2,'Color','b'); hold on;
plot(log_1.time, rad2deg(log_1.yddd_f_undelayed),'LineWidth',1.2,'Color','r'); hold on;
yline(0);
grid minor;
legend('x','y','Interpreter','latex');
xlabel("time [sec]");
ylabel("$$A$$ [m/sec^2]");
title("Earth Acceleration");

ax6 = nexttile;
plot(log_1.time, rad2deg(log_1.q_jerk_comp),'LineWidth',1.2,'Color','r'); hold on;
yline(0);
grid minor;
legend('comp','Interpreter','latex');
xlabel("time [sec]");
ylabel("$$J$$ [m/sec^3]");
title("Compensation Term (Theta)");

linkaxes([ax1,ax2,ax3,ax4,ax5,ax6], 'x');