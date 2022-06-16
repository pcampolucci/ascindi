%% Short Period Model Compensation

%% 0: Linear State Space 
% parameters for condition
load('steady_10000_700.mat');

%% 1: SISO Model Extraction
% the state space has alpha and q tracked in radians, while the trajectory
% is usually described in deg, so a conversion is needed

% get longitudinal model for SISO de qdot, readapted
A_long = SS_long_hi.A(1:5,1:5);
B_long = SS_long_hi.A(1:5,7);
C_long = eye(5);
D_long = zeros(5,1);

% simplify model to describe the short period motion of the aircraft
A_sp = A_long(4:5,4:5);
B_sp = B_long(4:5,:);
C_sp = eye(2);
D_sp = zeros(2,1);

% build SISO based only on de input and pitch rate output
sys_ndi = ss(A_sp,B_sp,C_sp,D_sp);

% get the effectiveness matrix
B_qe = B_sp(2,1);
B_qe_inv = (1/B_qe);

% set initial conditions for alpha and q
initial_condition = [0,0];

%% 2: Elevator

% elevator time constant
te = 0.1; 

% time constant gain
Ke = 1/te; 

% steady state gain
Kes = 1;  

%% 3: Coefficients

% aerodynamic coefficients from linearization (converted all to degrees)
Cma = A_sp(2,1);
Cmq = A_sp(2,2);
Cme = B_sp(2,1);
CZa = A_sp(1,1);

% model changing
Cma_new = -2*Cma;
Cmq_new = -2*Cmq;

% reference model params
Kdr = 100;
Kddr = 100;

% error controller params
Kderr = 100;
Kerr = 100;
Kerr2 = 200;

% jerk dynamics
Kdq = 15;

dist = 100;

%% 4: Higher Order Reference Model

A_nu = Cmq;
B_nu = Cme;

%% 5 : Discretization and filtering

sample_time = 0.002;
filter_cutoff = 2*pi*100;
filters_on = 1;




