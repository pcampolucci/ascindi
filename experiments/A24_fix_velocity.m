%% Doublet 

%%% 1 : Process Data from Logger

folder = '06_03_22_fix_issues/';

start_log = 0.1;
end_log = 0.9;

log_1 = logger(strcat(folder,'test3'), start_log, end_log);

%%% 2 : control panel on showing figures or not

show_fig1 = true;

%%% 3 : simulate outlier detection

thrs = 0.2;

xd_state_od = zeros(1,length(log_1.time));

for i = 2:(length(log_1.time)-1)
    jump = abs(log_1.xd_state(i)-xd_state_od(i-1));
    jump_x = abs(log_1.xd_state(i+1)-log_1.xd_state(i));
    if jump > thrs && jump_x == 0
        xd_state_od(i) = xd_state_od(i-1);
    else
        xd_state_od(i) = log_1.xd_state(i);
    end
end

%% P1 : Tracking Performance Overview
figure_1 = figure('Visible', show_fig1, 'Position', [100 200 1000 800]);
set(figure_1,'defaulttextinterpreter','latex');

tiledlayout(2,1);

ax1 = nexttile;
plot(log_1.time, (log_1.qd_ref),'LineWidth',1.5,'Color','g'); hold on;
plot(log_1.time, (log_1.qd_state_f),'LineWidth',1.2,'Color','m'); hold on;
plot(log_1.time, (log_1.qd_estimated_f),'LineWidth',1.2,'Color','r'); hold on;
plot(log_1.time, (log_1.qd_state_f_undelayed),'LineWidth',1.2,'Color','b'); 
grid minor;
legend('ref','state filt','estimated filt','undelayed','Interpreter','latex');
xlabel("time [sec]");
ylabel("$$qd$$ [deg/sec^2]");
title("Complementary Filter Performance");

ax2 = nexttile;
plot(log_1.time, log_1.xd_state,'LineWidth',1.2,'Color','b'); hold on;
plot(log_1.time, log_1.xd_state_f,'LineWidth',1.2,'Color','b',LineStyle='--'); hold on;
plot(log_1.time, log_1.yd_state,'LineWidth',1.2,'Color','r'); hold on;
plot(log_1.time, log_1.yd_state_f,'LineWidth',1.2,'Color','r',LineStyle='--'); hold on;
% plot(log_1.time, xd_state_od,'LineWidth',1.2,'Color','g'); hold on;
grid minor;
legend('x','x_f','Interpreter','latex');
xlabel("time [sec]");
ylabel("$$V$$ [m/s]");
title("Velocity Optitrack");

linkaxes([ax1,ax2], 'x');