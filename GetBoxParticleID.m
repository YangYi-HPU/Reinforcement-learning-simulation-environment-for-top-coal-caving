function ID=GetBoxParticleID(X,Y,x1,y1,x2,y2)
%--------------------------------------------------------------------------
% All copyrights reserved @ 2014-2050 Dr. Gaofeng Zhao
% TIANJIN UNIVERSITY (China)
% Email: dicetju@qq.com 
%--------------------------------------------------------------------------
%            Get the IDs of the selected particles
%--------------------------------------------------------------------------
ID=[];
N=length(X);
for i=1:N
    if X(i)>x1 && X(i)<x2
        if Y(i)>y1 && Y(i)<y2
            ID=[ID,i];
        end
    end    
end