%% Doublet 

% extract information to be read
log_name = 'model_plots/model_data.csv';

% read the file
opts = detectImportOptions(log_name);
log = readmatrix(log_name,opts);
preview(log_name,opts);

% get the data
time = log(:,1);
state_f = log(:,2);
state_est = log(:,3);
model_est = log(:,4);
model_guess = log(:,5);
model_opt = log(:,6);

show_fig1 = 1;
show_fig2 = 1;



%% P1 : Drag Plate Effect
figure_1 = figure('Visible', show_fig1, 'Position', [100 200 600 500]);
set(figure_1,'defaulttextinterpreter','latex');

plot(time, state_f,'LineWidth',1.2,'Color','r'); hold on;
plot(time, state_est,'LineWidth',1.2,'Color','g',LineStyle='--'); hold on;
plot(time, model_est,'LineWidth',1.6,'Color','b',LineStyle='--'); hold on;
grid minor;
legend('$\dot{q}_f$','$\dot{q}_{\omega f}$','$\dot{q}_f-\dot{q}_{\omega f}$','Interpreter','latex');
xlabel("time [sec]");
ylabel("$\dot{q}$ [deg/sec$^2$]");

%% P2 : Optimisation
figure_2 = figure('Visible', show_fig2, 'Position', [100 200 600 500]);
set(figure_2,'defaulttextinterpreter','latex');

plot(time, model_est,'LineWidth',1.6,'Color','m'); hold on;
plot(time, model_guess,'LineWidth',1.2,'Color','c'); hold on;
plot(time, model_opt,'LineWidth',1.2,'Color','b'); hold on;
grid minor;
legend('model','guess','optimized','Interpreter','latex');
xlabel("time [sec]");
ylabel("$\dot{q}$ [deg/sec$^2$]");