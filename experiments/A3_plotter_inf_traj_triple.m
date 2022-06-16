%% Plotter function for infinite trajectory tracking performance

%%%  0 : Useful Data

dt = 0.002;             %[sec]
freq = 1/dt;            %[sec]

start_log = 0.05;
end_log = 0.99;

%%%  1 : Process Data from Logger

folder = '25_04_22_real/';

log_indi = logger(strcat(folder,'indi_50_9'), start_log, end_log);
log_asc_indi = logger(strcat(folder,'indi_asc_50_9'), start_log, end_log);
log_asc_indi_plus = logger(strcat(folder,'indi_asc_plus_50_9'), start_log, end_log);

%%% 3 : control panel on showing figures or not

show_fig1 = false;
show_fig2 = false;
show_fig3 = false;
show_fig4 = false;
show_fig5 = false;
show_fig6 = true;

%% P1: plot the 2D position of the vehicle

figure_1 = figure('Visible', show_fig1, 'Position', [100 200 1000 800]);
set(figure_1,'defaulttextinterpreter','latex');

n_rows = 2;
n_cols = 2;

% shift time for second data
log_asc_indi_shift.time = log_asc_indi.time - 34.7256;
log_asc_indi_plus_shift.time = log_asc_indi_plus.time - 62.202;
% log_asc_indi_plus_shift.time = log_asc_indi_plus.time - 452.191;

subplot(n_rows,n_cols,[1,2]);
plot(log_indi.x_setpoint, log_indi.y_setpoint, 'LineWidth',1.5,'Color','k'); hold on;
plot(log_indi.x_state, log_indi.y_state,'LineWidth',1.5,'Color','b'); hold on;
plot(log_asc_indi.x_state, log_asc_indi.y_state,'LineWidth',1.5,'Color','g'); hold on;
plot(log_asc_indi_plus.x_state, log_asc_indi_plus.y_state,'LineWidth',1.5,'Color','r');
grid minor;
legend("ground truth","INDI","ASCINDI","ASCINDI+",'Interpreter','latex');
xlabel("$$x$$ in NED [m]");
ylabel("$$y$$ in NED [m]");
title("Position Tracking");

subplot(n_rows,n_cols,3);
plot(log_indi.time, log_indi.xd_ref, 'LineWidth',1.5,'Color','k','LineStyle','--'); hold on;
% plot(log_asc_indi_shift.time, log_asc_indi.xd_ref, 'LineWidth',1.5,'Color','k','LineStyle','--'); hold on;
% plot(log_asc_indi_plus_shift.time, log_asc_indi_plus.xd_ref, 'LineWidth',1.5,'Color','k','LineStyle','--'); hold on;
plot(log_indi.time, log_indi.xd_state,'LineWidth',1.5,'Color','b'); hold on;
plot(log_asc_indi_shift.time, log_asc_indi.xd_state,'LineWidth',1.5,'Color','g'); hold on;
plot(log_asc_indi_plus_shift.time, log_asc_indi_plus.xd_state,'LineWidth',1.5,'Color','r');
grid minor;
title("Horizontal Velocity Tracking");
legend("ground truth","INDI","ASCINDI","ASCINDI+",'Interpreter','latex');
xlabel("time [sec]");
ylabel("$$V_x$$ in NED [m]");

subplot(n_rows,n_cols,4);
plot(log_indi.time, log_indi.yd_ref, 'LineWidth',1.5,'Color','k','LineStyle','--'); hold on;
plot(log_indi.time, log_indi.yd_state,'LineWidth',1.5,'Color','b'); hold on;
plot(log_asc_indi_shift.time, log_asc_indi.yd_state,'LineWidth',1.5,'Color','g'); hold on;
plot(log_asc_indi_plus_shift.time, log_asc_indi_plus.yd_state,'LineWidth',1.5,'Color','r');
grid minor;
title("Vertical Velocity Tracking");
legend("ground truth","INDI","ASCINDI","ASCINDI+",'Interpreter','latex');
xlabel("time [sec]");
ylabel("$$V_y$$ in NED [m]");

%% P2: position tracking

figure_2 = figure('Visible', show_fig2, 'Position', [100 200 1000 800]);
set(figure_2,'defaulttextinterpreter','latex');

subplot(2,1,1);
plot(log_indi.time, log_indi.x_setpoint, 'LineWidth',1.5,'Color','k','LineStyle','--'); hold on;
% plot(log_asc_indi_shift.time, log_asc_indi.x_setpoint, 'LineWidth',1.5,'Color','g','LineStyle','--'); hold on;
% plot(log_asc_indi_plus_shift.time, log_asc_indi_plus.x_setpoint, 'LineWidth',1.5,'Color','r','LineStyle','--'); hold on;
plot(log_indi.time, log_indi.x_state,'LineWidth',1.5,'Color','b'); hold on;
plot(log_asc_indi_shift.time, log_asc_indi.x_state,'LineWidth',1.5,'Color','g'); hold on;
plot(log_asc_indi_plus_shift.time, log_asc_indi_plus.x_state,'LineWidth',1.5,'Color','r');
grid minor;
title("Horizontal Position Tracking");
legend("ground truth","INDI","ASCINDI","ASCINDI+",'Interpreter','latex');
xlabel("time [sec]");
ylabel("$$x$$ in NED [m]");

subplot(2,1,2);
plot(log_indi.time, log_indi.y_setpoint, 'LineWidth',1.5,'Color','k','LineStyle','--'); hold on;
% plot(log_asc_indi_shift.time, log_asc_indi.y_setpoint, 'LineWidth',1.5,'Color','g','LineStyle','--'); hold on;
% plot(log_asc_indi_plus_shift.time, log_asc_indi_plus.y_setpoint, 'LineWidth',1.5,'Color','r','LineStyle','--'); hold on;
plot(log_indi.time, log_indi.y_state,'LineWidth',1.5,'Color','b'); hold on;
plot(log_asc_indi_shift.time, log_asc_indi.y_state,'LineWidth',1.5,'Color','g'); hold on;
plot(log_asc_indi_plus_shift.time, log_asc_indi_plus.y_state,'LineWidth',1.5,'Color','r');
grid minor;
title("Lateral Position Tracking");
legend("ground truth","INDI","ASCINDI","ASCINDI+",'Interpreter','latex');
xlabel("time [sec]");
ylabel("$$y$$ in NED [m]");

%% P3: velocity tracking

figure_3 = figure('Visible', show_fig3, 'Position', [100 200 1000 800]);
set(figure_3,'defaulttextinterpreter','latex');

subplot(2,1,1);
plot(log_indi.time, log_indi.xd_ref, 'LineWidth',1.5,'Color','k','LineStyle','--'); hold on;
plot(log_indi.time, log_indi.xd_state,'LineWidth',1.5,'Color','b'); hold on;
plot(log_asc_indi_shift.time, log_asc_indi.xd_state,'LineWidth',1.5,'Color','g'); hold on;
plot(log_asc_indi_plus_shift.time, log_asc_indi_plus.xd_state,'LineWidth',1.5,'Color','r');
grid minor;
title("Horizontal Velocity Tracking");
legend("ground truth","INDI","ASCINDI","ASCINDI+",'Interpreter','latex');
xlabel("time [sec]");
ylabel("$$V_x$$ in NED [m]");

subplot(2,1,2);
plot(log_indi.time, log_indi.yd_ref, 'LineWidth',1.5,'Color','k','LineStyle','--'); hold on;
plot(log_indi.time, log_indi.yd_state,'LineWidth',1.5,'Color','b'); hold on;
plot(log_asc_indi_shift.time, log_asc_indi.yd_state,'LineWidth',1.5,'Color','g'); hold on;
plot(log_asc_indi_plus_shift.time, log_asc_indi_plus.yd_state,'LineWidth',1.5,'Color','r');
grid minor;
title("Vertical Velocity Tracking");
legend("ground truth","INDI","ASCINDI","ASCINDI+",'Interpreter','latex');
xlabel("time [sec]");
ylabel("$$V_y$$ in NED [m]");

%% P4 : velocity error

figure_4 = figure('Visible', show_fig4, 'Position', [100 200 1000 800]);

indi_x_error = abs(log_indi.x_setpoint - log_indi.x_state);
indi_y_error = abs(log_indi.y_setpoint - log_indi.y_state);
asc_indi_x_error = abs(log_asc_indi.x_setpoint - log_asc_indi.x_state);
asc_indi_y_error = abs(log_asc_indi.y_setpoint - log_asc_indi.y_state);
asc_indi_plus_x_error = abs(log_asc_indi_plus.x_setpoint - log_asc_indi_plus.x_state);
asc_indi_plus_y_error = abs(log_asc_indi_plus.y_setpoint - log_asc_indi_plus.y_state);

subplot(2,1,1);
set(figure_4,'defaulttextinterpreter','latex');
plot(log_indi.time, indi_x_error,'LineWidth',1.5,'Color','r'); hold on;
plot(log_asc_indi_shift.time, asc_indi_x_error,'LineWidth',1.5,'Color','b'); hold on;
plot(log_asc_indi_plus_shift.time, asc_indi_plus_x_error,'LineWidth',1.5,'Color','g');
grid minor;
legend("INDI","ASCINDI","ASCINDI+",'Interpreter','latex');
xlabel("time [sec]");
ylabel("$$\Delta x$$ in NED [m]");
title("X Error");

subplot(2,1,2);
set(figure_4,'defaulttextinterpreter','latex');
plot(log_indi.time, indi_y_error,'LineWidth',1.5,'Color','r'); hold on;
plot(log_asc_indi_shift.time, asc_indi_y_error,'LineWidth',1.5,'Color','b'); hold on;
plot(log_asc_indi_plus_shift.time, asc_indi_plus_y_error,'LineWidth',1.5,'Color','g');
grid minor;
legend("INDI","ASCINDI","ASCINDI+",'Interpreter','latex');
xlabel("time [sec]");
ylabel("$$\Delta y$$ in NED [m]");
title("Y Error");

%% P5: theta/phi tracking

figure_5 = figure('Visible', show_fig5, 'Position', [100 200 1000 800]);
set(figure_5,'defaulttextinterpreter','latex');

subplot(2,1,1);
plot(log_indi.time, log_indi.theta_ref, 'LineWidth',1.5,'Color','k','LineStyle','--'); hold on;
plot(log_indi.time, log_indi.theta_state,'LineWidth',1.5,'Color','b'); hold on;
plot(log_asc_indi_shift.time, log_asc_indi.theta_state,'LineWidth',1.5,'Color','g'); hold on;
plot(log_asc_indi_plus_shift.time, log_asc_indi_plus.theta_state,'LineWidth',1.5,'Color','r');
grid minor;
title("Theta Tracking");
legend("ground truth","INDI","ASCINDI","ASCINDI+",'Interpreter','latex');
xlabel("time [sec]");
ylabel("$$\theta$$ in NED [m]");

subplot(2,1,2);
plot(log_indi.time, log_indi.phi_ref, 'LineWidth',1.5,'Color','k','LineStyle','--'); hold on;
plot(log_indi.time, log_indi.phi_state,'LineWidth',1.5,'Color','b'); hold on;
plot(log_asc_indi_shift.time, log_asc_indi.phi_state,'LineWidth',1.5,'Color','g'); hold on;
plot(log_asc_indi_plus_shift.time, log_asc_indi_plus.phi_state,'LineWidth',1.5,'Color','r');
grid minor;
title("Phi Tracking");
legend("ground truth","INDI","ASCINDI","ASCINDI+",'Interpreter','latex');
xlabel("time [sec]");
ylabel("$$\phi$$ in NED [m]");

%% P6 : velocity error

figure_6 = figure('Visible', show_fig6, 'Position', [100 200 1000 800]);

indi_dx_error = abs(log_indi.xd_ref - log_indi.xd_state);
indi_dy_error = abs(log_indi.yd_ref - log_indi.yd_state);
asc_indi_dx_error = abs(log_asc_indi.xd_ref - log_asc_indi.xd_state);
asc_indi_dy_error = abs(log_asc_indi.yd_ref - log_asc_indi.yd_state);
asc_indi_plus_dx_error = abs(log_asc_indi_plus.xd_ref - log_asc_indi_plus.xd_state);
asc_indi_plus_dy_error = abs(log_asc_indi_plus.yd_ref - log_asc_indi_plus.yd_state);

subplot(2,1,1);
set(figure_6,'defaulttextinterpreter','latex');
plot(log_indi.time, indi_dx_error,'LineWidth',1.5,'Color','r'); hold on;
plot(log_asc_indi_shift.time, asc_indi_dx_error,'LineWidth',1.5,'Color','b'); hold on;
plot(log_asc_indi_plus_shift.time, asc_indi_plus_dx_error,'LineWidth',1.5,'Color','g');
grid minor;
legend("INDI","ASCINDI","ASCINDI+",'Interpreter','latex');
xlabel("time [sec]");
ylabel("$$\Delta V_x$$ in NED [m]");
title("Vx Error");

subplot(2,1,2);
set(figure_6,'defaulttextinterpreter','latex');
plot(log_indi.time, indi_y_error,'LineWidth',1.5,'Color','r'); hold on;
plot(log_asc_indi_shift.time, asc_indi_y_error,'LineWidth',1.5,'Color','b'); hold on;
plot(log_asc_indi_plus_shift.time, asc_indi_plus_y_error,'LineWidth',1.5,'Color','g');
grid minor;
legend("INDI","ASCINDI","ASCINDI+",'Interpreter','latex');
xlabel("time [sec]");
ylabel("$$\Delta V_y$$ in NED [m]");
title("Vy Error");






