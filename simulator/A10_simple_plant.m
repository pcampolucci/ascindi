%% Parameters for simple plant concept

% settings
sample_time = 0.002;
filters_on = 0;
filter_cutoff = 2*pi*5;

% actuator dynamics
K_act = 50;

% attitude gains
K_att = 10;
K_rate = 15;
K_acc = 50;

% error gains
K_err_att = 10+K_act;
K_err_rate = 10*(1+K_act);
K_err_acc = 10*(1+K_act);

% vehicle geometry and mass
b = 0.095;
l = 0.08;
m = 0.4;

% inertia matrix
I = eye(3,3);
I(1,1) = Ixx;
I(2,2) = Iyy;
I(3,3) = Izz;

% Thrust and moment coefficients
% --> T [N] = K_t * omega [RPM]
K_t = 0.0005;
K_m = 0.00005;

% effectiveness matrix
G1_r = [-b*K_t b*K_t b*K_t -b*K_t;
        l*K_t l*K_t -l*K_t -l*K_t;
        K_m -K_m K_m -K_m];

G1 = inv(I)*G1_r;





