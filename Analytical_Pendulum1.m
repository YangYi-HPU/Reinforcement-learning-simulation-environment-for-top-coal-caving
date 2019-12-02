function [TA,UA]=Analytical_Pendulum1
%--------------------------------------------------------------------------
% All copyrights reserved @ 2014-2050 Dr. Gaofeng Zhao
% TIANJIN UNIVERSITY (China)
% Email: dicetju@qq.com 
%--------------------------------------------------------------------------
% Analytical solution of the Newton ball problem
%--------------------------------------------------------------------------

L=100;
g=-10;
NUM=10000;
TEND=36;
TA=linspace(0,TEND,NUM);
X=0;
dX=30/100;
ddX=0;

dDeltT=TA(2)-TA(1);
UY=[];
for i=1:NUM
    dUY=cos(X)*L;
    UY=[UY,dUY];
    ddX=g/L*sin(X);
    dX=dX+ddX*dDeltT;
    X=X+dX*dDeltT;
end
UA=-UY;
%plot(TA,UA);