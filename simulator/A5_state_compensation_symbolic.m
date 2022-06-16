%% State Term Derivation Script
% This script performs the derivation for the expression of the inner loop
% dynamics

%% 1 : Define Variables

% fixed parameters
syms rho S_plate l_plate;
syms Cd Cl;
syms Iyy m;
assume(rho, 'real'); assume(S_plate, 'real'); assume(l_plate, 'real');
assume(Cd, 'real'); assume(Cl, 'real');
assume(Iyy, 'real'); assume(m, 'real');

% state variables
syms phi theta psi;
syms Vx Vy Vz; 
syms u;
assume(phi, 'real'); assume(theta, 'real'); assume(psi, 'real');
assume(Vx, 'real'); assume(Vy, 'real'); assume(Vz, 'real');
assume(u, 'real');

% derivative of state variables
syms dphi dtheta dpsi;
syms Ax Ay Az; 
assume(dphi, 'real'); assume(dtheta, 'real'); assume(dpsi, 'real');
assume(Ax, 'real'); assume(Ay, 'real'); assume(Az, 'real');

% sign of velocity in earth
syms Vx_sign;
assume(Vx_sign, 'real');

% parameters from optimization
syms Izz Cd1 Cd2 Cl1 Cl2;
assume(Izz, 'real'); assume(Cd1, 'real'); assume(Cd2, 'real'); assume(Cl1, 'real'); assume(Cl2, 'real');

% list of symbolic for conversion
list_qdd_comp = {Ax, Ay, Vx, Vy, theta, dtheta, u, Cd1, Cd2, Cl1, Cl2, Iyy, S_plate, l_plate, rho};

%% 2 : Define Dynamics Equations

% Resultant
Vr = sqrt(Vx^2+Vy^2+Vz^2);
Vh = sqrt(Vx^2+Vy^2);

gamma = -rad2deg(atan2(Vz,Vh));
theta_d = rad2deg(theta);

alpha = theta_d-gamma;

% Drag Coefficient
Cd = Cd1*(90+alpha)+Cd2;

% Lift Coefficient
Cl = Cl1*(90+alpha)+Cl2;

% get drag and lift
D_plate= 0.5*rho*Vr^2*S_plate*Cd;
L_plate = 0.5*rho*Vr^2*S_plate*Cl;
R_plate = cos(deg2rad(alpha))*D_plate - sin(deg2rad(alpha))*L_plate;

My_dp = l_plate*R_plate*sign(u);
qd_dp = My_dp/Iyy;

%% 3 : Inner Loop Compensation

% we derive the angular velocity for the system state
% x = [Vx Vy Vz phi theta psi]
% and we then multiply it for the derived state vector

x = [Vx Vy Vz phi theta psi];
dx = [Ax Ay Az dphi dtheta dpsi];
qd_dp_x = sym(zeros(1,6));

for i = 1:length(qd_dp_x)
    qd_dp_x(i) = diff(qd_dp,x(i));
end

qdd_comp = qd_dp_x * dx';

















