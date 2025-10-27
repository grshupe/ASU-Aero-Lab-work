clc; clear; close all
fname = 'Fri_A_1400_4412.txt';   
T = readtable(fname,'VariableNamingRule','preserve');

E = T{:,3};                        % hot wire voltage 
steps = T{:,6};                    % step position
U = 9.05e-4 * E.^10.93;            % calibration from part A

U_inf = max(U);
U_norm = U ./ U_inf;
y = steps / 6400;                  % inches
y_norm = y ./ max(y);

figure; clf
plot(U_norm, y_norm, 'ko-', ...
    'MarkerFaceColor',[0.9 0.2 0.2], ...   
    'LineWidth',1.1)
grid on
xlabel('v_{norm}','FontSize',12)
ylabel('h_{norm}','FontSize',12)
title('Wake Profile – NACA 4412','FontSize',13)

xlim([0 1])
ylim([0 1])
set(gca,'YDir','reverse')           
set(gca,'FontSize',11,'Box','on')
set(gcf,'Color','w')
