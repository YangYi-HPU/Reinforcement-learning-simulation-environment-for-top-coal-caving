function PushBufferContact(dGap2)
%--------------------------------------------------------------------------
% All copyrights reserved @ 2014-2020 Dr. Gaofeng Zhao
% TIANJIN UNIVERSITY (China), UNSW (Australia)
% Email: zhaodlsm@gamil.com
%--------------------------------------------------------------------------
% Setup buffer P2P contacts
%--------------------------------------------------------------------------
global MAX_PN;
global PP_C;
global Kn_PP;
global Ks_PP;
global Ft_PP;
global Fc_PP;
global Fri_PP;
global WT_PP;
global Vn_PP;
global Vs_PP;
global NumP;
global X;
global Y;
global R;
global MAT;
global MATLIST;
global IDGX;
global IDGY;

%Clear detached contacts
parfor i=1:NumP
    for j=1:MAX_PN
        jP=PP_C(j,i);
        if jP>0
            x1=X(i);
            y1=Y(i);
            x2=X(jP);
            y2=Y(jP);
            R1=R(i);
            R2=R(jP);
           if Contact_P_P(x1,y1,x2,y2,R1,R2)>-dGap2
           else
               PP_C(j,i)=0;
           end
        end
    end
end

%Push buffer contacts
parfor i=1:NumP
    PP_CL=PP_C(:,i);
    Kn_PPL=Kn_PP(:,i);     
    Ks_PPL=Ks_PP(:,i);
    Ft_PPL=Ft_PP(:,i);
    Fc_PPL=Fc_PP(:,i);
    Fri_PPL=Fc_PP(:,i);
    WT_PPL=WT_PP(:,i);
    Vn_PPL=Vn_PP(:,i);
    Vs_PPL=Vs_PP(:,i);    
    for j=1:NumP
        if i==j
        else
            if abs(IDGX(i)-IDGX(j))<2 && abs(IDGY(i)-IDGY(j))<2
            x1=X(i);
            y1=Y(i);
            x2=X(j);
            y2=Y(j);
            R1=R(i);
            R2=R(j);
            if Contact_P_P(x1,y1,x2,y2,R1,R2)>-dGap2
                iBFind=0;
                iBZFind=0;
                for k=1:MAX_PN
                    if PP_CL(k)==j
                        iBFind=k;
                    elseif PP_CL(k)==0
                        iBZFind=k;
                    else
                    end
                end
                if iBFind==0 && iBZFind>0
                    iMat=MAT(i);
                    jMat=MAT(j);
                    Temp_Kn=0.5*(MATLIST(iMat,2)+MATLIST(jMat,2));
                    Temp_Ks=0.5*(MATLIST(iMat,3)+MATLIST(jMat,3));
                    Temp_Fri=min(MATLIST(iMat,6),MATLIST(jMat,6));
                    Temp_Vn=0.5*(MATLIST(iMat,7)+MATLIST(jMat,7));
                    Temp_Vs=0.5*(MATLIST(iMat,8)+MATLIST(jMat,8));
                    PP_CL(iBZFind)=j;
                    Kn_PPL(iBZFind)=Temp_Kn;
                    Ks_PPL(iBZFind)=Temp_Ks;
                    Ft_PPL(iBZFind)=0.0;
                    Fc_PPL(iBZFind)=0.0;
                    Fri_PPL(iBZFind)=tan(Temp_Fri/180*pi);
                    WT_PPL(iBZFind)=0.0;
                    Vn_PPL(iBZFind)=Temp_Vn;
                    Vs_PPL(iBZFind)=Temp_Vs;
                end
            end
            end
        end
    end
    PP_C(:,i)=PP_CL;
    Kn_PP(:,i)=Kn_PPL;     
    Ks_PP(:,i)=Ks_PPL;
    Ft_PP(:,i)=Ft_PPL;
    Fc_PP(:,i)=Fc_PPL;
    Fc_PP(:,i)=Fri_PPL;
    WT_PP(:,i)=WT_PPL;
    Vn_PP(:,i)=Vn_PPL;
    Vs_PP(:,i)=Vs_PPL;       
end