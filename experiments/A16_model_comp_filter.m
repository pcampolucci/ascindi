%% Validation Inner Loop

%%% 1 : Process Data from Logger

folder = '05_18_22_free_flight/';

start_log = 0.2;
end_log = 0.3;

log_1 = logger(strcat(folder,'free_flight_model'), start_log, end_log);
log_2 = logger(strcat(folder,'free_flight_no_model'), start_log, end_log);

legend_1 = 'Model';
legend_2 = 'No Model';

log_see = log_2;

%%% 2 : control panel on showing figures or not

show_fig4 = true;
show_fig7 = false;
show_fig9 = false;
show_fig10 = false;

%%% 3 : model for yaw velocity

% variables
Vx = log_see.xd_state;
Vy = log_see.yd_state;
theta = log_see.theta_state;
rd_model = zeros(length(log_see.time));
Cd = zeros(length(log_see.time));
Vr = zeros(length(log_see.time));
D_plate_vel = zeros(length(log_see.time));

% constants
S_plate = 0.1*0.1;
l_plate = 0.09;
rho = 1.225;
Izz = 0.000498;

for i = 1:length(log_see.time)

    Cd(i) = 0.0033*(90+rad2deg(theta(i)))+0.7;
    Vr(i) = sqrt((Vx(i)^2)+(Vy(i)^2));
    D_plate_vel(i) = 0.5*rho*(Vr(i)^2)*S_plate*Cd(i);
    rd_model(i) = (0.10+l_plate)*D_plate_vel(i)/Izz;

end

%% P4 : Complementary filters state estimation

figure_4 = figure('Visible', show_fig4, 'Position', [100 200 1000 800]);
set(figure_4,'defaulttextinterpreter','latex');

tiledlayout(3,2);

ax1 = nexttile;
plot(log_see.time, rad2deg(log_see.rd_ref),'LineWidth',1.5,'Color','g'); hold on;
plot(log_see.time, rad2deg(log_see.rd_state_f),'LineWidth',1.2,'Color','b','LineStyle','--'); hold on;
plot(log_see.time, rad2deg(log_see.rd_estimated),'LineWidth',1.2,'Color','r'); hold on;
plot(log_see.time, rad2deg(log_see.rd_estimated_f),'LineWidth',1.2,'Color','r','LineStyle','--'); hold on;
plot(log_see.time, rad2deg(log_see.rd_state_f_undelayed),'LineWidth',1.2,'Color','b'); hold on;
plot(log_see.time, rad2deg(rd_model),'LineWidth',2,'Color','m');
grid minor;
legend('ref','state filt','estimated','estimated filt','undelayed','model','Interpreter','latex');
xlabel("time [sec]");
ylabel("$$r_d$$ [deg/sec^2]");
title("Complementary Filter Performance - ",legend_1);

ax2 = nexttile;
plot(log_see.time, rad2deg(log_see.psi_ref),'LineWidth',0.8,'Color','b',LineStyle='--'); hold on;
plot(log_see.time, rad2deg(log_see.psi_state),'LineWidth',0.8,'Color','b');
grid minor;
legend('cmd','ref',legend_1,'Interpreter','latex');
xlabel("time [sec]");
ylabel("$$\psi$$ [deg]");
title("Yaw Tracking");

ax3 = nexttile;
plot(log_see.time, (log_see.xd_state),'LineWidth',1.5,'Color','b'); hold on;
plot(log_see.time, (log_see.yd_state),'LineWidth',1.5,'Color','r');
grid minor;
legend('Vx','Vy','Interpreter','latex');
xlabel("time [sec]");
ylabel("$$\psi$$ [deg]");
title("Velocity in Earth Frame");


ax4 = nexttile;
plot(log_see.time, Cd,'LineWidth',0.8,'Color','b');
grid minor;
legend('theta','Interpreter','latex');
xlabel("time [sec]");
ylabel("$$\theta$$ [deg]");
title("Cd");

ax5 = nexttile;
plot(log_see.time, D_plate_vel,'LineWidth',1.5,'Color','b');
grid minor;
legend('Vx','Vy','Interpreter','latex');
xlabel("time [sec]");
ylabel("$$\psi$$ [deg]");
title("Drag");


ax6 = nexttile;
plot(log_see.time, rad2deg(log_see.theta_state),'LineWidth',0.8,'Color','b');
grid minor;
legend('theta','Interpreter','latex');
xlabel("time [sec]");
ylabel("$$\theta$$ [deg]");
title("Theta");


linkaxes([ax1,ax2,ax3,ax4,ax5,ax6], 'x');

%% P7 : Looking at actuators

figure_7 = figure('Visible', show_fig7, 'Position', [100 200 1000 800]);
set(figure_7,'defaulttextinterpreter','latex');

tiledlayout(2,1);

ax1 = nexttile;
plot(log_see.time, log_see.act_cmd_1,'LineWidth',1.2,'Color','b','LineStyle','--'); hold on;
plot(log_see.time, log_see.act_state_1,'LineWidth',1.2,'Color','b'); hold on;
plot(log_see.time, log_see.act_cmd_2,'LineWidth',1.2,'Color','g','LineStyle','--'); hold on;
plot(log_see.time, log_see.act_state_2,'LineWidth',1.2,'Color','g'); hold on;
plot(log_see.time, log_see.act_cmd_3,'LineWidth',1.2,'Color','c','LineStyle','--'); hold on;
plot(log_see.time, log_see.act_state_3,'LineWidth',1.2,'Color','c'); hold on;
plot(log_see.time, log_see.act_cmd_4,'LineWidth',1.2,'Color','r','LineStyle','--'); hold on;
plot(log_see.time, log_see.act_state_4,'LineWidth',1.2,'Color','r');
grid minor;
legend('cmd 1','state 1','cmd 2','state 2','cmd 3','state 3','cmd 4','state 4','Interpreter','latex');
xlabel("time [sec]");
ylabel("RPM");
title("Actuator States - ", legend_1);

ax2 = nexttile;
plot(log_see.time, rad2deg(log_see.psi_cmd),'LineWidth',0.8,'Color','k'); hold on;
plot(log_see.time, rad2deg(log_see.psi_ref),'LineWidth',0.8,'Color','b',LineStyle='--'); hold on;
plot(log_see.time, rad2deg(log_see.psi_state),'LineWidth',0.8,'Color','b'); hold on;
grid minor;
legend('cmd','ref',legend_1,'Interpreter','latex');
xlabel("time [sec]");
ylabel("$$\psi$$ [deg]");
title("Yaw Tracking");

linkaxes([ax1,ax2], 'x');

%% P9 : Error Terms for Pseudo Control Input

figure_9 = figure('Visible', show_fig9, 'Position', [100 200 1000 800]);
set(figure_9,'defaulttextinterpreter','latex');

tiledlayout(1,1);

ax1 = nexttile;
plot(log_see.time, log_see.qdd_ref,'LineWidth',1.0,'Color','k','LineStyle','--'); hold on;
plot(log_see.time, log_see.theta_att_err,'LineWidth',1.2,'Color','b'); hold on;
plot(log_see.time, log_see.q_rate_err,'LineWidth',1.2,'Color','r'); hold on;
plot(log_see.time, log_see.q_acc_err,'LineWidth',1.2,'Color','g'); hold on;
grid minor;
legend('ref','error att','error rate','error acc','Interpreter','latex');
xlabel("time [sec]");
ylabel("acceleration");
title("Error Terms Sim - ", legend_1);

linkaxes([ax1], 'x');