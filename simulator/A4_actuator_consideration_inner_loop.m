clc
clear all

%% Actuator Consideration for Inner Loop

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
syms M_t;
assume(M_t, 'real');

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

% moments
M_t_matrix_1 = [-b*K_t;l*K_t;K_m];
M_t_matrix_2 = [b*K_t;l*K_t;-K_m];
M_t_matrix_3 = [b*K_t;-l*K_t;K_m];
M_t_matrix_4 = [-b*K_t;-l*K_t;-K_m];

% further differ
pqr_ddot_1 = 2*inv(I)*M_t_matrix_1*Omega_1;
pqr_ddot_2 = 2*inv(I)*M_t_matrix_2*Omega_2;
pqr_ddot_3 = 2*inv(I)*M_t_matrix_3*Omega_3;
pqr_ddot_4 = 2*inv(I)*M_t_matrix_4*Omega_4;

pqr_ddot = [pqr_ddot_1 pqr_ddot_2 pqr_ddot_3 pqr_ddot_4];

for row = 1:3
    for column = 1:4
        fprintf('B_actuator(%d,%d) = %s;\n',row,column,pqr_ddot(row,column));
    end 
    fprintf("\n");
end





