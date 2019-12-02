function PlotParticleModel_NUM(X,Y)
%--------------------------------------------------------------------------
% All copyrights reserved @ 2014-2020 Dr. Gaofeng Zhao
% TIANJIN UNIVERSITY (China), UNSW (Australia)
% Email: zhaodlsm@gamil.com
%--------------------------------------------------------------------------
% Plot Particle number
%--------------------------------------------------------------------------

NP=length(X);    
for i=1:NP
    text(X(i),Y(i),int2str(i));
end   
