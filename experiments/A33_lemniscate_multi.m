%% Doublet 

%%% 1 : Process Data from Logger

folder = 'test_data/07_06_22_lemniscate/';

start_log = 0.2;
end_log = 0.9;

log_1 = logger(strcat(folder,'lemniscate_0'), start_log, end_log);
log_2 = logger(strcat(folder,'lemniscate_02'), start_log, end_log);
log_3 = logger(strcat(folder,'lemniscate_04'), start_log, end_log);
log_4 = logger(strcat(folder,'lemniscate_06'), start_log, end_log);
log_5 = logger(strcat(folder,'lemniscate_08'), start_log, end_log);
log_6 = logger(strcat(folder,'lemniscate_1'), start_log, end_log);

% time shift between signals
shift_2 = -9.8954;
shift_3 = -59.4872;

%%% 2 : control panel on showing figures or not
show_fig1 = 1;
show_fig2 = 0;
show_fig3 = 1;

%%% 3 : align time
log_2.time = log_2.time + shift_2;
log_3.time = log_3.time + shift_3;

% % wrap psi
% for i = 1:length(log_1.time)
%     if log_1.psi_state(i) > 1
%         log_1.psi_state(i) = log_1.psi_state(i) - 2*pi;
%     end
% end
% 
% for i = 1:length(log_2.time)
%     if log_2.psi_state(i) > 1
%         log_2.psi_state(i) = log_2.psi_state(i) - 2*pi;
%     end
% end
% 
% for i = 1:length(log_3.time)
%     if log_3.psi_state(i) > 1
%         log_3.psi_state(i) = log_3.psi_state(i) - 2*pi;
%     end
% end

%% P1 : Tracking Performance Overview
% figure_1 = figure('Visible', show_fig1, 'Position', [100 200 600 870]);
% set(figure_1,'defaulttextinterpreter','latex','DefaultFigureRendererMode', 'manual');
% 
% tiledlayout(2,1,'TileSpacing','Compact','Padding','Compact');
% 
% theta_err_1 = abs(log_1.theta_ref-log_1.theta_state);
% theta_err_2 = abs(log_2.theta_ref-log_2.theta_state);
% theta_err_3 = abs(log_3.theta_ref-log_3.theta_state);
% theta_err_4 = abs(log_4.theta_ref-log_4.theta_state);
% theta_err_5 = abs(log_5.theta_ref-log_5.theta_state);
% theta_err_6 = abs(log_6.theta_ref-log_6.theta_state);
% 
% ax1 = nexttile;
% plot(log_1.time, rad2deg(log_1.theta_state),'LineWidth',1.2); hold on;
% plot(log_2.time, rad2deg(log_2.theta_state),'LineWidth',1.2); hold on;
% plot(log_3.time, rad2deg(log_3.theta_state),'LineWidth',1.2); hold on;
% plot(log_4.time, rad2deg(log_4.theta_state),'LineWidth',1.2); hold on;
% plot(log_5.time, rad2deg(log_5.theta_state),'LineWidth',1.2); hold on;
% plot(log_6.time, rad2deg(log_6.theta_state),'LineWidth',1.2); hold on;
% xlim([45,75]);
% grid minor;
% xlabel("time [sec]");
% ylabel("$$\theta$$ [deg]");
% 
% ax2 = nexttile;
% plot(log_1.time, rad2deg(theta_err_1),'LineWidth',1.2); hold on;
% plot(log_2.time, rad2deg(theta_err_2),'LineWidth',1.2); hold on;
% plot(log_3.time, rad2deg(theta_err_3),'LineWidth',1.2); hold on;
% plot(log_4.time, rad2deg(theta_err_4),'LineWidth',1.2); hold on;
% plot(log_5.time, rad2deg(theta_err_5),'LineWidth',1.2); hold on;
% plot(log_6.time, rad2deg(theta_err_6),'LineWidth',1.2); hold on;
% legend('0','02','04','06','08','1')
% % xlim([45,75]);
% grid minor;
% xlabel("time [sec]");
% ylabel("$$|\theta_{ref}-\theta|$$ [deg]");
% 
% linkaxes([ax1,ax2], 'x');

% exportgraphics(gcf,'lemniscate.pdf','ContentType','vector')

%% P2 : Tracking Error BoxPlot

% len = 7018;
% 
% theta_err_1 = theta_err_1(1:len);
% theta_err_2 = theta_err_2(1:len);
% theta_err_3 = theta_err_3(1:len);
% theta_err_4 = theta_err_4(1:len);
% theta_err_5 = theta_err_5(1:len);
% theta_err_6 = theta_err_6(1:len);

mse_1 = sqrt(mean((log_1.theta_ref-log_1.theta_state).^2));
mse_2 = sqrt(mean((log_2.theta_ref-log_2.theta_state).^2));
mse_3 = sqrt(mean((log_3.theta_ref-log_3.theta_state).^2));
mse_4 = sqrt(mean((log_4.theta_ref-log_4.theta_state).^2));
mse_5 = sqrt(mean((log_5.theta_ref-log_5.theta_state).^2));
mse_6 = sqrt(mean((log_6.theta_ref-log_6.theta_state).^2));

% figure_2 = figure('Visible', show_fig2, 'Position', [100 200 600 870]);
% set(figure_2,'defaulttextinterpreter','latex','DefaultFigureRendererMode', 'manual');
% 
% errors = [theta_err_1, theta_err_2, theta_err_3, theta_err_4, theta_err_5, theta_err_6];
% colors = ['b','r','c','g','m','k']; 
% 
% boxplot(errors,'Colors',colors,'Widths',0.8);
% grid minor;
% xlabel('Controller Configurations');
% ylabel('Tracking Error');
% legend(findobj(gca,'Tag','Box'),'1','08','06','04','02','0','Interpreter','latex');

%% P3: RMSE Theta tracking error

rmse_list = [mse_1, mse_2, mse_3, mse_4, mse_5, mse_6];
name_list = [0, 0.2, 0.4, 0.6, 0.8, 1];

figure_3 = figure('Visible', show_fig3, 'Position', [100 200 600 500]);
set(figure_3,'defaulttextinterpreter','latex','DefaultFigureRendererMode', 'manual');

Fit = polyfit(name_list,rmse_list,7);
plot(linspace(0,1,20),polyval(Fit,linspace(0,1,20))); hold on;
scatter(name_list, rmse_list);
grid minor;
xlabel('Scaling of State Term Compensation');
ylabel('RMSE $\theta$');

exportgraphics(gcf,'rmse_multi_lemniscate.pdf','ContentType','vector')




