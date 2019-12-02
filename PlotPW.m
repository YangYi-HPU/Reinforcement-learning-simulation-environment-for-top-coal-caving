function PlotPW(X,Y,T,R,MAT,X1,Y1,X2,Y2)
%--------------------------------------------------------------------------
% All copyrights reserved @ 2014-2020 Dr. Gaofeng Zhao
% TIANJIN UNIVERSITY (China), UNSW (Australia)
% Email: zhaodlsm@gamil.com
%--------------------------------------------------------------------------
% Plot particle wall model 
%--------------------------------------------------------------------------
global bOpenGL;
global bParticleModel;%1/0: Plot/Not plot the Geometry model
clf;
hold on;
axis equal;
if bOpenGL==1
set(gcf,'Renderer','OpenGL');
end
if bParticleModel==0
    return;
end
PlotParticleModel(X,Y,T,R,MAT);
PlotWallModel(X1,Y1,X2,Y2);