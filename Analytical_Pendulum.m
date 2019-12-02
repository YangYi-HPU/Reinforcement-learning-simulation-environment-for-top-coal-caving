function [TA,UA]=Analytical_Pendulum
%--------------------------------------------------------------------------
% All copyrights reserved @ 2014-2050 Dr. Gaofeng Zhao
% TIANJIN UNIVERSITY (China)
% Email: dicetju@qq.com 
%--------------------------------------------------------------------------
% Analytical solution of the Pendulum problem
%--------------------------------------------------------------------------
L=100;
g=-10;
NUM=10000;
TEND=18;
TA=linspace(0,TEND,NUM);
X=pi/2;
dX=0;
ddX=0;

dDeltT=TA(2)-TA(1);
UY=[];
for i=1:NUM
    dUY=cos(X)*L;
    UY=[UY,dUY];
    ddX=-g/L*sin(X);
    dX=dX+ddX*dDeltT;
    X=X+dX*dDeltT;
end
UA=UY;