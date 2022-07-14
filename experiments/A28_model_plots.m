%% Doublet 

% extract information to be read
% log_name = 'test_data/model_plots/model_data_steps.csv';
log_name = 'test_data/model_plots/model_data_lemniscate.csv';

% read the file
opts = detectImportOptions(log_name);
log = readmatrix(log_name,opts);
preview(log_name,opts);

start = round(0.1*length(log(:,1)));
finish = round(0.9*length(log(:,1)));

% get the data
time = log(start:finish,1);
state_f = log(start:finish,2);
state_est = log(start:finish,3);
model_est = log(start:finish,4);
model_guess = log(start:finish,5);
model_opt = log(start:finish,6);

show_fig1 = 1;
show_fig2 = 1;
show_fig3 = 1;

width = 600;
height = 250;


%% P1 : Drag Plate Effect
figure_1 = figure('Visible', show_fig1, 'Position', [100 200 width height]);
set(figure_1,'defaulttextinterpreter','latex');

plot(time, state_f,'LineWidth',1.2,'Color','r'); hold on;
plot(time, state_est,'LineWidth',1.2,'Color','g',LineStyle='--'); hold on;
plot(time, model_est,'LineWidth',1.6,'Color','b',LineStyle='--'); hold on;
grid minor;
legend('$\dot{q}_f$','$\dot{q}_{\textbf{G}f}$','$\dot{q}_f-\dot{q}_{\textbf{G}f} = \dot{q}_{\textbf{A}f}$','Interpreter','latex');
xlabel("time [sec]");
ylabel("$\dot{q}$ [rad/sec$^2$]");

exportgraphics(gcf,'step_plate_effect.pdf','ContentType','vector')

%% P2 : Optimisation
figure_2 = figure('Visible', show_fig2, 'Position', [100 200 width height]);
set(figure_2,'defaulttextinterpreter','latex');

plot(time, model_est,'LineWidth',1.6,'Color','m'); hold on;
plot(time, model_guess,'LineWidth',1.2,'Color','c'); hold on;
plot(time, model_opt,'LineWidth',1.2,'Color','b'); hold on;
grid minor;
legend('$\dot{q}_{\textbf{A}f}$','$\dot{q}_{\textbf{A}f}$ guess','$\dot{q}_{\textbf{A}f}$ optimized','Interpreter','latex');
xlabel("time [sec]");
ylabel("$$\dot{q}_f-\dot{q}_{\omega f}$$ [rad/sec$^2$]");

exportgraphics(gcf,'step_optimized_model.pdf','ContentType','vector')

%% P3 : Fit
figure_3 = figure('Visible', show_fig3, 'Position', [100 200 width height]);
set(figure_3,'defaulttextinterpreter','latex');

plot(time, state_f,'LineWidth',1.2,'Color','r'); hold on;
plot(time, state_est - model_guess,'LineWidth',1.2,'Color','g'); hold on;
plot(time, state_est - model_opt,'LineWidth',1.6,'Color','b'); hold on;
grid minor;
legend('$\dot{q}_f$','$\dot{q}_{\omega f}$ guess','$\dot{q}_{\omega f}$ optimized','Interpreter','latex');
xlabel("time [sec]");
ylabel("$\dot{q}$ [rad/sec$^2$]");

exportgraphics(gcf,'step_model_fit.pdf','ContentType','vector')