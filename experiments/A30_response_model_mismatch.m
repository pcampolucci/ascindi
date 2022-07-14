%% Response analysis effect due to model mismatch

% get data
ref = reference_list; 

% show fig
show_fig1 = 1;

legend_list = ["reference"];

% legend list
for i = 1:n_intervals
    legend_i = strcat("$$\ddot{q}_{\hat{x}} = $$", string(coeff_list(i)), "$$\cdot \ddot{q}_{x}$$");
    legend_list(i+1) = legend_i;
end

%% P1 : Tracking Performance All
figure_1 = figure('Visible', show_fig1, 'Position', [100 200 1000 800]);
set(figure_1,'defaulttextinterpreter','latex');

% reference
plot(time, ref,'LineWidth',1.2,'Color','k',LineStyle='--'); hold on;
% different model
for i = 1:n_intervals
    plot(time,response_list(:,i),LineWidth=1.2); hold on;
end
grid minor;
xlim([1.5,5.5]);
ylim([-0.4,0.05]);
legend(legend_list,'Interpreter','latex','Location','southwest');
xlabel("time [sec]");
ylabel("$$\theta$$ [rad]");

exportgraphics(gcf,'plots/model_mismatch.pdf','ContentType','vector')