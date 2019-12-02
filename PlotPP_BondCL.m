function PlotPP_BondCL(X,Y,PP_C,Ft_C)
%--------------------------------------------------------------------------
% All copyrights reserved @ 2014-2020 Dr. Gaofeng Zhao
% TIANJIN UNIVERSITY (China), UNSW (Australia)
% Email: zhaodlsm@gamil.com
%--------------------------------------------------------------------------
% Plot bond model (color)
%--------------------------------------------------------------------------

[N,M]=size(PP_C);
for i=1:N
    for j=1:M
        jP=PP_C(i,j);
        if jP>0
            if Ft_C(i,j)>0.0
               PlotPP_Bond2D(X(j),Y(j),X(jP),Y(jP));
            else
               PlotPP_Bond2DR(X(j),Y(j),X(jP),Y(jP));
            end
        end
    end
end