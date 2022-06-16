%% Read Test Data and Plot

%%%  0 : Useful Data

dt = 0.002;            %[sec]
freq = 1/dt;            %[sec]

start_log = 0.01;
end_log = 0.99;

%%%  1 : Process Data from Logger

log_act_change = logger('20220321-slow_30_indi_real', start_log, end_log);
log_act_change_asc = logger('20220321-slow_30_asc_real', start_log, end_log);
log_act_10_indi = logger('20220320-act_slow_10_indi', start_log, end_log);
log_act_10_asc = logger('20220320-act_slow_10_asc', start_log, end_log);
log_drag_y = logger('20220321-act_20_drag_yes', start_log, end_log);
log_drag_n = logger('20220321-act_20_drag_no', start_log, end_log);
log_drag_vary = logger('20220321-act_50_drag_multi', start_log, end_log);

%%% 3 : plot the data

%% P4: actuator change rate
show_fig4 = false;

t_slow = log_act_change_asc.t - 36.117;
rate_q_filt = lowpass(log_act_change_asc.rate_q, 10, 1000);

figure_4 = figure('Visible', show_fig4, 'Position', [100 200 700 200]);
set(figure_4,'defaulttextinterpreter','latex');
plot(log_act_change_asc.t, rate_q_filt,'LineWidth',1.5,'Color','b'); hold on;
plot(log_act_change_asc.t, log_act_change_asc.rate_q_ref,'LineWidth',1,'Color','b','LineStyle','--'); hold on;
plot(t_slow, rate_q_filt,'LineWidth',1.5,'Color','r'); hold on;
plot(t_slow, log_act_change_asc.rate_q_ref,'LineWidth',1,'Color','r','LineStyle','--');
grid minor;
title("Tracking performance with different actuators - real flight");
legend("$q$ - omega = 50", "$q_{ref}$ - omega = 50", "$q$ - omega = 30", "$q_{ref}$ - omega = 30",'Interpreter','latex');
xlabel("Time [sec]");
ylabel("$$q$$ [rad/sec$$^2$$]");

%% P5: actuator state track
show_fig5 = false;

t_slow = log_act_change.t - 32.8;

figure_5 = figure('Visible', show_fig5, 'Position', [100 200 700 200]);
set(figure_5,'defaulttextinterpreter','latex');
plot(log_act_change.t, log_act_change.act_state_1,'LineWidth',1.5,'Color','b'); hold on;
plot(log_act_change.t, log_act_change.act_cmd_1,'LineWidth',1,'Color','b','LineStyle','--'); hold on;
plot(t_slow, log_act_change.act_state_1,'LineWidth',1.5,'Color','r'); hold on;
plot(t_slow, log_act_change.act_cmd_1,'LineWidth',1,'Color','r','LineStyle','--');
grid minor;
title("Actuator tracking");
legend("act state - omega = 50", "act cmd - omega = 50", "act state - omega = 30", "act cmd - omega = 30",'Interpreter','latex');
xlabel("Time [sec]");
ylabel("PPRZ Command");

%% P6: actuator change rate, single
show_fig6 = false;

log_fig_6 = log_drag_vary;
log_fig_6_rate_filt = lowpass(log_fig_6.rate_q, 10, 1000);

figure_6 = figure('Visible', show_fig6, 'Position', [100 200 700 200]);
set(figure_6,'defaulttextinterpreter','latex');
plot(log_fig_6.t, log_fig_6_rate_filt,'LineWidth',1.5,'Color','b'); hold on;
plot(log_fig_6.t, log_fig_6.rate_q_ref,'LineWidth',1,'Color','b','LineStyle','--');
grid minor;
title("Slowdown no compensation");
legend("$q$ - omega = 10", "$q_{ref}$ - omega = 10",'Interpreter','latex');
xlabel("Time [sec]");
ylabel("$$q$$ [deg/sec2]");

%% P7: drag plate comparison in 2 runs
show_fig7 = false;

% crop the longest file to short
len_short = length(log_drag_n.t);
log_drag_y.rate_q_ref = log_drag_y.rate_q_ref(1:len_short,:);
log_drag_y.rate_q = log_drag_y.rate_q(1:len_short,:);

t_slow = log_drag_n.t + 0.9727;
rate_q_filt_drag_y = lowpass(log_drag_y.rate_q, 10, 1000);
rate_q_filt_drag_n = lowpass(log_drag_n.rate_q, 10, 1000);

figure_7 = figure('Visible', show_fig7, 'Position', [100 200 700 200]);
set(figure_7,'defaulttextinterpreter','latex');
plot(log_drag_n.t, rate_q_filt_drag_n,'LineWidth',1.5,'Color','b'); hold on;
plot(log_drag_n.t, log_drag_n.rate_q_ref,'LineWidth',1,'Color','b','LineStyle','--'); hold on;
plot(t_slow, rate_q_filt_drag_y,'LineWidth',1.5,'Color','r'); hold on;
plot(t_slow, log_drag_y.rate_q_ref,'LineWidth',1,'Color','r','LineStyle','--');
grid minor;
title("Tracking performance with different actuators - real flight");
legend("$q$ - drag no", "$q_{ref}$ - drag no", "$q$ - drag yes", "$q_{ref}$ - drag yes",'Interpreter','latex');
xlabel("Time [sec]");
ylabel("$$q$$ [rad/sec$$^2$$]");

%% P8: speed drag

show_fig8 = true;

figure_8 = figure('Visible', show_fig8, 'Position', [100 200 700 200]);
set(figure_8,'defaulttextinterpreter','latex');
plot(log_drag_y.t, log_drag_y.vel_x,'LineWidth',1.5,'Color','b'); hold on;
grid minor;
title("Tracking performance with different actuators - real flight");
legend("$q$ - drag no", "$q_{ref}$ - drag no", "$q$ - drag yes", "$q_{ref}$ - drag yes",'Interpreter','latex');
xlabel("Time [sec]");
ylabel("$$q$$ [rad/sec$$^2$$]");