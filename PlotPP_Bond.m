function PlotPP_Bond(X,Y,PP_C)
%--------------------------------------------------------------------------
% Plot Bond Model
%--------------------------------------------------------------------------

[N,M]=size(PP_C);
for i=1:N
    for j=1:M
        jP=PP_C(i,j);
        if jP>0
            PlotPP_Bond2D(X(j),Y(j),X(jP),Y(jP));
        end
    end
end
