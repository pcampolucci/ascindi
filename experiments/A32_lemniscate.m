%% Doublet 

%%% 1 : Process Data from Logger

folder = 'test_data/06_14_22_doublet_series/';

start_log = 0.27;
end_log = 0.91;

log_1 = logger(strcat(folder,'lemniscate_indi'), start_log, end_log-0.04);
log_2 = logger(strcat(folder,'lemniscate_acindi'), start_log, end_log);
log_3 = logger(strcat(folder,'lemniscate_ascindi'), start_log-0.12, end_log-0.08);

legend_1 = 'INDI';
legend_2 = 'ACINDI';
legend_3 = 'ASCINDI';

% time shift between signals
shift_2 = -9.8954;
shift_3 = -59.4872;

%%% 2 : control panel on showing figures or not
show_fig1 = 1;
show_fig2 = 1;

%%% 3 : align time
log_2.time = log_2.time + shift_2;
log_3.time = log_3.time + shift_3;

% wrap psi
for i = 1:length(log_1.time)
    if log_1.psi_state(i) > 1
        log_1.psi_state(i) = log_1.psi_state(i) - 2*pi;
    end
end

for i = 1:length(log_2.time)
    if log_2.psi_state(i) > 1
        log_2.psi_state(i) = log_2.psi_state(i) - 2*pi;
    end
end

for i = 1:length(log_3.time)
    if log_3.psi_state(i) > 1
        log_3.psi_state(i) = log_3.psi_state(i) - 2*pi;
    end
end

%% Error tracking

% position 
err_x_indi = sqrt(mean((log_1.x_ref-log_1.x_state).^2));
err_y_indi = sqrt(mean((log_1.y_ref-log_1.y_state).^2));
err_z_indi = sqrt(mean((log_1.z_ref-log_1.z_state).^2));

err_x_acindi = sqrt(mean((log_2.x_ref-log_2.x_state).^2));
err_y_acindi = sqrt(mean((log_2.y_ref-log_2.y_state).^2));
err_z_acindi = sqrt(mean((log_2.z_ref-log_2.z_state).^2));

err_x_ascindi = sqrt(mean((log_3.x_ref-log_3.x_state).^2));
err_y_ascindi = sqrt(mean((log_3.y_ref-log_3.y_state).^2));
err_z_ascindi = sqrt(mean((log_3.z_ref-log_3.z_state).^2));

% attitude

err_phi_indi = sqrt(mean((log_1.phi_ref-log_1.phi_state).^2));
err_theta_indi = sqrt(mean((log_1.theta_ref-log_1.theta_state).^2));
err_psi_indi = sqrt(mean((log_1.psi_ref-log_1.psi_state).^2));

err_phi_acindi = sqrt(mean((log_2.phi_ref-log_2.phi_state).^2));
err_theta_acindi = sqrt(mean((log_2.theta_ref-log_2.theta_state).^2));
err_psi_acindi = sqrt(mean((log_2.psi_ref-log_2.psi_state).^2));

err_phi_ascindi = sqrt(mean((log_3.phi_ref-log_3.phi_state).^2));
err_theta_ascindi = sqrt(mean((log_3.theta_ref-log_3.theta_state).^2));
err_psi_ascindi = sqrt(mean((log_3.psi_ref-log_3.psi_state).^2));

% print to latex table
fprintf("$x$ & %f & %f & %f \\ \bhline\n", err_x_indi, err_x_acindi, err_x_ascindi);
fprintf("$y$ & %f & %f & %f \\ \bhline\n", err_y_indi, err_y_acindi, err_y_ascindi);
fprintf("$z$ & %f & %f & %f \\ \bhline\n", err_z_indi, err_z_acindi, err_z_ascindi);
fprintf("$\bphi$ & %f & %f & %f \\ \bhline\n", err_phi_indi, err_phi_acindi, err_phi_ascindi);
fprintf("$\btheta$ & %f & %f & %f \\ \bhline\n", err_theta_indi, err_theta_acindi, err_theta_ascindi);
fprintf("$\bpsi$ & %f & %f & %f \\ \bhline\n", err_psi_indi, err_psi_acindi, err_psi_ascindi);

%% P1 : Tracking Performance Overview
figure_1 = figure('Visible', show_fig1, 'Position', [100 200 800 1800]);
set(figure_1,'defaulttextinterpreter','latex','DefaultFigureRendererMode', 'manual');

tiledlayout(5,2,'TileSpacing','Compact','Padding','Compact');

nexttile([1 2]);
plot3(log_3.x_setpoint,log_3.y_setpoint,-log_3.z_setpoint,'LineWidth',1.2,'Color','k',LineStyle='--'); hold on;
plot3(log_3.x_state,log_3.y_state,-log_3.z_state,'LineWidth',1.2,'Color','m'); hold on;
plot3(log_1.x_state,log_1.y_state,-log_1.z_state,'LineWidth',1.2,'Color','b'); hold on;
plot3(log_2.x_state,log_2.y_state,-log_2.z_state,'LineWidth',1.2,'Color','g');
zlim([1,3]);
xlabel("$x$ [m]");
ylabel("$y$ [m]");
zlabel("$z$ [m]");
view([348 57]);
legend('ref',legend_3,legend_1,legend_2,'Location','northwestoutside');
grid minor;

ax1 = nexttile;
plot(log_3.time, (log_3.xd_ref),'LineWidth',1.2,'Color','m',LineStyle='--'); hold on;
plot(log_3.time, (log_3.xd_state),'LineWidth',1.2,'Color','m'); hold on;
plot(log_1.time, (log_1.xd_ref),'LineWidth',1.2,'Color','b',LineStyle='--'); hold on;
plot(log_1.time, (log_1.xd_state),'LineWidth',1.2,'Color','b'); hold on;
plot(log_2.time, (log_2.xd_ref),'LineWidth',1.2,'Color','g',LineStyle='--'); hold on;
plot(log_2.time, (log_2.xd_state),'LineWidth',1.2,'Color','g'); hold on;
xlim([45,75]);
grid minor;
xlabel("time [sec]");
ylabel("$$\dot{x}$$ [m/sec]");

ax2 = nexttile;
plot(log_3.time, (log_3.yd_ref),'LineWidth',1.2,'Color','m',LineStyle='--'); hold on;
plot(log_3.time, (log_3.yd_state),'LineWidth',1.2,'Color','m'); hold on;
plot(log_1.time, (log_1.yd_ref),'LineWidth',1.2,'Color','b',LineStyle='--'); hold on;
plot(log_1.time, (log_1.yd_state),'LineWidth',1.2,'Color','b'); hold on;
plot(log_2.time, (log_2.yd_ref),'LineWidth',1.2,'Color','g',LineStyle='--'); hold on;
plot(log_2.time, (log_2.yd_state),'LineWidth',1.2,'Color','g'); hold on;
xlim([45,75]);
grid minor;
xlabel("time [sec]");
ylabel("$$\dot{y}$$ [m/sec]");

phi_err_indi = abs(log_1.phi_ref-log_1.phi_state);
phi_err_acindi = abs(log_2.phi_ref-log_2.phi_state);
phi_err_ascindi = abs(log_3.phi_ref-log_3.phi_state);

theta_err_indi = abs(log_1.theta_ref-log_1.theta_state);
theta_err_acindi = abs(log_2.theta_ref-log_2.theta_state);
theta_err_ascindi = abs(log_3.theta_ref-log_3.theta_state);

psi_err_indi = abs(log_1.psi_ref-log_1.psi_state);
psi_err_acindi = abs(log_2.psi_ref-log_2.psi_state);
psi_err_ascindi = abs(log_3.psi_ref-log_3.psi_state);

ax3 = nexttile;
plot(log_1.time, rad2deg(log_1.phi_ref),'LineWidth',1.2,'Color','b',LineStyle='--'); hold on;
plot(log_1.time, rad2deg(log_1.phi_state),'LineWidth',1.2,'Color','b'); hold on;
plot(log_2.time, rad2deg(log_2.phi_ref),'LineWidth',1.2,'Color','g',LineStyle='--'); hold on;
plot(log_2.time, rad2deg(log_2.phi_state),'LineWidth',1.2,'Color','g'); hold on;
plot(log_3.time, rad2deg(log_3.phi_ref),'LineWidth',1.2,'Color','m',LineStyle='--'); hold on;
plot(log_3.time, rad2deg(log_3.phi_state),'LineWidth',1.2,'Color','m'); hold on;
xlim([45,75]);
grid minor;
xlabel("time [sec]");
ylabel("$$\phi$$ [deg]");

ax4 = nexttile;
plot(log_3.time, rad2deg(phi_err_ascindi),'LineWidth',1.2,'Color','m'); hold on;
plot(log_1.time, rad2deg(phi_err_indi),'LineWidth',1.2,'Color','b'); hold on;
plot(log_2.time, rad2deg(phi_err_acindi),'LineWidth',1.2,'Color','g'); hold on;
xlim([45,75]);
grid minor;
xlabel("time [sec]");
ylabel("$$|\phi_{ref}-\phi|$$ [deg]");

ax5 = nexttile;
plot(log_1.time, rad2deg(log_1.theta_ref),'LineWidth',1.2,'Color','b',LineStyle='--'); hold on;
plot(log_1.time, rad2deg(log_1.theta_state),'LineWidth',1.2,'Color','b'); hold on;
plot(log_2.time, rad2deg(log_2.theta_ref),'LineWidth',1.2,'Color','g',LineStyle='--'); hold on;
plot(log_2.time, rad2deg(log_2.theta_state),'LineWidth',1.2,'Color','g'); hold on;
plot(log_3.time, rad2deg(log_3.theta_ref),'LineWidth',1.2,'Color','m',LineStyle='--'); hold on;
plot(log_3.time, rad2deg(log_3.theta_state),'LineWidth',1.2,'Color','m'); hold on;
xlim([45,75]);
grid minor;
xlabel("time [sec]");
ylabel("$$\theta$$ [deg]");

ax6 = nexttile;
plot(log_3.time, rad2deg(theta_err_ascindi),'LineWidth',1.2,'Color','m'); hold on;
plot(log_1.time, rad2deg(theta_err_indi),'LineWidth',1.2,'Color','b'); hold on;
plot(log_2.time, rad2deg(theta_err_acindi),'LineWidth',1.2,'Color','g'); hold on;
xlim([45,75]);
grid minor;
xlabel("time [sec]");
ylabel("$$|\theta_{ref}-\theta|$$ [deg]");

ax7 = nexttile;
plot(log_1.time, rad2deg(log_1.psi_ref),'LineWidth',1.2,'Color','b',LineStyle='--'); hold on;
plot(log_1.time, rad2deg(log_1.psi_state),'LineWidth',1.2,'Color','b'); hold on;
plot(log_2.time, rad2deg(log_2.psi_ref),'LineWidth',1.2,'Color','g',LineStyle='--'); hold on;
plot(log_2.time, rad2deg(log_2.psi_state),'LineWidth',1.2,'Color','g'); hold on;
plot(log_3.time, rad2deg(log_3.psi_ref),'LineWidth',1.2,'Color','m',LineStyle='--'); hold on;
plot(log_3.time, rad2deg(log_3.psi_state),'LineWidth',1.2,'Color','m'); hold on;
xlim([45,75]);
grid minor;
xlabel("time [sec]");
ylabel("$$\psi$$ [deg]");

ax8 = nexttile;
plot(log_3.time, rad2deg(psi_err_ascindi),'LineWidth',1.2,'Color','m'); hold on;
plot(log_1.time, rad2deg(psi_err_indi),'LineWidth',1.2,'Color','b'); hold on;
plot(log_2.time, rad2deg(psi_err_acindi),'LineWidth',1.2,'Color','g'); hold on;
xlim([45,75]);
grid minor;
xlabel("time [sec]");
ylabel("$$|\psi_{ref}-\psi|$$ [deg]");

linkaxes([ax1,ax2,ax3,ax4,ax5,ax6,ax7,ax8], 'x');

exportgraphics(gcf,'lemniscate.pdf','ContentType','vector')


