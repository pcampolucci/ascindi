%% Doublet 

%%% 1 : Process Data from Logger

folder = '06_14_22_doublet_series/';

start_log = 0.02;
end_log = 0.99;

log_1 = logger(strcat(folder,'doublet_series_indi'), start_log, end_log);
log_2 = logger(strcat(folder,'doublet_series_acindi'), start_log, end_log);
log_3 = logger(strcat(folder,'doublet_series_ascindi'), start_log, end_log);

legend_1 = 'INDI';
legend_2 = 'ACINDI';
legend_3 = 'ASCINDI';

% time shift between signals
shift_2 = 1.6267;
shift_3 = -79.4066;

%%% 2 : control panel on showing figures or not
show_fig1 = 1;

%%% 3 : align time
log_2.time = log_2.time + shift_2;
log_3.time = log_3.time + shift_3;

for i = 1:length(log_1.time)
    if not(log_1.theta_cmd(i) == -0.15)
        log_1.theta_ref(i) = 0;
        log_1.theta_state(i) = 0;
    end
end

for i = 1:length(log_2.time)
    if not(log_2.theta_cmd(i) == -0.15)
        log_2.theta_ref(i) = 0;
        log_2.theta_state(i) = 0;
    end
end

for i = 1:length(log_3.time)
    if not(log_3.theta_cmd(i) == -0.15)
        log_3.theta_ref(i) = 0;
        log_3.theta_state(i) = 0;
    end
end

%% Get errors

err_indi = sqrt(mean((log_1.theta_ref-log_1.theta_state).^2));
err_acindi = sqrt(mean((log_2.theta_ref-log_2.theta_state).^2));
err_ascindi = sqrt(mean((log_3.theta_ref-log_3.theta_state).^2));

%% P1 : Tracking Performance Overview
figure_1 = figure('Visible', show_fig1, 'Position', [100 200 1000 800]);
set(figure_1,'defaulttextinterpreter','latex');

plot(log_1.time, rad2deg(log_1.theta_cmd),'LineWidth',1.2,'Color','k'); hold on;
plot(log_1.time, rad2deg(log_1.theta_ref),'LineWidth',1.2,'Color','b',LineStyle='--'); hold on;
plot(log_1.time, rad2deg(log_1.theta_state),'LineWidth',1.2,'Color','b'); hold on;
plot(log_2.time, rad2deg(log_2.theta_ref),'LineWidth',1.2,'Color','g',LineStyle='--'); hold on;
plot(log_2.time, rad2deg(log_2.theta_state),'LineWidth',1.2,'Color','g'); hold on;
plot(log_3.time, rad2deg(log_3.theta_ref),'LineWidth',1.2,'Color','m',LineStyle='--'); hold on;
plot(log_3.time, rad2deg(log_3.theta_state),'LineWidth',1.2,'Color','m'); hold on;
grid minor;
legend('cmd','ref',legend_1,'ref',legend_2,'ref',legend_3,'Interpreter','latex');
xlabel("time [sec]");
ylabel("$$\theta$$ [deg]");
