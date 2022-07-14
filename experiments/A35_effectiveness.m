%% Effectiveness Verification

folder = 'test_data/07_07_22_effectiveness/';

start_log = 0.02;
end_log = 0.99;

log = logger(strcat(folder,'effectiveness_plate'), start_log, end_log);

%% P1 : State vs Estimation
figure_1 = figure('Visible', show_fig1, 'Position', [100 200 700 300]);
set(figure_1,'defaulttextinterpreter','latex');

plot(log.time, (log.qd_state_f),'LineWidth',2,'Color','b'); hold on;
plot(log.time, (log.qd_estimated_f),'LineWidth',2,'Color','r'); hold on;
grid minor;
legend('$\dot{q}_f$','$\dot{q}_{\textbf{G} f}$','Interpreter','latex');
xlabel("time [sec]");
ylabel("$\dot{q}$ [rad/sec$^2$]");