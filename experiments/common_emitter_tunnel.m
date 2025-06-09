clc; close all; clearvars;

% parameters
N = 512;
Nperiods = 2;
T = linspace(0, Nperiods, N);
R2val = 100;
alphaR = 110/111;
alphaF = 10/11;

R_leakage = 100;
gamma = 5 / (9 * R_leakage);
tau = 8 * R_leakage / 5;
lambda = 1/4;
eps = 1e-8;
maxiters = 1e5;

% input signals
v1 = 5 * ones(1, N);
v5 = sin(2 * pi * T);

% resolvents
new_x_origin = 0;
new_y_origin = 0;
R1 = @(x, alpha) Rtunnel_diode_piecewise(x, alpha, 4.9, 1/100, 1/900);
R1shift = resvoutputshift(R1, v1 - v5 + new_y_origin);
R1adj = resvinputshift(R1shift, new_x_origin);

R2 = @(x, alpha) RR(x, alpha, R2val, 0);
R2adj = resvoutputshift(R2, -v5);

R3 = @(x, alpha) Rtransistor(x, alpha, alphaR, alphaF);
R3adj = resvoutputshift_identity(R3, 1/R_leakage);

RA = @(x, alpha) [R1adj(x(1,:), alpha); R2adj(x(2,:), alpha)];
RB = @(x, alpha) R3adj(x, alpha);

M = @(x) x;
Mt = @(x) x;

% solve inclusion problem
[i, v] = cpa(RA, RB, M, Mt, gamma, tau, ones(2, N), ones(2, N), eps, maxiters, lambda, true);

figure;
plot(i');
legend('ic', 'ie');
figure;
plot(v');
legend('vt1', 'vt2')

figure;
plot(v5 - v1 - v(1,:));
legend('vtunnel')

% export data
M = [T' i' v' v5' - v1' - v(1,:)'];
T = array2table(M);
T.Properties.VariableNames(1:6) = {'t', 'ic', 'ie', 'v1', 'v2', 'vtunnel'};
%writetable(T, '../data/common_emitter_tunnel.csv')

