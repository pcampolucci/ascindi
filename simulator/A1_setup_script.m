%% Setup script for Bebop quadcopter

% Actuator Specifications
sampling_time = 0.002;
omega_c_motors = 50;
delay_motor = 0.15; 
max_omega_motor = 11000;
max_motor_rate = 30000;
delay_motor_Ts = round(delay_motor/sampling_time);

% Doublet settings
doublet_mag = - 0.15;
start_time = 1;
doublet_time = 6;

% Drag plate settings
w_plate = 0.36;
h_plate = 0.16;
Cd_plate = 1.28;
l_plate = 0.11;

% 8-shape trajectory settings
scale_8 = 1.6;
f_8 = 1;
t_8 = 10;
start_8 = 2;

%% Settings to slow down the actuator dynamics

% actuator data
omega_des = 20.00;
frequency = 500;
sampling_time = 1/frequency;

% transfer functions actuator
tf_act = tf([omega_c_motors],[1 omega_c_motors]);
tf_act_inv = tf([1 omega_c_motors],[omega_c_motors]);

% transfer function desired
tf_des = tf([omega_des],[1 omega_des]);

% transfer function for the forward path
tf_fwd = minreal(tf_act_inv*tf_des);

% discrete transfer functions to implement
tf_des_d = c2d(tf_des,sampling_time);
tf_fwd_d = c2d(tf_fwd,sampling_time);

% visualize better
tf_des_d.variable = "z^-1";
tf_fwd_d.variable = "z^-1";

% get coeffs for simulator
coef_sim_1 = tf_des_d.Denominator{1}(2);
coef_sim_2 = tf_des_d.Numerator{1}(2);

% get coeffs for paparazzi implementation
coef_1 = -tf_fwd_d.Denominator{1}(2);
coef_2 = tf_fwd_d.Numerator{1}(1);
coef_3 = tf_fwd_d.Numerator{1}(2);
slow_dyn = tf_des_d.Numerator{1}(2);

line = ['\n<define name="FWD_COEF1" value="',num2str(coef_1),'"/>\n',...
        '<define name="FWD_COEF2" value="',num2str(coef_2),'"/>\n',...
        '<define name="FWD_COEF3" value="',num2str(coef_3),'"/>\n',...
        '<define name="ACT_DYN_SLOW" value="{',num2str(slow_dyn),',',num2str(slow_dyn),',',num2str(slow_dyn),',',num2str(slow_dyn),'}"/>\n',...
        '<define name="ACT_GAIN_SLOW" value="',num2str(omega_des),'"/>\n'];

fprintf(line)

% motor
K_act     = omega_des;

% roll/pitch/yaw
K_ec_i  = 380;
K_ec    = 251;
K_ec_d  = 25;
K_ec_dd = 45;
K       = 10;
K_d     = 25;
K_dd    = K_act;

% horizontal
K_ec_u    = 5;
K_ec_d_u  = 5;
K_u       = 1.5;
K_u_d     = 7;
K_u_dd    = K;

% lateral
K_ec_v    = 5;
K_ec_d_v  = 5;
K_v       = 1.5;
K_v_d     = 7;
K_v_dd    = K;

% vertical
K_ec_w    = 5;
K_ec_d_w  = 5;
K_w       = 4.5;
K_w_d     = 7;
K_w_dd    = K;

% actuator compensation outer loop
K_dyn = K;
K_act_outer = diag([K K K_act]); 

%% Actuator Consideration Inner Loop

% matrix for 4 motors
K_act_inner = K_act*eye(4);
K_act_inner_simple = K_act*eye(3);

%% Additional info for discrete controller

% Inertia in [kg*m^2]
Ixx = 0.0012458;
Iyy = 0.0015;
Izz = 0.00015;
I_r_zz = 1.8*10^(-8);

% build inertia matrix
I = eye(3,3);
I(1,1) = Ixx;
I(2,2) = Iyy;
I(3,3) = Izz;

% vehicle geometry and mass
b = 0.095;
l = 0.08;
m = 0.4;

% thrust and moment gains

% for omega squared
K_t = 6.557*10^(-8);
K_m = 9.680*10^(-10);

% build the effectiveness matrices
G1_r = [-b*K_t b*K_t b*K_t -b*K_t;
        l*K_t l*K_t -l*K_t -l*K_t;
        K_m -K_m K_m -K_m];
G1 = 2*inv(I)*G1_r;
G1_T = [-2*K_t -2*K_t -2*K_t -2*K_t];
G1 = [G1;G1_T];
G1_s = -1000*G1;

gmat = ['\n<define name="G1_ROLL" value="{',num2str(G1_s(1,1)),',',num2str(G1_s(1,2)),',',num2str(G1_s(1,3)),',',num2str(G1_s(1,4)),'}"/>\n',...
        '<define name="G1_PITCH" value="{',num2str(G1_s(2,1)),',',num2str(G1_s(2,2)),',',num2str(G1_s(2,3)),',',num2str(G1_s(2,4)),'}"/>\n',...
        '<define name="G1_YAW" value="{',num2str(G1_s(3,1)),',',num2str(G1_s(3,2)),',',num2str(G1_s(3,3)),',',num2str(G1_s(3,4)),'}"/>\n',...
        '<define name="G1_THRUST" value="{',num2str(-G1_s(4,1)),',',num2str(-G1_s(4,2)),',',num2str(-G1_s(4,3)),',',num2str(-G1_s(4,4)),'}"/>\n'];

fprintf(gmat)

G2_r = [0 0 0 0;
        0 0 0 0;
        I_r_zz -I_r_zz I_r_zz -I_r_zz];
G2 = (1/sampling_time)*inv(I)*(G2_r);

% build the matrices from paparazzi
% Thrust and moment coefficients
% --> T [N] = K_t * omega [RPM]
K_t_simple = -0.00052387;
K_m_simple = -0.0052387;

% effectiveness matrix simple for inner loop
G1_r_simple = [-b*K_t_simple b*K_t_simple b*K_t_simple -b*K_t_simple;
        l*K_t_simple l*K_t_simple -l*K_t_simple -l*K_t_simple;
        K_m_simple -K_m_simple K_m_simple -K_m_simple];

G1_simple = inv(I)*G1_r_simple;

% other parameters
FILTER = 1;
NOISE = 0;
FILT_CUTOFF = 2*pi*5;
SCALE = 1000;
NOISE_GYRO = 0.00005;
NOISE_ACC = 0.00005;
NOISE_RPM = 200;






