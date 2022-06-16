%% Transfer function calculator for actuator speed decrease

% actuator data
omega_act = 50;
omega_des = 49;
frequency = 500;
sampling_time = 1/frequency;

% transfer functions actuator
tf_act = tf([omega_act],[1 omega_act]);
tf_act_inv = tf([1 omega_act],[omega_act]);

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

line = ['<define name="FWD_COEF1" value="',num2str(coef_1),'"/>\n',...
        '<define name="FWD_COEF2" value="',num2str(coef_2),'"/>\n',...
        '<define name="FWD_COEF3" value="',num2str(coef_3),'"/>\n',...
        '<define name="ACT_DYN_SLOW" value="{',num2str(slow_dyn),',',num2str(slow_dyn),',',num2str(slow_dyn),',',num2str(slow_dyn),'}"/>\n',...
        '<define name="ACT_GAIN_SLOW" value="',num2str(omega_des),'"/>\n'];

fprintf(line)
