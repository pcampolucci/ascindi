clc
clear all

%% Effectiveness Matrix Generator

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
syms Phi Theta Psi ;
assume(p, 'real'); assume(q, 'real'); assume(r, 'real');
assume(Phi, 'real'); assume(Theta, 'real'); assume(Psi, 'real');

% inputs
syms Omega_1 Omega_2 Omega_3 Omega_4 ;
assume(Omega_1, 'real'); assume(Omega_2, 'real'); assume(Omega_3, 'real'); assume(Omega_4, 'real');

% equations of motion
syms M_t F_t;
assume(M_t, 'real'); assume(F_t, 'real'); 

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
R_bg_1 = sin(Phi)*sin(Psi)+cos(Phi)*sin(Theta)*cos(Psi); 
R_bg_2 = -sin(Phi)*cos(Psi)+cos(Phi)*sin(Theta)*sin(Psi);
R_bg_3 = cos(Phi)*cos(Theta);
R_bg = [R_bg_1;R_bg_2;R_bg_3];

% forces due to thrust
F_t_body = -K_t*(Omega_1^2+Omega_2^2+Omega_3^2+Omega_4^2);

% acceleration in the earth frame
Pdd = g + (1/m)*R_bg*F_t_bod%% 1: Generation of Body to Ground Rotation Matrix

% state variables
syms Phi Theta Psi ;
assume(Phi, 'real'); assume(Theta, 'real'); assume(Psi, 'real');

% rotation around roll axis
R_phi = [1 0 0;
         0 cos(Phi) -sin(Phi);
         0 sin(Phi) cos(Phi)];

% rotation around pitch axis
R_theta = [cos(Theta) 0 sin(Theta);
           0 1 0;
           -sin(Theta) 0 cos(Theta)];

% rotation around yaw axis
R_psi = [cos(Psi) -sin(Psi) 0;
         sin(Psi) cos(Psi) 0;
         0 0 1];

% conventional rotation body to ground [213]
R_bg_213 = R_theta * R_phi * R_psi;

%% 2: Euler Rates to Body Rates

% R unconventional [213]
i_phi = [1 0 0];
i_theta = [0 -1 0];
i_psi = [0 0 1];

% first we have the heading rotation, which is an identity matrix
pqr_yaw = eye(3) * i_psi';

% then we have the roll, which is dependent on the heading term
pqr_roll = R_psi * i_phi';

% finally we have the pitch, which is dependent on both roll and yaw
pqr_pitch = R_psi * R_phi * i_theta';

% stack the three together and get the matrix of rotation
R = horzcat(pqr_yaw,pqr_roll,pqr_pitch);

%% 3: Body Rates to Euler Rates 

% get the inverse matrix to calculate the opposite
T = inv(R);y;

% moments
M_t_matrix = [-b*K_t b*K_t b*K_t -b*K_t;
              l*K_t l*K_t -l*K_t -l*K_t;
              K_m -K_m K_m -K_m];
M_t_body = M_t_matrix*Omega_array_square;

% rotational accelerations in the earth frame
pqr_dot = inv(I)*(-cross(pqr,I*pqr')' + M_t_body);


%% Derivation of B matrix

% Derivative of Omega:
B_out(1:3,1) = diff(Pdd,Omega_1);
B_out(1:3,2) = diff(Pdd,Omega_2);
B_out(1:3,3) = diff(Pdd,Omega_3);
B_out(1:3,4) = diff(Pdd,Omega_4);

B_out(4:6,1) = diff(pqr_dot,Omega_1);
B_out(4:6,2) = diff(pqr_dot,Omega_2);
B_out(4:6,3) = diff(pqr_dot,Omega_3);
B_out(4:6,4) = diff(pqr_dot,Omega_4);

for row = 1:6
    for column = 1:4
        fprintf('B_out(%d,%d) = %s;\n',row,column,B_out(row,column));
    end 
    fprintf("\n");
end















