clear; clc; close all
% hot wire calibration 
fname = 'Fri_A_1400_calibration.txt';   

T = readtable(fname,'VariableNamingRule','preserve');
E = T{:,3};                 % hotwire output in volts
U = T{:,4};                 % velocity 

% plot U vs. HWA
figure(1); clf
plot(E,U,'ko','MarkerFaceColor',[0.2 0.6 1],'LineWidth',1.1)
grid on
xlabel('Hot-wire Output, E (V)')
ylabel('Velocity, U (m/s)')
title('Velocity vs. Hot-wire Output','FontSize',13)
set(gca,'FontSize',11,'Box','on')
set(gcf,'Color','w')

% plot log/log for kings law linearization
x = log(E); y = log(U);     % natural logs
p = polyfit(x,y,1);         % y = a*x + b
a = p(1); b = p(2);
Ufit = exp(b)*E.^a;         % U = exp(b) * E^a

% R^2 (on log–log space)
yhat = polyval(p,x);
R2 = 1 - sum((y - yhat).^2)/sum((y - mean(y)).^2);

figure(2); clf
hold on
plot(x,y,'ko','MarkerFaceColor',[0.2 0.6 1],'DisplayName','Data points')
plot(x,yhat,'r-','LineWidth',1.2, ...
    'DisplayName',sprintf('log(U) = %.3f·log(E) + %.3f  (R^2 = %.3f)',a,b,R2))
hold off
grid on
xlabel('log(E)'); ylabel('log(U)')
title('Hot-Wire Calibration (log–log fit)','FontSize',13)
legend('Location','northwest','FontSize',9)
set(gcf,'Color','w'); set(gca,'FontSize',11)

% printing summary
fprintf('King''s-law form (power law fit):  U = C * E^{n}\n');
fprintf('  n = %.6f\n',a);
fprintf('  C = exp(b) = %.6f  (units: m/s·V^{-n})\n',exp(b));
fprintf('  R^2 (log–log fit) = %.6f\n',R2);
