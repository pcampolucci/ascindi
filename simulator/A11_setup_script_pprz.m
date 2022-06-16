%% Setup script for Bebop as in Paparazzi

% Actuator Specifications
sampling_time = 0.002;
omega_c_motors = 50;
max_omega_motor = 11000;
max_motor_rate = 30000;
coeff = 1;

% Doublet settings
doublet_mag = - 0.15;
start_time = 2;
doublet_time = 6;

% Drag plate settings
w_plate = 0.3;
h_plate = 0.3;
Cd_plate = 1.28;
l_plate = 0.1;

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
K_ec_i  = 0;
K_ec    = 50;
K_ec_d  = 13;
K_ec_dd = 9;
K       = 7;
K_d     = 15;
K_dd    = K_act;

% horizontal
K_ec_u    = 1.5;
K_ec_d_u  = 1.5;
K_u       = 1.0;
K_u_d     = 2.5;

% lateral
K_ec_v    = 1.5;
K_ec_d_v  = 1.5;
K_v       = 1.0;
K_v_d     = 2.5;

% vertical
K_ec_w    = 1.5;
K_ec_d_w  = 1.5;
K_w       = 1.0;
K_w_d     = 2.5;

%% Actuator Consideration Inner Loop

% matrix for 4 motors
K_act_inner = K_act*eye(4);

%% Additional info for discrete controller

% Inertia in [kg*m^2]
Ixx = 0.00085;
Iyy = 0.0008;
Izz = 0.000498;
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

%% Inner Loop Effectiveness Matrix, Based on
% <define name="G1_ROLL" value="{ 17.240559362889638 , -18.083739292387513 , -15.561530992883556 , 17.094093419206075 }"/>
% <define name="G1_PITCH" value="{ 10.412087993707312 , 9.723289187503902 , -10.631961065633664 , -12.109084226675817 }"/>
% <define name="G1_YAW" value="{ -1.0214244977786902 , 1.0000000000000002 , -1.243209099982906 , 1.0000000000000002 }"/>
% <define name="G1_THRUST" value="{-.4, -.4, -.4, -.4}"/>
% <define name="G2" value="{-61.2093,   65.3670,  -65.7419,   65.4516}"/>

% get the thrust coefficient for model
K_t = 6.557*10^(-8);

% build the effectiveness matrices
G1 = [17 -18 -15 17;
      10 9 -10 -12;
      -1 1 -1 1;
      -0.4 -0.4 -0.4 -0.4];

G2 = [0 0 0 0;
      0 0 0 0;
      -61 65 -65 65];

scale = 1000;

G1 = G1/scale;
G2 = G2/scale;

% other parameters
FILTER = 1;
NOISE = 0;
FILT_CUTOFF = 2*pi*5;
SCALE = 1000;
NOISE_GYRO = 0.00005;
NOISE_ACC = 0.00005;
NOISE_RPM = 200;






