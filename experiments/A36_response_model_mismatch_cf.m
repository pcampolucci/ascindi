%% Response analysis effect due to model mismatch

% get data
ref = reference_list_cf; 

% show fig
show_fig1 = 1;

legend_list = ["reference";"full delay"];

% legend list
for i = 2:n_intervals
    legend_i = strcat("$$\dot{q}_{\hat{\textbf{P}}} = $$", string(coeff_list_cf(i)), "$$\cdot \dot{q}_{\textbf{P}}$$");
    legend_list(i+1) = legend_i;
end

%% P1 : Tracking Performance All
figure_1 = figure('Visible', show_fig1, 'Position', [100 200 1000 800]);
set(figure_1,'defaulttextinterpreter','latex');

% reference
plot(time, ref,'LineWidth',1.2,'Color','k',LineStyle='--'); hold on;
plot(time,response_list_cf(:,1),'Color','r',LineWidth=0.8,LineStyle='--'); hold on;
% different model
for i = 2:n_intervals
    plot(time,response_list_cf(:,i),LineWidth=1.2); hold on;
end
grid minor;
legend(legend_list,'Interpreter','latex','Location','southwest');
xlabel("time [sec]");
ylabel("$$\theta$$ [rad]");

exportgraphics(gcf,'plots/model_mismatch_cf.pdf','ContentType','vector')