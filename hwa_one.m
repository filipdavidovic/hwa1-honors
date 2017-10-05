function [sys, x0, str, ts] = hwa_one(t, x, u, flag, x0, g, m, ix, iy, iz)
% hwa_one S-Function for Exercise 1 of Homework Assignment 1 - Produced by
% M. Grillo, R. Ferede, F. Davidovic, C. Spiliadis

% check which method to instantiate, depending on the flag, which
% represents the state of the current simulation loop iteration
switch flag,

  %%%%%%%%%%%%%%%%%%
  % Initialization %
  %%%%%%%%%%%%%%%%%%
  case 0,
    [sys,x0,str,ts]=mdlInitializeSizes(x0);

  %%%%%%%%%%%%%%%
  % Derivatives %
  %%%%%%%%%%%%%%%
  case 1,
    sys=mdlDerivatives(t, x, u, g, m, ix, iy, iz);

  %%%%%%%%%%%
  % Outputs %
  %%%%%%%%%%%
  case 3,
    sys=mdlOutputs(t,x,u);

  %%%%%%%%%%%%%
  % Terminate %
  %%%%%%%%%%%%%
  case 9,
    sys=mdlTerminate(t,x,u);
    
  %%%%%%%%%%%%%%%%%%%
  % Unhandled flags %
  %%%%%%%%%%%%%%%%%%%
  case { 2, 4 },
    sys = [];

  %%%%%%%%%%%%%%%%%%%%
  % Unexpected flags %
  %%%%%%%%%%%%%%%%%%%%
  otherwise
    DAStudio.error('Simulink:blocks:unhandledFlag', num2str(flag));

end

% end sfuntmpl

%
%=============================================================================
% mdlInitializeSizes
% Return the sizes, initial conditions, and sample times for the S-function.
%=============================================================================
%
function [sys,x0,str,ts]=mdlInitializeSizes(x0)
sizes = simsizes;

sizes.NumContStates  = 12;
sizes.NumDiscStates  = 0;
sizes.NumOutputs     = 12;
sizes.NumInputs      = 4;
sizes.DirFeedthrough = 0;
sizes.NumSampleTimes = 1;   % at least one sample time is needed

sys = simsizes(sizes);

str = [];

ts  = [0 0];


% end mdlInitializeSizes

%
%=============================================================================
% mdlDerivatives
% Return the derivatives for the continuous states.
%=============================================================================
%
function sys=mdlDerivatives(t, x, u, g, m, ix, iy, iz)
vx = x(4);
vy = x(5);
vz = x(6);
phi = x(7);
theta = x(8);
psi = x(9);
p = x(10);
q = x(11);
r = x(12);

T = u(1);
tx = u(2);
ty = u(3);
tz = u(4);

dx_ = vx;
dy  = vy;
dz  = vz;
dvx = (sin(phi)*sin(psi)+cos(phi)*cos(psi)*sin(theta))*T/m;
dvy = (cos(phi)*sin(psi)*sin(theta)-cos(psi)*sin(phi))*T/m;
dvz = (cos(phi)*cos(theta))*(T/m)+g;
dphi = p + sin(phi)*tan(theta)*q+cos(phi)*tan(theta)*r;
dtheta = cos(phi)*q-sin(phi)*r;
dpsi = (sin(phi)/cos(theta))*q+(cos(phi)/cos(theta))*r;
dp = ((iy-iz)/ix)*r*q+tx/ix;
dq = ((iz-ix)/iy)*p*r+ty/iy;
dr = ((ix-iy)/iz)*p*q+tz/iz;

sys = [dx_, dy, dz, dvx, dvy, dvz, dphi, dtheta, dpsi, dp, dq, dr];

% end mdlDerivatives

%
%=============================================================================
% mdlOutputs
% Return the block outputs.
%=============================================================================
%
function sys=mdlOutputs(t ,x, u)

sys = x;

% end mdlOutputs

%
%=============================================================================
% mdlTerminate
% Perform any end of simulation tasks.
%=============================================================================
%
function sys=mdlTerminate(t, x, u)
sys = [];

% end mdlTerminate