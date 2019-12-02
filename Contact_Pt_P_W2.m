function [CPx,CPy]=Contact_Pt_P_W2(x1,y1,x2,y2,xc,yc,R,dGap)
%--------------------------------------------------------------------------
% All copyrights reserved @ 2014-2050 Dr. Gaofeng Zhao
% TIANJIN UNIVERSITY (China)
% Email: dicetju@qq.com 
%--------------------------------------------------------------------------
% P2W contact detection (get contact point)
%--------------------------------------------------------------------------

AB=[x2-x1,y2-y1];
LAB=norm(AB);
AC=[xc-x1,yc-y1];
LAC=norm(AC);
Ln=AB*AC'/LAB;
Ls=sqrt(LAC^2-Ln^2);
CPx=0.0;
CPy=0.0;
if Ln>0.0 && Ln<LAB
    Un=R-Ls;
    CPx=Ln/LAB*(x2-x1)+x1;
    CPy=Ln/LAB*(y2-y1)+y1;
else
    PLN=[xc-x2,yc-y2];
    PL=sqrt(PLN(1)^2+PLN(2)^2);
    Un=R-PL;
    Un1=Un;
    if Un>-dGap
        CPx=x2;
        CPy=y2;
        return;
    end
    PLN=[xc-x1,yc-y1];
    PL=sqrt(PLN(1)^2+PLN(2)^2);
    Un=R-PL;
    Un2=Un;
    if Un>-dGap
        CPx=x2;
        CPy=y2;
        return;
    end
    if (Un1>Un2)
        CPx=x2;
        CPy=y2;
        return;
    else
        CPx=x1;
        CPy=y1;
        return;        
    end
end