function PlotParticle2D(cx,cy,R,Thelt,N,Clr)
%--------------------------------------------------------------------------
%Plot a single partilce
%Input:
%(cx,cy):center position; R:radius;Thelt:angle direction; Clr: particle color
%--------------------------------------------------------------------------
t = 0:pi/N:2*pi;
patch(sin(t)*R+cx,cos(t)*R+cy,Clr);
plot([cx,cx+R*cos(Thelt)],[cy,cy+R*sin(Thelt)],'k');
