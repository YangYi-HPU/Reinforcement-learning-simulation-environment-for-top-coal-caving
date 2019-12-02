function PushBufferContactPW(dGap2)
%--------------------------------------------------------------------------
% All copyrights reserved @ 2014-2020 Dr. Gaofeng Zhao
% TIANJIN UNIVERSITY (China), UNSW (Australia)
% Email: zhaodlsm@gamil.com
%--------------------------------------------------------------------------
% Setup buffer P2W contacts
%--------------------------------------------------------------------------
global PW_C;
global NumW;
global NumP;
global MaxWP;
global Kn_PW;
global Ks_PW;
global Ft_PW;
global Fc_PW;
global Fri_PW;
global Vn_PW;
global Vs_PW;
global X;
global Y;
global R;
global XW1;
global YW1;
global XW2;
global YW2;
global MAT;
global MATW;
global MATLIST;
global MATWLIST;
%Clear Buffer Contacts
for i=1:NumW
    x1=XW1(i);
    y1=YW1(i);
    x2=XW2(i);
    y2=YW2(i);   
    for j=1:MaxWP
        jP=PW_C(j,i);
        if jP>0
           xc=X(jP);
           yc=Y(jP);
           R1=R(jP);
           if Contact_P_W(x1,y1,x2,y2,xc,yc,R1,dGap2)
           else
               PW_C(j,i)=0;
           end
        end
    end
end


%Push buffer contacts
for i=1:NumW
    x1=XW1(i);
    y1=YW1(i);
    x2=XW2(i);
    y2=YW2(i);    
    for j=1:NumP
        xc=X(j);
        yc=Y(j);
        R1=R(j);
        if Contact_P_W(x1,y1,x2,y2,xc,yc,R1,dGap2)
           iBFind=0;
           iBZFind=0;
           for k=1:MaxWP
               if PW_C(k,i)==j
                  iBFind=k;
               elseif PW_C(k,i)==0
                  iBZFind=k;
               else
               end
           end
                               
           if iBFind==0 && iBZFind>0
               PW_C(iBZFind,i)=j;
               iMat=MATW(i);
               jMat=MAT(j);
               Temp_Kn=MATLIST(jMat,2);
               Temp_Ks=MATLIST(jMat,3);
               Temp_Fri=MATWLIST(iMat,3);
               Kn_PW(iBZFind,i)=2.0*Temp_Kn;
               Ks_PW(iBZFind,i)=2.0*Temp_Ks;
               Ft_PW(iBZFind,i)=0.0;
               Fc_PW(iBZFind,i)=0.0;
               Fri_PW(iBZFind,i)=tan(Temp_Fri/180*pi);
               Vn_PW(iBZFind,i)=MATLIST(jMat,7);
               Vs_PW(iBZFind,i)=MATLIST(jMat,8);
           end
        end
    end
end