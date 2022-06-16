%% Plotter function for infinite trajectory tracking performance

%%%  0 : Useful Data

dt = 0.002;             %[sec]
freq = 1/dt;            %[sec]

start_log = 0.05;
end_log = 0.99;

%%%  1 : Process Data from Logger

% log_indi = logger('14_04_22/inf_indi_no_drag', start_log, end_log);
% log_asc_indi = logger('14_04_22/inf_asc_indi_no_drag', start_log, end_log);

log_indi = logger('29_04_22_real/indi_30_10', start_log, end_log);
log_asc_indi = logger('29_04_22_real/asc_30_10', start_log, end_log);

%%% 3 : control panel on showing figures or not

show_fig1 = false;
show_fig2 = true;
show_fig3 = true;

%% P1: plot the 2D position of the vehicle

figure_1 = figure('Visible', show_fig1, 'Position', [100 200 1000 800]);
set(figure_1,'defaulttextinterpreter','latex');

n_rows = 3;
n_cols = 3;

% shift time for second data
% log_asc_indi_shift.time = log_asc_indi.time - 8.5507;
log_asc_indi_shift.time = log_asc_indi.time + 95.8594;

subplot(n_rows,n_cols,1);
plot(log_indi.x_setpoint, log_indi.y_setpoint, 'LineWidth',1.5,'Color','r'); hold on;
plot(log_indi.x_state, log_indi.y_state,'LineWidth',1.5,'Color','b'); hold on;
plot(log_asc_indi.x_state, log_asc_indi.y_state,'LineWidth',1.5,'Color','g');
grid minor;
legend("ground truth","INDI","ASCINDI",'Interpreter','latex');
xlabel("$$x$$ in NED [m]");
ylabel("$$y$$ in NED [m]");
title("Position Tracking");

subplot(n_rows,n_cols,2);
plot(log_indi.time, log_indi.xd_ref, 'LineWidth',1.5,'Color','r'); hold on;
plot(log_indi.time, log_indi.xd_state,'LineWidth',1.5,'Color','b'); hold on;
plot(log_asc_indi_shift.time, log_asc_indi.xd_state,'LineWidth',1.5,'Color','g');
grid minor;
title("Horizontal Velocity Tracking");
legend("ground truth","INDI","ASCINDI",'Interpreter','latex');
xlabel("time [sec]");
ylabel("$$V_x$$ in NED [m]");
title("Horizontal Velocity Tracking");

subplot(n_rows,n_cols,3);
plot(log_indi.time, log_indi.yd_ref, 'LineWidth',1.5,'Color','r'); hold on;
plot(log_indi.time, log_indi.yd_state,'LineWidth',1.5,'Color','b'); hold on;
plot(log_asc_indi_shift.time, log_asc_indi.yd_state,'LineWidth',1.5,'Color','g');
grid minor;
title("Vertical Velocity Tracking");
legend("ground truth","INDI","ASCINDI",'Interpreter','latex');
xlabel("time [sec]");
ylabel("$$V_y$$ in NED [m]");
title("Lateral Velocity Tracking");

subplot(n_rows,n_cols,4);
plot(log_indi.time, log_indi.phi_state,'LineWidth',1.5,'Color','b'); hold on;
plot(log_indi.time, log_indi.phi_ref,'LineWidth',1.5,'Color','r'); hold on;
plot(log_asc_indi_shift.time, log_asc_indi.phi_state,'LineWidth',1.5,'Color','g');
grid minor;
legend("INDI","INDI ref","ASCINDI ref","ASCINDI",'Interpreter','latex');
xlabel("time [sec]");
ylabel("$$\phi$$ in NED [rad]");
title("Roll Tracking");

subplot(n_rows,n_cols,5);
plot(log_indi.time, log_indi.theta_state,'LineWidth',1.5,'Color','b'); hold on;
plot(log_indi.time, log_indi.theta_ref,'LineWidth',1.5,'Color','r'); hold on;
plot(log_asc_indi_shift.time, log_asc_indi.theta_state,'LineWidth',1.5,'Color','g');
grid minor;
legend("INDI","INDI ref","ASCINDI ref","ASCINDI",'Interpreter','latex');
xlabel("time [sec]");
ylabel("$$\theta$$ in NED [rad]");
title("Pitch Tracking");

subplot(n_rows,n_cols,6);
plot(log_indi.time, log_indi.psi_cmd, 'LineWidth',1.5,'Color','r'); hold on;
plot(log_indi.time, log_indi.psi_state,'LineWidth',1.5,'Color','b'); hold on;
plot(log_asc_indi_shift.time, log_asc_indi.psi_state,'LineWidth',1.5,'Color','g');
grid minor;
legend("ground truth", "INDI", "ASCINDI" ,'Interpreter','latex');
xlabel("time [sec]");
ylabel("$$\psi$$ [rad]");
title("Heading Tracking");

subplot(n_rows,n_cols,7);
plot(log_indi.time, log_indi.phi_err, 'LineWidth',1.5,'Color','r'); hold on;
plot(log_indi.time, log_indi.theta_err,'LineWidth',1.5,'Color','b'); hold on;
plot(log_indi.time, log_indi.phi_err,'LineWidth',1.5,'Color','g');
grid minor;
legend("$$\Delta\phi$$", "$$\Delta\theta$$", "$$\Delta\psi$$" ,'Interpreter','latex');
xlabel("time [sec]");
ylabel("$$\Delta$$ [rad]");
title("Attitude Error");

subplot(n_rows,n_cols,8);
plot(log_indi.time, log_indi.x_error, 'LineWidth',1.5,'Color','r'); hold on;
plot(log_indi.time, log_indi.y_error,'LineWidth',1.5,'Color','b'); hold on;
plot(log_indi.time, log_indi.z_error,'LineWidth',1.5,'Color','g');
grid minor;
legend("$$\Delta$$x", "$$\Delta$$y", "$$\Delta$$z" ,'Interpreter','latex');
xlabel("time [sec]");
ylabel("$$\Delta$$ [m]");
title("Position Error");

%% error plotting

figure_2 = figure('Visible', show_fig2, 'Position', [100 200 1000 800]);
set(figure_2,'defaulttextinterpreter','latex');

n_rows2 = 2;
n_cols2 = 3;

subplot(n_rows2,n_cols2,1);
plot(log_indi.time, log_indi.x_error,'LineWidth',1.5,'Color','b'); hold on;
plot(log_asc_indi_shift.time, log_asc_indi.x_error,'LineWidth',1.5,'Color','g');
grid minor;
legend("INDI","ASCINDI",'Interpreter','latex');
xlabel("$$\Delta x$$ in NED [m]");
ylabel("time [sec]");
title("X Error");

subplot(n_rows2,n_cols2,2);
plot(log_indi.time, log_indi.y_error,'LineWidth',1.5,'Color','b'); hold on;
plot(log_asc_indi_shift.time, log_asc_indi.y_error,'LineWidth',1.5,'Color','g');
grid minor;
legend("INDI","ASCINDI",'Interpreter','latex');
xlabel("$$\Delta y$$ in NED [m]");
ylabel("time [sec]");
title("Y Error");

subplot(n_rows2,n_cols2,3);
plot(log_indi.time, log_indi.z_error,'LineWidth',1.5,'Color','b'); hold on;
plot(log_asc_indi_shift.time, log_asc_indi.z_error,'LineWidth',1.5,'Color','g');
grid minor;
legend("INDI","ASCINDI",'Interpreter','latex');
xlabel("$$\Delta z$$ in NED [m]");
ylabel("time [sec]");
title("Z Error");

subplot(n_rows2,n_cols2,4);
plot(log_indi.time, log_indi.phi_err,'LineWidth',1.5,'Color','b'); hold on;
plot(log_asc_indi_shift.time, log_asc_indi.phi_err,'LineWidth',1.5,'Color','g');
grid minor;
legend("INDI","ASCINDI",'Interpreter','latex');
xlabel("$$\Delta \phi$$ in NED [m]");
ylabel("time [sec]");
title("Phi Error");

subplot(n_rows2,n_cols2,5);
plot(log_indi.time, log_indi.theta_err,'LineWidth',1.5,'Color','b'); hold on;
plot(log_asc_indi_shift.time, log_asc_indi.x_error,'LineWidth',1.5,'Color','g');
grid minor;
legend("INDI","ASCINDI",'Interpreter','latex');
xlabel("$$\Delta \theta$$ in NED [m]");
ylabel("time [sec]");
title("Theta Error");

subplot(n_rows2,n_cols2,6);
plot(log_indi.time, log_indi.psi_err,'LineWidth',1.5,'Color','b'); hold on;
plot(log_asc_indi_shift.time, log_asc_indi.psi_err,'LineWidth',1.5,'Color','g');
grid minor;
legend("INDI","ASCINDI",'Interpreter','latex');
xlabel("$$\Delta \psi$$ in NED [m]");
ylabel("time [sec]");
title("Psi Error");

%% P3 : simple 2D position track

figure_3 = figure('Visible', show_fig3, 'Position', [100 200 1000 800]);

subplot(2,2,[1,2]);
set(figure_3,'defaulttextinterpreter','latex');
plot(log_indi.x_state, log_indi.y_state,'LineWidth',1.5,'Color','b'); hold on;
plot(log_asc_indi.x_state, log_asc_indi.y_state,'LineWidth',1.5,'Color','g'); hold on;
plot(log_indi.x_setpoint, log_indi.y_setpoint, 'LineWidth',1.5,'Color','r');
grid minor;
legend("INDI","ASCINDI","ground truth",'Interpreter','latex');
xlabel("$$x$$ in NED [m]");
ylabel("$$y$$ in NED [m]");
title("Position Tracking");

indi_x_error = abs(log_indi.x_setpoint - log_indi.x_state);
indi_y_error = abs(log_indi.y_setpoint - log_indi.y_state);
asc_indi_x_error = abs(log_asc_indi.x_setpoint - log_asc_indi.x_state);
asc_indi_y_error = abs(log_asc_indi.y_setpoint - log_asc_indi.y_state);

subplot(2,2,3);
set(figure_3,'defaulttextinterpreter','latex');
plot(log_indi.time, indi_x_error,'LineWidth',1.5,'Color','r'); hold on;
plot(log_asc_indi_shift.time, asc_indi_x_error,'LineWidth',1.5,'Color','b');
grid minor;
legend("INDI","ASCINDI",'Interpreter','latex');
xlabel("time [sec]");
ylabel("$$\Delta x$$ in NED [m]");
title("X Error");

subplot(2,2,4);
set(figure_3,'defaulttextinterpreter','latex');
plot(log_indi.time, indi_y_error,'LineWidth',1.5,'Color','r'); hold on;
plot(log_asc_indi_shift.time, asc_indi_y_error,'LineWidth',1.5,'Color','b');
grid minor;
legend("INDI","ASCINDI",'Interpreter','latex');
xlabel("time [sec]");
ylabel("$$\Delta y$$ in NED [m]");
title("Y Error");






