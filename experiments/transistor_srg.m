clc; close all; clearvars;
rng(0804846)
plot_srg(@generate_transistor, 2000)
xlim([-1, 1])
ylim([-1, 1])

% export data
h = gcf;
axes = get(h,'children');
data = get(axes, 'children');
xdata = get(data, 'xdata');
ydata = get(data, 'ydata');

M = [xdata' ydata'];
M = M(abs(M(:,1)) <= 1 & abs(M(:,2)) <= 1 ,:);
T = array2table(M);
T.Properties.VariableNames(1:2) = {'x', 'y'};
%writetable(T, '../data/srg_transistor.csv')

f = @() generate_transistor(0.3, 0.2);
plot_srg(f, 2000)
xlim([-1, 1])
ylim([-1, 1])

h = gcf;
axes = get(h,'children');
data = get(axes, 'children');
xdata = get(data, 'xdata');
ydata = get(data, 'ydata');

M = [xdata' ydata'];
M = M(abs(M(:,1)) <= 1 & abs(M(:,2)) <= 1 ,:);
T = array2table(M);
T.Properties.VariableNames(1:2) = {'x', 'y'};
%writetable(T, '../data/srg_transistor2.csv')
