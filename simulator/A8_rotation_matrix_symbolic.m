%% Generator of rotation matrices for inner loop

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

% conventional rotation body to ground [213]
R_bg_213 = R_theta * R_phi * R_psi;

%% 2: Euler Rates to Body Rates and vice-versa

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

% get the inverse matrix to calculate the opposite
T = inv(R);


