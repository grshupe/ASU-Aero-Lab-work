clc; clear; close all
% constants
C   = 9.05e-4;       % Kings law constant
n   = 10.93;         % Kings law exponent
rho = 1.1069;        % air density [kg/m^3]
c   = 0.100;         % chord from lab 2 info [m]
dy_per_step = 0.0254 / 6400;   % step size [m] (16 rev/in * 400 steps/rev)

fname = 'Fri_A_1400_4412.txt'; 

T = readtable(fname,'FileType','text'); 
steps = T{:,6};
E     = T{:,3};
q     = T{:,2};

% step conversion for a height
y = (steps - steps(1)) * dy_per_step;

% velocity conversion from kings law
u = C .* (E.^n);

% freestream velocity from dynamic pressure
Uinf = sqrt(2 * mean(q) / rho);

% normalize that
v = u / Uinf;

% computing drag coeffcient from drag per eqs. 
Cd = (2 / c) * trapz(y, v .* (1 - v));

% throwing drap per eqs. in there
Dprime = rho * trapz(y, u .* (Uinf - u));

% uncertainty in air density
rho_unc = 0.00381;                  % kg/m^3
Dprime_unc = Dprime * (rho_unc / rho);

% results
fprintf('File: %s\n', fname);
fprintf('Freestream velocity: %.2f m/s\n', Uinf);
fprintf('Drag per span D'' = %.4f ± %.4f N/m\n', Dprime, Dprime_unc);
fprintf('Drag coefficient C_D = %.5f\n', Cd);