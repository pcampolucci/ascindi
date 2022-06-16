%% Doublet 

%%% 1 : Process Data from workspace
% Data 1: qd_ref
% Data 2: q_ref
% Data 3: theta_ref
% Data 4: qd_f
% Data 5: q
% Data 6: theta

% get data
indi = get(out1.indi);
acindi_f = get(out2.acindi_f);
acindi_cf = get(out3.acindi_cf);
ascindi_f = get(out4.ascindi_f);
ascindi_cf = get(out5.ascindi_cf);

% set legend
legend_1 = "INDI";
legend_2 = "ACINDI";
legend_3 = "ACINDI+";
legend_4 = "ASCINDI";
legend_5 = "ASCINDI+";

% show fig
show_fig1 = false;
show_fig2 = false;
show_fig3 = false;
show_fig4 = false;
show_fig5 = true;
show_fig6 = false;

%% P1 : Tracking Performance All
figure_1 = figure('Visible', show_fig1, 'Position', [100 200 1000 800]);
set(figure_1,'defaulttextinterpreter','latex');

tiledlayout(3,1);

ax1 = nexttile;
% INDI
plot(indi.Time, rad2deg(indi.Data(:,3)),'LineWidth',1.2,'Color','b',LineStyle='--'); hold on;
plot(indi.Time, rad2deg(indi.Data(:,6)),'LineWidth',1.2,'Color','b'); hold on;
% ACINDI
plot(acindi_f.Time, rad2deg(acindi_f.Data(:,3)),'LineWidth',1.2,'Color','r',LineStyle='--'); hold on;
plot(acindi_f.Time, rad2deg(acindi_f.Data(:,6)),'LineWidth',1.2,'Color','r'); hold on;
% ACINDI+
plot(acindi_cf.Time, rad2deg(acindi_cf.Data(:,3)),'LineWidth',1.2,'Color','c',LineStyle='--'); hold on;
plot(acindi_cf.Time, rad2deg(acindi_cf.Data(:,6)),'LineWidth',1.2,'Color','c'); hold on;
% ASCINDI
plot(ascindi_f.Time, rad2deg(ascindi_f.Data(:,3)),'LineWidth',1.2,'Color','g',LineStyle='--'); hold on;
plot(ascindi_f.Time, rad2deg(ascindi_f.Data(:,6)),'LineWidth',1.2,'Color','g'); hold on;
% ASCINDI+
plot(ascindi_cf.Time, rad2deg(ascindi_cf.Data(:,3)),'LineWidth',1.2,'Color','m',LineStyle='--'); hold on;
plot(ascindi_cf.Time, rad2deg(ascindi_cf.Data(:,6)),'LineWidth',1.2,'Color','m'); hold on;
grid minor;
legend('ref',legend_1,'ref',legend_2,'ref',legend_3,'ref',legend_4,'ref',legend_5,'Interpreter','latex');
xlabel("time [sec]");
ylabel("$$\theta$$ [deg]");

ax2 = nexttile;
% INDI
plot(indi.Time, rad2deg(indi.Data(:,2)),'LineWidth',1.2,'Color','b',LineStyle='--'); hold on;
plot(indi.Time, rad2deg(indi.Data(:,5)),'LineWidth',1.2,'Color','b'); hold on;
% ACINDI
plot(acindi_f.Time, rad2deg(acindi_f.Data(:,2)),'LineWidth',1.2,'Color','r',LineStyle='--'); hold on;
plot(acindi_f.Time, rad2deg(acindi_f.Data(:,5)),'LineWidth',1.2,'Color','r'); hold on;
% ACINDI+
plot(acindi_cf.Time, rad2deg(acindi_cf.Data(:,2)),'LineWidth',1.2,'Color','c',LineStyle='--'); hold on;
plot(acindi_cf.Time, rad2deg(acindi_cf.Data(:,5)),'LineWidth',1.2,'Color','c'); hold on;
% ASCINDI
plot(ascindi_f.Time, rad2deg(ascindi_f.Data(:,2)),'LineWidth',1.2,'Color','g',LineStyle='--'); hold on;
plot(ascindi_f.Time, rad2deg(ascindi_f.Data(:,5)),'LineWidth',1.2,'Color','g'); hold on;
% ASCINDI+
plot(ascindi_cf.Time, rad2deg(ascindi_cf.Data(:,2)),'LineWidth',1.2,'Color','m',LineStyle='--'); hold on;
plot(ascindi_cf.Time, rad2deg(ascindi_cf.Data(:,5)),'LineWidth',1.2,'Color','m'); hold on;
grid minor;
legend('ref',legend_1,'ref',legend_2,'ref',legend_3,'ref',legend_4,'ref',legend_5,'Interpreter','latex');
xlabel("time [sec]");
ylabel("$$q$$ [deg/sec]");

ax3 = nexttile;
% INDI
plot(indi.Time, rad2deg(indi.Data(:,1)),'LineWidth',1.2,'Color','b',LineStyle='--'); hold on;
plot(indi.Time, rad2deg(indi.Data(:,4)),'LineWidth',1.2,'Color','b'); hold on;
% ACINDI
plot(acindi_f.Time, rad2deg(acindi_f.Data(:,1)),'LineWidth',1.2,'Color','r',LineStyle='--'); hold on;
plot(acindi_f.Time, rad2deg(acindi_f.Data(:,4)),'LineWidth',1.2,'Color','r'); hold on;
% ACascindi_cf+
plot(acindi_cf.Time, rad2deg(acindi_cf.Data(:,1)),'LineWidth',1.2,'Color','c',LineStyle='--'); hold on;
plot(acindi_cf.Time, rad2deg(acindi_cf.Data(:,4)),'LineWidth',1.2,'Color','c'); hold on;
% ASCascindi_cf
plot(ascindi_f.Time, rad2deg(ascindi_f.Data(:,1)),'LineWidth',1.2,'Color','g',LineStyle='--'); hold on;
plot(ascindi_f.Time, rad2deg(ascindi_f.Data(:,4)),'LineWidth',1.2,'Color','g'); hold on;
% ASCascindi_cf+
plot(ascindi_cf.Time, rad2deg(ascindi_cf.Data(:,1)),'LineWidth',1.2,'Color','m',LineStyle='--'); hold on;
plot(ascindi_cf.Time, rad2deg(ascindi_cf.Data(:,4)),'LineWidth',1.2,'Color','m'); hold on;
grid minor;
legend('ref',legend_1,'ref',legend_2,'ref',legend_3,'ref',legend_4,'ref',legend_5,'Interpreter','latex');
xlabel("time [sec]");
ylabel("$qd$ [deg/sec^2]");

linkaxes([ax1,ax2,ax3], 'x');
%% P2 : Tracking Performance Theta
figure_2 = figure('Visible', show_fig2, 'Position', [100 200 1000 800]);
set(figure_2,'defaulttextinterpreter','latex');

tiledlayout(2,1);

ax1 = nexttile;
% INDI
plot(indi.Time, rad2deg(indi.Data(:,6)),'LineWidth',1.2,'Color','b'); hold on;
% ACINDI
plot(acindi_f.Time, rad2deg(acindi_f.Data(:,6)),'LineWidth',1.2,'Color','r'); hold on;
% ACINDI+
plot(acindi_cf.Time, rad2deg(acindi_cf.Data(:,6)),'LineWidth',1.2,'Color','c'); hold on;
% ASCINDI
plot(ascindi_f.Time, rad2deg(ascindi_f.Data(:,6)),'LineWidth',1.2,'Color','g'); hold on;
% ASCINDI+
plot(ascindi_cf.Time, rad2deg(ascindi_cf.Data(:,6)),'LineWidth',1.2,'Color','m'); hold on;
grid minor;
legend(legend_1,legend_2,legend_3,legend_4,legend_5,'Interpreter','latex');
xlabel("time [sec]");
ylabel("$$\theta$$ [deg]");

ax2 = nexttile;
% INDI
plot(indi.Time, rad2deg(indi.Data(:,3)),'LineWidth',1.2,'Color','b'); hold on;
% ACINDI
plot(acindi_f.Time, rad2deg(acindi_f.Data(:,3)),'LineWidth',1.2,'Color','r'); hold on;
% ACINDI+
plot(acindi_cf.Time, rad2deg(acindi_cf.Data(:,3)),'LineWidth',1.2,'Color','c'); hold on;
% ASCINDI
plot(ascindi_f.Time, rad2deg(ascindi_f.Data(:,3)),'LineWidth',1.2,'Color','g'); hold on;
% ASCINDI+
plot(ascindi_cf.Time, rad2deg(ascindi_cf.Data(:,3)),'LineWidth',1.2,'Color','m'); hold on;
grid minor;
legend(legend_1,legend_2,legend_3,legend_4,legend_5,'Interpreter','latex');
xlabel("time [sec]");
ylabel("$$\theta_{ref}$$ [deg]");

linkaxes([ax1,ax2], 'x');

%% P3 : Theta Error
figure_3 = figure('Visible', show_fig3, 'Position', [100 200 1000 800]);
set(figure_3,'defaulttextinterpreter','latex');

indi_e = abs(rad2deg(indi.Data(:,6)) - rad2deg(indi.Data(:,3)));
acindi_f_e = abs(rad2deg(acindi_f.Data(:,6)) - rad2deg(acindi_f.Data(:,3)));
acindi_cf_e = abs(rad2deg(acindi_cf.Data(:,6)) - rad2deg(acindi_cf.Data(:,3)));
ascindi_f_e = abs(rad2deg(ascindi_f.Data(:,6)) - rad2deg(ascindi_f.Data(:,3)));
ascindi_cf_e = abs(rad2deg(ascindi_cf.Data(:,6)) - rad2deg(ascindi_cf.Data(:,3)));

cmd = zeros(length(indi.Time),1);

for i = 1:length(indi.Time)
    if indi.Time(i) >= 1 && indi.Time(i) < 4
        cmd(i,1) = -0.15;
    elseif indi.Time(i) >= 4 && indi.Time(i) < 7
        cmd(i,1) = 0.15;
    end
end

tiledlayout(2,1);

ax1 = nexttile;
plot(indi.Time, rad2deg(cmd),'LineWidth',0.8,'Color','k'); hold on;
% INDI
plot(indi.Time, rad2deg(indi.Data(:,6)),'LineWidth',1.2,'Color','b'); hold on;
% ACINDI
plot(acindi_f.Time, rad2deg(acindi_f.Data(:,6)),'LineWidth',1.2,'Color','r'); hold on;
% ACINDI+
plot(acindi_cf.Time, rad2deg(acindi_cf.Data(:,6)),'LineWidth',1.2,'Color','c'); hold on;
% ASCINDI
plot(ascindi_f.Time, rad2deg(ascindi_f.Data(:,6)),'LineWidth',1.2,'Color','g'); hold on;
% ASCINDI+
plot(ascindi_cf.Time, rad2deg(ascindi_cf.Data(:,6)),'LineWidth',1.2,'Color','m'); hold on;
grid minor;
legend('cmd',legend_1,legend_2,legend_3,legend_4,legend_5,'Interpreter','latex');
xlabel("time [sec]");
ylabel("$$\theta$$ [deg]");

ax2 = nexttile;
% INDI
plot(indi.Time, indi_e,'LineWidth',1.2,'Color','b'); hold on;
% ACINDI
plot(acindi_f.Time, acindi_f_e,'LineWidth',1.2,'Color','r'); hold on;
% ACINDI+
plot(acindi_cf.Time, acindi_cf_e,'LineWidth',1.2,'Color','c'); hold on;
% ASCINDI
plot(ascindi_f.Time, ascindi_f_e,'LineWidth',1.2,'Color','g'); hold on;
% ASCINDI+
plot(ascindi_cf.Time, ascindi_cf_e,'LineWidth',1.2,'Color','m'); hold on;
grid minor;
legend(legend_1,legend_2,legend_3,legend_4,legend_5,'Interpreter','latex');
xlabel("time [sec]");
ylabel("$\theta_e$ [deg]");

linkaxes([ax1,ax2], 'x');

%% P4 : Box Plots
figure_4 = figure('Visible', show_fig4, 'Position', [100 200 1000 800]);
set(figure_4,'defaulttextinterpreter','latex');

errors = [indi_e, acindi_f_e, acindi_cf_e, ascindi_f_e, ascindi_cf_e];
colors = ['b','r','c','g','m']; 

boxplot(errors,'Colors',colors,'Widths',0.8)
grid minor;
xlabel('Controller Configurations');
ylabel('Tracking Error');
legend(findobj(gca,'Tag','Box'),legend_1,legend_2,legend_3,legend_4,legend_5,'Interpreter','latex');
%% P5 : Theta Tracking - 1 Plot
figure_5 = figure('Visible', show_fig5, 'Position', [100 200 600 500]);
set(figure_5,'defaulttextinterpreter','latex');

plot(indi.Time, rad2deg(cmd),'LineWidth',0.8,'Color','k'); hold on;
% INDI
plot(indi.Time, rad2deg(indi.Data(:,6)),'LineWidth',1.2,'Color','b'); hold on;
% ACINDI
plot(acindi_f.Time, rad2deg(acindi_f.Data(:,6)),'LineWidth',1.2,'Color','r'); hold on;
% ACINDI+
plot(acindi_cf.Time, rad2deg(acindi_cf.Data(:,6)),'LineWidth',1.2,'Color','c'); hold on;
% ASCINDI
plot(ascindi_f.Time, rad2deg(ascindi_f.Data(:,6)),'LineWidth',1.2,'Color','g'); hold on;
% ASCINDI+
plot(ascindi_cf.Time, rad2deg(ascindi_cf.Data(:,6)),'LineWidth',1.2,'Color','m'); hold on;
grid minor;
legend('cmd',legend_1,legend_2,legend_3,legend_4,legend_5,'Interpreter','latex');
xlabel("time [sec]");
ylabel("$$\theta$$ [deg]");

%% P6 : Theta Error - 1 Plot
figure_6 = figure('Visible', show_fig6, 'Position', [100 200 1000 800]);
set(figure_6,'defaulttextinterpreter','latex');

% INDI
plot(indi.Time, indi_e,'LineWidth',1.2,'Color','b'); hold on;
% ACINDI
plot(acindi_f.Time, acindi_f_e,'LineWidth',1.2,'Color','r'); hold on;
% ACINDI+
plot(acindi_cf.Time, acindi_cf_e,'LineWidth',1.2,'Color','c'); hold on;
% ASCINDI
plot(ascindi_f.Time, ascindi_f_e,'LineWidth',1.2,'Color','g'); hold on;
% ASCINDI+
plot(ascindi_cf.Time, ascindi_cf_e,'LineWidth',1.2,'Color','m'); hold on;
grid minor;
legend(legend_1,legend_2,legend_3,legend_4,legend_5,'Interpreter','latex');
xlabel("time [sec]");
ylabel("$\theta_E$ [deg]");