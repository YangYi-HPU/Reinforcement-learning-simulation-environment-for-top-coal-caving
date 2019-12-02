function CS=Contact_P_W(x1,y1,x2,y2,xc,yc,R,dGap)
%--------------------------------------------------------------------------
% All copyrights reserved @ 2014-2050 Dr. Gaofeng Zhao
% TIANJIN UNIVERSITY (China)
% Email: dicetju@qq.com 
%--------------------------------------------------------------------------
% P2W contact detection
%--------------------------------------------------------------------------

AB=[x2-x1,y2-y1];
LAB=norm(AB);
AC=[xc-x1,yc-y1];
LAC=norm(AC);
Ln=AB*AC'/LAB;
Ls=sqrt(LAC^2-Ln^2);
Un=0;
CS=0;
if Ln>0.0 && Ln<LAB
    Un=R-Ls;
    if Un>-dGap
        CS=1;
        return;
    end
else
    PLN=[xc-x2,yc-y2];
    PL=sqrt(PLN(1)^2+PLN(2)^2);
    Un=R-PL;
    if Un>-dGap
        CS=1;
        return;
    end
    PLN=[xc-x1,yc-y1];
    PL=sqrt(PLN(1)^2+PLN(2)^2);
    Un=R-PL;
    if Un>-dGap
        CS=1;
        return;
    end
end