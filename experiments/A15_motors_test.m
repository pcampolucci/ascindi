%% Validation Inner Loop

%%% 1 : Process Data from Logger

folder = '05_18_22_motors/';

start_log = 0.05;
end_log = 0.99;

% logs with propeller
log_1 = logger(strcat(folder,'motor_0_prop'), start_log, end_log);
log_2 = logger(strcat(folder,'motor_1_prop'), start_log, end_log);
log_3 = logger(strcat(folder,'motor_2_prop'), start_log, end_log);
log_4 = logger(strcat(folder,'motor_3_prop'), start_log, end_log);

% logs without propellers
log_5 = logger(strcat(folder,'motor_0_no_prop'), start_log, end_log);
log_6 = logger(strcat(folder,'motor_1_no_prop'), start_log, end_log);
log_7 = logger(strcat(folder,'motor_2_no_prop'), start_log, end_log);
log_8 = logger(strcat(folder,'motor_3_no_prop'), start_log, end_log);

legend_1 = 'ID: 0';
legend_2 = 'ID: 1';
legend_3 = 'ID: 2';
legend_4 = 'ID: 3';

%%% 2 : control panel on showing figures or not

show_fig1 = true;
show_fig2 = false;

%%% 3 : shift time step

shift_2 = -30.148;
shift_3 = -54.437;
shift_4 = 25.344;

log_2.time = log_2.time + shift_2;
log_3.time = log_3.time + shift_3;
log_4.time = log_4.time + shift_4;

%%% 4 : actuator dynamics

% build function
numerator = 50;
denominator = [1,50];
sys = tf(numerator,denominator);

% make trajectory

n_steps = 499;
step_time = 0.977;
step_array = [100,-100, 700,-700, 1200,-1200, 1700,-1700];
t = linspace(0,step_time,499);
y = 6000*step(sys,t);

for i = 1:length(step_array)
    t_temp = linspace(t(end),t(end)+step_time,499);
    t_step = linspace(0,step_time,499);

    if i == 1 
        y_temp = y(end) + step_array(i)*step(sys,t_step);
    else
        y_temp = y(end) + (step_array(i)-step_array(i-1))*step(sys,t_step);
    end

    y = vertcat(y,y_temp);
    t = horzcat(t,t_temp);
end

t = t + 384.52 - step_time;

%% P1 : Match the actuator response with a first order

figure_1 = figure('Visible', show_fig1, 'Position', [100 200 1000 800]);
set(figure_1,'defaulttextinterpreter','latex');

plot(log_1.time, (log_1.act_cmd_1),'LineWidth',0.8,'Color','k'); hold on;
% plot(log_2.time, (log_2.act_cmd_2),'LineWidth',0.8,'Color','k'); hold on;
% plot(log_3.time, (log_3.act_cmd_3),'LineWidth',0.8,'Color','k'); hold on;
% plot(log_4.time, (log_4.act_cmd_4),'LineWidth',0.8,'Color','k'); hold on;
plot(log_1.time, (log_1.act_state_1),'LineWidth',1.2,'Color','b'); hold on;
plot(log_2.time, (log_2.act_state_2),'LineWidth',1.2,'Color','r'); hold on;
plot(log_3.time, (log_3.act_state_3),'LineWidth',1.2,'Color','g'); hold on;
plot(log_4.time, (log_4.act_state_4),'LineWidth',1.2,'Color','c'); hold on;
plot(t, (y),'LineWidth',3,'Color','m','LineStyle','--');
grid minor;
legend('cmd',legend_1,legend_2,legend_3,legend_4,'guess','Interpreter','latex');
xlabel("time [sec]");
ylabel("$$\theta$$ [deg]");
title("Actuator Step Tracking");

%% P2 : Simulate Transfer Function

figure_2 = figure('Visible', show_fig2, 'Position', [100 200 1000 800]);
set(figure_2,'defaulttextinterpreter','latex');

plot(t, y,'LineWidth',1.2,'Color','k'); hold on;
grid minor;
legend('transfer function','Interpreter','latex');
xlabel("time [sec]");
ylabel("$$\theta$$ [deg]");
title("Actuator Step Tracking");
