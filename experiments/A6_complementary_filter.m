%% Validation Inner Loop
% we compare flights with inner loop compensation with conventional INDI
% controller. We look for the tracking performance of thereference
% trajectory generated in the inner loop, therefore the attitude and higher
% derivatives tracking. 

%%% 1 : Process Data from Logger

folder = '11_05_22/';

start_log = 0.05;
end_log = 0.99;

log_1 = logger(strcat(folder,'debug2'), start_log, end_log);

legend_1 = 'raw signals';
legend_2 = 'filtered';

% time shift between signals

%%% 2 : control panel on showing figures or not

show_fig1 = true;
show_fig2 = true;
show_fig3 = true;

%%% 3 : filtering settings
f_sample = 1/0.002;

%%% 4 : align time
log_1.time = log_1.time;

%% P1 : Plot the tracking performance of the pitching motion

figure_1 = figure('Visible', show_fig1, 'Position', [100 200 1000 800]);
set(figure_1,'defaulttextinterpreter','latex');

tiledlayout(2,1);

ax1 = nexttile;
plot(log_1.time, log_1.pd_state_f,'LineWidth',1,'Color','b'); hold on;
plot(log_1.time, log_1.qd_state_f,'LineWidth',1,'Color','r'); hold on;
plot(log_1.time, log_1.rd_state_f,'LineWidth',1,'Color','g'); 
grid minor;
legend('ref','error','g2term','Interpreter','latex');
xlabel("time [sec]");
ylabel("Motor Input [RPM]");
title("Actuator Signal Filtering");

ax2 = nexttile;
plot(log_1.time, log_1.pd_state_f_undelayed,'LineWidth',1,'Color','b'); hold on;
plot(log_1.time, log_1.qd_state_f_undelayed,'LineWidth',1,'Color','r'); hold on;
plot(log_1.time, log_1.rd_state_f_undelayed,'LineWidth',1,'Color','g'); 
grid minor;
legend('ref','error','g2term','Interpreter','latex');
xlabel("time [sec]");
ylabel("Motor Input [RPM]");
title("Actuator Signal Filtering");

linkaxes([ax1,ax2], 'x');





