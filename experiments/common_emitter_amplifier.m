clc; close all; clearvars;

% common emitter amplifier where npn transistor has residual leakage
% current, two linear resistors are chosen at collector and emitter

% parameters
N = 512;
Nperiods = 2;
T = linspace(0, Nperiods, N);
R1val = 150;
R2val = 30;
alphaR = 110/111;
alphaF = 10/11;

R_leakage = 100;

gamma = 0.001;
tau = 700;
eps = 1e-8;
maxiters = 1e5;

% input signals
v1 = 5 * ones(1, N);
v5 = sin(2 * pi * T);

% resolvents
R1 = @(x, alpha) RR(x, alpha, R1val, 0);
R1adj = resvoutputshift(R1, v1 - v5);

R2 = @(x, alpha) RR(x, alpha, R2val, 0);
R2adj = resvoutputshift(R2, -v5);

R3 = @(x, alpha) Rtransistor(x, alpha, alphaR, alphaF);
R3adj = resvoutputshift_identity(R3, 1/R_leakage);

RA = @(x, alpha) [R1adj(x(1,:), alpha); R2adj(x(2,:), alpha)];
RB = @(x, alpha) R3adj(x, alpha);

M = @(x) x; 
Mt = @(x) x;

% solve inclusion problem
[i, v] = cpa(RA, RB, M, Mt, gamma, tau, ones(2, N), ones(2, N), eps, maxiters, 1, true);

figure;
plot(i');
figure;
plot(v');

% export data
M = [T' i' v'];
T = array2table(M);
T.Properties.VariableNames(1:5) = {'t', 'ic', 'ie', 'v1', 'v2'};
%writetable(T, '../data/common_emitter.csv')