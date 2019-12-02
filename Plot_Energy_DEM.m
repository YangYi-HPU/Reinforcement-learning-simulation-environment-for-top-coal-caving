function Plot_Energy_DEM(t,PE,KE,DE)
%--------------------------------------------------------------------------
% All copyrights reserved @ 2014-2050 Dr. Gaofeng Zhao
% TIANJIN UNIVERSITY (China)
% Email: dicetju@qq.com 
%--------------------------------------------------------------------------
% Plot Energy Curves 
%--------------------------------------------------------------------------
figure;
plot(t,KE,'k','linewidth',2);
hold on;
plot(t,DE,'r-.','linewidth',2);
plot(t,PE,'c-','linewidth',2);
xlabel('Time (s)');
ylabel('Energy (J)');

legend('Kinetic Energy','Strain Energy','Gravity Potential Energy');