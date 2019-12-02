function ContactDetection_PW(dGap)
%--------------------------------------------------------------------------
% All copyrights reserved @ 2014-2050 Dr. Gaofeng Zhao
% TIANJIN UNIVERSITY (China)
% Email: dicetju@qq.com 
%--------------------------------------------------------------------------
% P2W Contact Detection
%--------------------------------------------------------------------------
global XW1;
global YW1;
global XW2;
global YW2;
global X;
global Y;
global R;

global NumP;
global PW_C;
global NumW;
Index_Temp=ones(1,NumW);
size(PW_C);
for i=1:NumW
    x1=XW1(i);
    y1=YW1(i);
    x2=XW2(i);
    y2=YW2(i);    
    for j=1:NumP
        xc=X(j);
        yc=Y(j);
        R1=R(j);
        if Contact_P_W(x1,y1,x2,y2,xc,yc,R1,dGap)
           PW_C(Index_Temp(i),i)=j;
           Index_Temp(i)=Index_Temp(i)+1;
        end
    end
end
size(PW_C);