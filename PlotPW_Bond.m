function PlotPW_Bond(X,Y,R,XW1,YW1,XW2,YW2,PW_C,dGap)
%--------------------------------------------------------------------------
% All copyrights reserved @ 2014-2020 Dr. Gaofeng Zhao
% TIANJIN UNIVERSITY (China), UNSW (Australia)
% Email: zhaodlsm@gamil.com
%--------------------------------------------------------------------------
% Plot Bond Model for P2W contacts
%--------------------------------------------------------------------------

[N,M]=size(PW_C);

for i=1:N
    for j=1:M
        jP=PW_C(i,j);
        if jP>0
            x1=XW1(j);
            y1=YW1(j);
            x2=XW2(j);
            y2=YW2(j);
            [XTemp,YTemp]=Contact_Pt_P_W(x1,y1,x2,y2,X(jP),Y(jP),R(jP),dGap);
            if (X(jP)-XTemp)*(X(jP)-XTemp)+(Y(jP)-YTemp)*(Y(jP)-YTemp)<=(R(jP)+dGap)*(R(jP)+dGap)
                PlotPW_Bond2D(XTemp,YTemp,X(jP),Y(jP));
            end
        end
    end
end
