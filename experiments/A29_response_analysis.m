%% Response analysis to step response

%%% 1 : Process Data from workspace
% Data 1: qd_ref
% Data 2: q_ref
% Data 3: theta_ref
% Data 4: qd_f
% Data 5: q
% Data 6: theta

% get data
indi = get(out_indi.simout);
acindi = get(out_acindi.simout);
ascindi = get(out_ascindi.simout); 

% show fig
show_fig1 = 1;

% get error tracking
err_indi = abs(rad2deg(indi.Data(:,3))-rad2deg(indi.Data(:,6)));
err_acindi = abs(rad2deg(indi.Data(:,3))-rad2deg(acindi.Data(:,6)));
err_ascindi = abs(rad2deg(indi.Data(:,3))-rad2deg(ascindi.Data(:,6)));

%% P1 : Tracking Performance All
figure_1 = figure('Visible', show_fig1, 'Position', [100 200 600 500]);
set(figure_1,'defaulttextinterpreter','latex');

tiledlayout(2,1);

ax1 = nexttile;
% INDI
plot(indi.Time, rad2deg(indi.Data(:,6)),'LineWidth',1.2,'Color','b'); hold on;
% ACINDI
plot(acindi.Time, rad2deg(acindi.Data(:,6)),'LineWidth',1.2,'Color','r'); hold on;
% ACINDI+
plot(ascindi.Time, rad2deg(ascindi.Data(:,6)),'LineWidth',1.2,'Color','g'); hold on;
% reference
plot(indi.Time, rad2deg(indi.Data(:,3)),'LineWidth',1.2,'Color','k',LineStyle='--'); hold on;
grid minor;
ylim([-15 10])
xline(2,LineStyle="--");
xline(3,LineStyle="--");
legend('INDI','ACINDI','ASCINDI','reference','Interpreter','latex');
xlabel("time [sec]");
ylabel("$$\theta$$ [deg]");

ax2 = nexttile;
plot(indi.Time, err_indi,'LineWidth',1.2,'Color','b'); hold on;
plot(acindi.Time, err_acindi,'LineWidth',1.2,'Color','r'); hold on;
plot(ascindi.Time, err_ascindi,'LineWidth',1.2,'Color','g'); hold on;
grid minor;
xline(2,LineStyle="--");
xline(3,LineStyle="--");
legend('INDI','ACINDI','ASCINDI','Interpreter','latex');
xlabel("time [sec]");
ylabel("$$|\theta_{ref} - \theta|$$ [deg]");

linkaxes([ax1,ax2], 'x');

exportgraphics(gcf,'step_response.pdf','ContentType','vector')
