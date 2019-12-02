function PlotParticleModel_CL(X,Y,T,R,MAT,X0,Y0,option)
%--------------------------------------------------------------------------
% All copyrights reserved @ 2014-2020 Dr. Gaofeng Zhao
% TIANJIN UNIVERSITY (China), UNSW (Australia)
% Email: zhaodlsm@gamil.com
%--------------------------------------------------------------------------
% Plot Particle Model (in color)
%--------------------------------------------------------------------------

NP=length(X);
ClrT=GetColorTable;
[NC,MC]=size(ClrT);
NCSeg=20;

if option==0
    UX=X-X0;
    if max(UX)==min(UX)
        UXI=(UX-min(UX));
    else
        UXI=(UX-min(UX))/(max(UX)-min(UX));
    end
    UXI=floor(UXI*(NC-1))+1;
    
    for i=1:NP
        PlotParticle2D(X(i),Y(i),R(i),T(i),NCSeg,ClrT(UXI(i),:));
    end    
    colorbar;
    if min(UX)==max(UX)
        caxis([min(UX),max(UX)+1]);
    else
        caxis([min(UX),max(UX)]);
    end
    xlabel('X (m)');
    ylabel('Y (m)');
else
    UX=Y-Y0;
    if max(UX)==min(UX)
        UXI=(UX-min(UX));
    else
        UXI=(UX-min(UX))/(max(UX)-min(UX));
    end
    UXI=floor(UXI*(NC-1))+1;
    
    for i=1:NP
        switch MAT(i)
            case 1
                ClrT = [0,0,1];
            case 2
                ClrT= [1,0,0];
            case 3
                ClrT= [0,1,0];
            case 4
                ClrT=[1,1,0];
        end
        
        PlotParticle2D(X(i),Y(i),R(i),T(i),NCSeg,ClrT);
        
    end
%     colorbar;
    if min(UX)==max(UX)
        caxis([min(UX),max(UX)+1]);
    else
        caxis([min(UX),max(UX)]);
    end
    xlabel('X (m)');
    ylabel('Y (m)');    
end

