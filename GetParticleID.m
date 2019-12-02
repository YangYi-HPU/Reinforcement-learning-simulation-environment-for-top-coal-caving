function ID=GetParticleID(X,Y,xT,yT)
%--------------------------------------------------------------------------
% All copyrights reserved @ 2014-2050 Dr. Gaofeng Zhao
% TIANJIN UNIVERSITY (China)
% Email: dicetju@qq.com 
%--------------------------------------------------------------------------
%Get the ID of partice with the given position
%--------------------------------------------------------------------------
ID=1;
Len=sqrt((X(1)-xT)*(X(1)-xT)+(Y(1)-yT)*(Y(1)-yT));
N=length(X);
for i=2:N
    TLen=sqrt((X(i)-xT)*(X(i)-xT)+(Y(i)-yT)*(Y(i)-yT));
    if TLen<Len
        Len=TLen;
        ID=i;
    end
end
