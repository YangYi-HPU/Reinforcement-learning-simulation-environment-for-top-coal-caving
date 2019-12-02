function ContactDetection(dGap)
%--------------------------------------------------------------------------
% All copyrights reserved @ 2014-2050 Dr. Gaofeng Zhao
% TIANJIN UNIVERSITY (China)
% Email: dicetju@qq.com 
%--------------------------------------------------------------------------
% Contact Detection
%--------------------------------------------------------------------------
global X;
global Y;
global R;
global PP_C;
global IDGX;
global IDGY;
global MAX_PN;

N=length(X);
PP_C=zeros(MAX_PN,N);
Index_TempNC=ones(1,N);
parfor i=1:N
    Index_Temp=1;
    PLoc=zeros(MAX_PN,1);
    for j=1:N
        if i==j
        else
            if abs(IDGX(i)-IDGX(j))<2 && abs(IDGY(i)-IDGY(j))<2
            x1=X(i);
            y1=Y(i);
            x2=X(j);
            y2=Y(j);
            R1=R(i);
            R2=R(j);
            if Contact_P_P(x1,y1,x2,y2,R1,R2)>-dGap
                PLoc(Index_Temp)=j;
                Index_Temp=Index_Temp+1;
            end
            end
        end
    end
    Index_TempNC(i)=Index_Temp-1;
    PP_C(:,i)=PLoc;
end
CDN=sum(Index_TempNC)/N;