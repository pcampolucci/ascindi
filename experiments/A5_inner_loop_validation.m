%% Validation Inner Loop
% we compare flights with inner loop compensation with conventional INDI
% controller. We look for the tracking performance of thereference
% trajectory generated in the inner loop, therefore the attitude and higher
% derivatives tracking. 

%%% 1 : Process Data from Logger

folder = '05_16_22/';

start_log = 0.05;
end_log = 0.99;

log_1 = logger(strcat(folder,'traj_50_22_nocomp'), start_log, end_log);
log_2 = logger(strcat(folder,'traj_50_22_comp'), start_log, end_log);

legend_1 = 'NO COMP';
legend_2 = 'COMP';

% time shift between signals
shift_50_10 = 0;
shift_comp = -109.6967;

%%% 2 : control panel on showing figures or not

show_fig1 = true;
show_fig2 = true;
show_fig3 = true;

%%% 3 : filtering settings
f_sample = 1/0.002;

%%% 4 : align time
log_1.time = log_1.time + shift_comp;

%% P1 : Plot the tracking performance of the pitching motion

figure_1 = figure('Visible', show_fig1, 'Position', [100 200 1000 800]);
set(figure_1,'defaulttextinterpreter','latex');

tiledlayout(3,2);

% Roll Motion Tracking

indi_phi_err =  abs(log_1.phi_state - log_1.phi_ref);
asc_phi_err =  abs(log_2.phi_state - log_2.phi_ref);

ax1 = nexttile;
plot(log_1.time, rad2deg(indi_phi_err),'LineWidth',1.5,'Color','b'); hold on;
plot(log_2.time, rad2deg(asc_phi_err),'LineWidth',1.5,'Color','r');
grid minor;
legend(legend_1,legend_2,'Interpreter','latex');
xlabel("time [sec]");
ylabel("$$\Delta \phi$$ [rad]");
title("Phi Error");

indi_p_err =  abs(log_1.p_state - log_1.p_ref);
asc_p_err =  abs(log_2.p_state - log_2.p_ref);

ax2 = nexttile;
plot(log_1.time, rad2deg(indi_p_err),'LineWidth',1.5,'Color','b'); hold on;
plot(log_2.time, rad2deg(asc_p_err),'LineWidth',1.5,'Color','r');
grid minor;
legend(legend_1,legend_2,'Interpreter','latex');
xlabel("time [sec]");
ylabel("$$\Delta p$$ [rad/sec]");
title("Roll Rate Tracking");

% Pitch Motion Tracking

indi_theta_err =  abs(log_1.theta_state - log_1.theta_ref);
asc_theta_err =  abs(log_2.theta_state - log_2.theta_ref);

ax3 = nexttile;
plot(log_1.time, rad2deg(indi_theta_err),'LineWidth',1.5,'Color','b'); hold on;
plot(log_2.time, rad2deg(asc_theta_err),'LineWidth',1.5,'Color','r');
grid minor;
legend(legend_1,legend_2,'Interpreter','latex');
xlabel("time [sec]");
ylabel("$$\Delta \theta$$ [rad]");
title("Theta Error");

indi_q_err =  abs(log_1.q_state - log_1.q_ref);
asc_q_err =  abs(log_2.q_state - log_2.q_ref);

ax4 = nexttile;
plot(log_1.time, rad2deg(indi_q_err),'LineWidth',1.5,'Color','b'); hold on;
plot(log_2.time, rad2deg(asc_q_err),'LineWidth',1.5,'Color','r');
grid minor;
legend(legend_1,legend_2,'Interpreter','latex');
xlabel("time [sec]");
ylabel("$$\Delta q$$ [rad/sec]");
title("Pitch Rate Tracking");

% Yaw Motion Tracking

% adjust error
for i = 1:length(log_1.psi_state)
    if log_1.psi_state(i) > 0.6*pi
        log_1.psi_state(i) = log_1.psi_state(i) - 2*pi;
    end
end

for i = 1:length(log_2.psi_state)
    if log_2.psi_state(i) > 0.6*pi
        log_2.psi_state(i) = log_2.psi_state(i) - 2*pi;
    end
end

indi_psi_err =  abs(log_1.psi_state - log_1.psi_ref);
asc_psi_err =  abs(log_2.psi_state - log_2.psi_ref);

ax5 = nexttile;
plot(log_1.time, rad2deg(indi_psi_err),'LineWidth',1.5,'Color','b'); hold on;
plot(log_2.time, rad2deg(asc_psi_err),'LineWidth',1.5,'Color','r');
grid minor;
legend(legend_1,legend_2,'Interpreter','latex');
xlabel("time [sec]");
ylabel("$$\Delta \psi$$ [rad]");
title("Psi Error");

indi_r_err =  abs(log_1.r_state - log_1.r_ref);
asc_r_err =  abs(log_2.r_state - log_2.r_ref);

ax6 = nexttile;
plot(log_1.time, rad2deg(indi_r_err),'LineWidth',1.5,'Color','b'); hold on;
plot(log_2.time, rad2deg(asc_r_err),'LineWidth',1.5,'Color','r');
grid minor;
legend(legend_1,legend_2,'Interpreter','latex');
xlabel("time [sec]");
ylabel("$$\Delta r$$ [rad/sec]");
title("Yaw Rate Tracking");

linkaxes([ax1,ax2,ax3,ax4,ax5,ax6], 'x');

%% P2 : simple 2D position track

figure_2 = figure('Visible', show_fig2, 'Position', [100 200 1000 800]);

subplot(2,2,[1,2]);
set(figure_2,'defaulttextinterpreter','latex');
plot(log_1.x_state, log_1.y_state,'LineWidth',1.5,'Color','b'); hold on;
plot(log_2.x_state, log_2.y_state,'LineWidth',1.5,'Color','g'); hold on;
plot(log_1.x_setpoint, log_1.y_setpoint, 'LineWidth',1.5,'Color','r');
grid minor;
legend(legend_1,legend_2,"desired",'Interpreter','latex');
xlabel("$$x$$ in NED [m]");
ylabel("$$y$$ in NED [m]");
title("Position Tracking");

indi_x_error = abs(log_1.x_setpoint - log_1.x_state);
indi_y_error = abs(log_1.y_setpoint - log_1.y_state);
asc_indi_x_error = abs(log_2.x_setpoint - log_2.x_state);
asc_indi_y_error = abs(log_2.y_setpoint - log_2.y_state);

subplot(2,2,3);
plot(log_1.time, indi_x_error,'LineWidth',1.5,'Color','r'); hold on;
plot(log_2.time, asc_indi_x_error,'LineWidth',1.5,'Color','b');
grid minor;
legend(legend_1,legend_2,'Interpreter','latex');
xlabel("time [sec]");
ylabel("$$\Delta x$$ in NED [m]");
title("X Error");

subplot(2,2,4);
plot(log_1.time, indi_y_error,'LineWidth',1.5,'Color','r'); hold on;
plot(log_2.time, asc_indi_y_error,'LineWidth',1.5,'Color','b');
grid minor;
legend(legend_1,legend_2,'Interpreter','latex');
xlabel("time [sec]");
ylabel("$$\Delta y$$ in NED [m]");
title("Y Error");

%% P3 : simple 2D position track

figure_3 = figure('Visible', show_fig3, 'Position', [100 200 1000 800]);
set(figure_3,'defaulttextinterpreter','latex');

tiledlayout(3,1);

% Roll Motion Tracking

ax1 = nexttile;
plot(log_1.time, rad2deg(log_1.phi_ref),'LineWidth',1.5,'Color','b'); hold on;
plot(log_1.time, rad2deg(log_1.phi_state),'LineWidth',1.5,'Color','r');
grid minor;
legend(legend_1,legend_2,'Interpreter','latex');
xlabel("time [sec]");
ylabel("$$\Delta \theta$$ [rad]");
title("Phi Error");

ax2 = nexttile;
plot(log_1.time, rad2deg(log_1.theta_ref),'LineWidth',1.5,'Color','b'); hold on;
plot(log_1.time, rad2deg(log_1.theta_state),'LineWidth',1.5,'Color','r');
grid minor;
legend(legend_1,legend_2,'Interpreter','latex');
xlabel("time [sec]");
ylabel("$$\Delta \theta$$ [rad]");
title("Theta Error");

% Pitch Motion Tracking

ax3 = nexttile;
plot(log_1.time, rad2deg(log_1.psi_ref),'LineWidth',1.5,'Color','b'); hold on;
plot(log_1.time, rad2deg(log_1.psi_state),'LineWidth',1.5,'Color','r');
grid minor;
legend(legend_1,legend_2,'Interpreter','latex');
xlabel("time [sec]");
ylabel("$$\Delta \theta$$ [rad]");
title("Psi Error");

linkaxes([ax1,ax2,ax3], 'x');






