clc
clear all

%% Effectiveness Matrix Generator for Cascaded Controller

%% Symbolise

% fixed parameters
syms b l;
syms K_t K_m ;
syms Ixx Iyy Izz;
syms m g;
assume(b, 'real'); assume(l, 'real'); 
assume(K_t, 'real'); assume(K_m, 'real'); 
assume(Ixx, 'real'); assume(Iyy, 'real'); assume(Izz, 'real'); 
assume(m, 'real'); assume(g, 'real');

% state variables
syms p q r;
syms Phi Theta Psi;
assume(p, 'real'); assume(q, 'real'); assume(r, 'real');
assume(Phi, 'real'); assume(Theta, 'real'); assume(Psi, 'real');

% inputs
syms Omega_1 Omega_2 Omega_3 Omega_4;
syms T;
assume(Omega_1, 'real'); assume(Omega_2, 'real'); assume(Omega_3, 'real'); assume(Omega_4, 'real');
assume(T, 'real');

% equations of motion
syms M_t F_t;
assume(M_t, 'real'); assume(F_t, 'real'); 

% actuator dynamics
syms K_phi K_theta K_thrust
assume(K_phi, 'real'); assume(K_theta, 'real'); assume(K_thrust, 'real');

%% Generation of arrays

% input array
Omega_array = [Omega_1; Omega_2; Omega_3; Omega_4];
Omega_array_square = [Omega_1^2; Omega_2^2; Omega_3^2; Omega_4^2];

% inertia tensor matrix
I = [Ixx 0 0; 
     0 Iyy 0; 
     0 0 Izz];

% attitude matrix
pqr = [p q r];

% rotational matrix
% Psi = 0;
% m = 1;
R_bg_1 = sin(Phi)*sin(Psi)+cos(Phi)*sin(Theta)*cos(Psi); 
R_bg_2 = -sin(Phi)*cos(Psi)+cos(Phi)*sin(Theta)*sin(Psi);
R_bg_3 = cos(Phi)*cos(Theta);

R_bg = [R_bg_1;R_bg_2;R_bg_3];

% actuator matrix
K_mat = [K_phi 0 0; 
         0 K_theta 0; 
         0 0 K_thrust];

% forces due to thrust
T_body = -K_t*(Omega_1^2+Omega_2^2+Omega_3^2+Omega_4^2);

% moments
M_t_matrix = [-b*K_t b*K_t b*K_t -b*K_t;
              l*K_t l*K_t -l*K_t -l*K_t;
              K_m -K_m K_m -K_m];
M_t_body = M_t_matrix*Omega_array_square;

% rotational accelerations in the earth frame
pqr_dot = inv(I)*(-cross(pqr,I*pqr')' + M_t_body);

% linear accelerations in the earth frame
pdd = g + (1/m)*R_bg*T;

% actuator compensation outer loop
pdd_act = K_mat * (g + (1/m)*R_bg*T);


%% Derivation of B matrices

% Inner Loop
B_inner(1:3,1) = diff(pqr_dot,Omega_1);
B_inner(1:3,2) = diff(pqr_dot,Omega_2);
B_inner(1:3,3) = diff(pqr_dot,Omega_3);
B_inner(1:3,4) = diff(pqr_dot,Omega_4);

B_inner(4,1) = diff(T_body,Omega_1);
B_inner(4,2) = diff(T_body,Omega_2);
B_inner(4,3) = diff(T_body,Omega_3);
B_inner(4,4) = diff(T_body,Omega_4);

% Outer Loop
B_outer(1:3,1) = diff(pdd,Phi);
B_outer(1:3,2) = diff(pdd,Theta);
B_outer(1:3,3) = diff(pdd,T);

% Outer Loop
B_outer_act(1:3,1) = diff(pdd_act,Phi);
B_outer_act(1:3,2) = diff(pdd_act,Theta);
B_outer_act(1:3,3) = diff(pdd_act,T);

% print matrices
for row = 1:4
    for column = 1:4
        fprintf('B_inner(%d,%d) = %s;\n',row,column,B_inner(row,column));
    end 
    fprintf("\n");
end

for row = 1:3
    for column = 1:3
        fprintf('B_outer(%d,%d) = %s;\n',row,column,B_outer(row,column));
    end 
    fprintf("\n");
end

% print outer matrix for paparazzi module
for row = 1:3
    for column = 1:3
        fprintf('RMAT_ELMT(*KG_outer, %d, %d) = %s;\n',row-1,column-1,B_outer_act(row,column));
    end 
    fprintf("\n");
end
