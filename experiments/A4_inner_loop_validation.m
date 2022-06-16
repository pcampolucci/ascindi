%% Plotter function for infinite trajectory tracking performance

%%%  0 : Useful Data
start_log = 0.05;
end_log = 0.99;

%%%  1 : Process Data from Logger

folder = '29_04_22_real/';

log_indi = logger(strcat(folder,'indi_50_10'), start_log, end_log);
log_asc = logger(strcat(folder,'asc_50_10'), start_log, end_log);

%%% 3 : control panel on showing figures or not

show_fig1 = true;
show_fig2 = false;
show_fig3 = false;

figure_1 = figure('Visible', show_fig1, 'Position', [100 200 1000 800]);
set(figure_1,'defaulttextinterpreter','latex');

n_rows = 2;
n_cols = 3;

% build error plots
indi_phi_err = abs(log_indi.phi_state - log_indi.phi_ref);
indi_theta_err = abs(log_indi.theta_state - log_indi.theta_ref);
indi_psi_err = abs(log_indi.psi_state - log_indi.psi_ref);
indi_p_err = abs(log_indi.p_state - log_indi.p_ref);
indi_q_err = abs(log_indi.q_state - log_indi.q_ref);
indi_r_err = abs(log_indi.r_state - log_indi.r_ref);

asc_phi_err = abs(log_asc.phi_state - log_asc.phi_ref);
asc_theta_err = abs(log_asc.theta_state - log_asc.theta_ref);
asc_psi_err = abs(log_asc.psi_state - log_asc.psi_ref);
asc_p_err = abs(log_asc.p_state - log_asc.p_ref);
asc_q_err = abs(log_asc.q_state - log_asc.q_ref);
asc_r_err = abs(log_asc.r_state - log_asc.r_ref);

% shift time for second data
log_asc_indi_shift.time = log_asc.time - 8.5507;

subplot(n_rows,n_cols,1);
plot(log_indi.time, indi_phi_err,'LineWidth',1.5,'Color','r'); hold on;
plot(log_asc_indi_shift.time, asc_phi_err,'LineWidth',1.5,'Color','b');
grid minor;
legend("INDI","ASCINDI",'Interpreter','latex');
xlabel("time [sec]");
ylabel("$$\Delta \phi$$ [rad]");
title("Phi Error");

subplot(n_rows,n_cols,2);
plot(log_indi.time, indi_theta_err,'LineWidth',1.5,'Color','r'); hold on;
plot(log_asc_indi_shift.time, asc_theta_err,'LineWidth',1.5,'Color','b');
grid minor;
legend("INDI","ASCINDI",'Interpreter','latex');
xlabel("time [sec]");
ylabel("$$\Delta \phi$$ [rad]");
title("Phi Error");

subplot(n_rows,n_cols,3);
plot(log_indi.time, indi_psi_err,'LineWidth',1.5,'Color','r'); hold on;
plot(log_asc_indi_shift.time, asc_psi_err,'LineWidth',1.5,'Color','b');
grid minor;
legend("INDI","ASCINDI",'Interpreter','latex');
xlabel("time [sec]");
ylabel("$$\Delta \phi$$ [rad]");
title("Phi Error");

subplot(n_rows,n_cols,4);
plot(log_indi.time, indi_p_err,'LineWidth',1.5,'Color','r'); hold on;
plot(log_asc_indi_shift.time, asc_p_err,'LineWidth',1.5,'Color','b');
grid minor;
legend("INDI","ASCINDI",'Interpreter','latex');
xlabel("time [sec]");
ylabel("$$\Delta \phi$$ [rad]");
title("Phi Error");

subplot(n_rows,n_cols,5);
plot(log_indi.time, indi_q_err,'LineWidth',1.5,'Color','r'); hold on;
plot(log_asc_indi_shift.time, asc_q_err,'LineWidth',1.5,'Color','b');
grid minor;
legend("INDI","ASCINDI",'Interpreter','latex');
xlabel("time [sec]");
ylabel("$$\Delta \phi$$ [rad]");
title("Phi Error");

subplot(n_rows,n_cols,6);
plot(log_indi.time, indi_r_err,'LineWidth',1.5,'Color','r'); hold on;
plot(log_asc_indi_shift.time, asc_r_err,'LineWidth',1.5,'Color','b');
grid minor;
legend("INDI","ASCINDI",'Interpreter','latex');
xlabel("time [sec]");
ylabel("$$\Delta \phi$$ [rad]");
title("Phi Error");