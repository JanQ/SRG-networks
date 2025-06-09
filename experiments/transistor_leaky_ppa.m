clc; close all; clearvars;

N = 256;
Ts = linspace(0, 1, N);
% target currents
istar = [sin(2*pi*Ts); cos(2*pi*Ts)];
% loss resistance
R = 10;

% transistor params
alphaR = 110/111;
alphaF = 10/11;

% stepsize (no relaxation)
gamma = R;

% initial resolvent
RApre = @(x, alpha) Rtransistor(x, alpha, alphaR, alphaF);
% resolvent of transistor + loss resistance
RA = resvoutputshift_identity(RApre, 1/R);
% also consider desired output as output shift
RAshift = resvoutputshift(RA, -istar);

% solve for vstar
vstar = ppa(RAshift, gamma, istar, 1e-8, 10000);
plot(vstar')

% export data
M = [Ts' istar' vstar'];
T = array2table(M);
T.Properties.VariableNames(1:5) = {'t', 'i1', 'i2', 'v1', 'v2'};
%writetable(T, '../data/transistor_leaky_ppa.csv')
