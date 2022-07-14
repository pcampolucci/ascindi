%% Generation of Outer Loop Effectiveness Matrix
% u = [phi theta thrust]

%% 1: Generation of Body to Ground Rotation Matrix

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

% rotation around roll axis
R_phi1 = [1 0 0;
         0 cos(Phi) sin(Phi);
         0 -sin(Phi) cos(Phi)];

% rotation around pitch axis
R_theta1 = [cos(Theta) 0 -sin(Theta);
           0 1 0;
           sin(Theta) 0 cos(Theta)];

% rotation around yaw axis
R_psi1 = [cos(Psi) sin(Psi) 0;
         -sin(Psi) cos(Psi) 0;
         0 0 1];

% unconventional rotation body to ground [213 or YXZ] 
R_bg_213 = R_phi * R_theta * R_psi;

% conventional rotation [321 or ZYX]
R_bg_321 = R_psi * R_theta * R_phi;

%% 2: Euler Rates to Body Rates and vice-versa

i_phi = [1 0 0];
i_theta = [0 1 0];
i_psi = [0 0 1];

% R unconventional [213]
% pqr_yaw = eye(3) * i_psi';
% pqr_roll = R_psi1 * i_phi';
% pqr_pitch = R_psi1 * R_phi1 * i_theta';

% R conventional [321]
pqr_roll = eye(3) * i_phi';
pqr_pitch = R_phi1 * i_theta';
pqr_yaw = R_phi1 * R_theta1 * i_psi';

% stack the three together and get the matrix of rotation
R_mat = horzcat(pqr_roll,pqr_pitch,pqr_yaw);

% get the inverse matrix to calculate the opposite
T_mat = inv(R_mat);
R_gb_321 = inv(R_bg_321);

% simplify expressions
T_mat = simplify(T_mat);
R_gb_321 = simplify(R_gb_321);

%% 2: Equation of Motion

syms T m g;
syms K_phi K_theta K_thrust;
assume(T, 'real'); assume(m, 'real'); assume(g, 'real');
assume(K_phi, 'real'); assume(K_theta, 'real'); assume(K_thrust, 'real');

% actuator matrix
K_mat = [K_theta 0 0; 
         0 K_phi 0; 
         0 0 K_thrust];

% T is aligned with the z-axis of the body, so we need a part of R_bg
A_vect_act = K_mat * (g + (1/m)*R_bg_321(:,3)*T);
A_vect = g + (1/m)*R_bg_321(:,3)*T;

%% 3: Obtaining the Effectiveness Matrix

% we differentiate each A_vect component over the three control variables,
% namely: [theta phi thrust]
B_outer(1:3,1) = diff(A_vect,Theta);
B_outer(1:3,2) = diff(A_vect,Phi);
B_outer(1:3,3) = diff(A_vect,T);

% simplifications

%% 4: Print the Results
fprintf("\n***** R_bg *****\n\n");

% string of R_bg_213
for row = 1:3
    fprintf('%s %s %s;\n',R_bg_321(row,1),R_bg_321(row,2),R_bg_321(row,3));
end

fprintf("\n");

for column = 1:3
    for row = 1:3
        fprintf('RMAT_ELMT(*R_bg_matrix, %d, %d) = %s;\n',row-1,column-1,R_bg_321(row,column));
    end 
    fprintf("\n");
end

fprintf("\n***** R_gb *****\n\n");

% string of R_bg_213
for row = 1:3
    fprintf('%s %s %s;\n',R_gb_321(row,1),R_gb_321(row,2),R_gb_321(row,3));
end

fprintf("\n");

for column = 1:3
    for row = 1:3
        fprintf('RMAT_ELMT(*R_gb_matrix, %d, %d) = %s;\n',row-1,column-1,R_gb_321(row,column));
    end 
    fprintf("\n");
end

fprintf("\n***** R = euler to body rates *****\n\n");

for row = 1:3
    fprintf('%s %s %s;\n',R_mat(row,1),R_mat(row,2),R_mat(row,3));
end

fprintf("\n");

for column = 1:3
    for row = 1:3
        fprintf('RMAT_ELMT(*R_matrix, %d, %d) = %s;\n',row-1,column-1,R_mat(row,column));
    end 
    fprintf("\n");
end

fprintf("\n***** T = body rates to euler *****\n\n");

for row = 1:3
    fprintf('%s %s %s;\n',T_mat(row,1),T_mat(row,2),T_mat(row,3));
end

fprintf("\n");

for column = 1:3
    for row = 1:3
        fprintf('RMAT_ELMT(*T_matrix, %d, %d) = %s;\n',row-1,column-1,T_mat(row,column));
    end 
    fprintf("\n");
end

fprintf("\n***** Outer Effectiveness Matrix *****\n\n");

% strings for the simulator
for column = 1:3
    for row = 1:3
        fprintf('B_outer(%d,%d) = %s;\n',row,column,B_outer(row,column));
    end 
    fprintf("\n");
end

% strings for paparazzi module
for column = 1:3
    for row = 1:3
        fprintf('RMAT_ELMT(*G_matrix, %d, %d) = %s;\n',row-1,column-1,B_outer(row,column));
    end 
    fprintf("\n");
end








