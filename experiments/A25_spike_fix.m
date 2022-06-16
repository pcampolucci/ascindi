%% Doublet 

%%% 1 : Process Data from Logger

folder = '06_03_22_fix_issues/';

start_log = 0.1;
end_log = 0.99;

log_1 = logger(strcat(folder,'test'), start_log, end_log);

%%% 2 : control panel on showing figures or not

show_fig3 = true;

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
plot(log_1.time, (log_1.qd_ref),'LineWidth',1.5,'Color','g'); hold on;
plot(log_1.time, (log_1.qd_state),'LineWidth',1.2,'Color','m'); hold on;
plot(log_1.time, (log_1.qd_estimated),'LineWidth',1.2,'Color','r');
grid minor;
legend('ref','state','estimated','Interpreter','latex');
xlabel("time [sec]");
ylabel("$$r_d$$ [deg/sec^2]");
title("Complementary Filter Performance - ",legend_1);

ax3 = nexttile;
plot(log_1.time, (log_1.xd_state_f),'LineWidth',1.5,'Color','b'); hold on;
plot(log_1.time, (log_1.yd_state_f),'LineWidth',1.5,'Color','r'); hold on;
plot(log_1.time, (log_1.zd_state_f),'LineWidth',1.5,'Color','g'); hold on;
yline(0);
grid minor;
legend('Vx plate','Vy plate','Vz plate','Interpreter','latex');
xlabel("time [sec]");
ylabel("$$V$$ [m/sec]");
title("Velocity in Earth Frame");

ax4 = nexttile;
plot(log_1.time, (log_1.qd_estimated),'LineWidth',1.2,'Color','b'); hold on;
plot(log_1.time, (log_1.qd_estimated_f),'LineWidth',1.2,'Color','r');
grid minor;
legend('estimated','estimated_f','Interpreter','latex');
xlabel("time [sec]");
ylabel("$$r_d$$ [deg/sec^2]");
title("Complementary Filter Performance - ",legend_1);

linkaxes([ax1,ax2,ax3,ax4], 'x');