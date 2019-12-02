function PlotPW_CL(X,Y,T,R,MAT,X1,Y1,X2,Y2,X0,Y0,Option)
%--------------------------------------------------------------------------
% Plot particle and wall model in color
%--------------------------------------------------------------------------

clf;
hold on;
axis equal;
set(gcf,'Renderer','OpenGL');
PlotParticleModel_CL(X,Y,T,R,MAT,X0,Y0,Option);
PlotWallModel(X1,Y1,X2,Y2);