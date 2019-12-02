function PlotParticleModel(X,Y,T,R,MAT)
%--------------------------------------------------------------------------
% Plot Particle Model
%--------------------------------------------------------------------------
global bDispNum;
NP=length(X);
ClrT=GetColorTable;
[NC,MC]=size(ClrT);
NCSeg=10;

for i=1:NP
    switch MAT(i)
        case 1
          ClrT1=[0,0,1];  
    
        case 2   
            ClrT1=[1,0,0];
        case 3
             ClrT1=[0,1,0];
        case 4
            ClrT1=[1,1,0];
    end
    ClrT(mod(MAT(i)-1,NC)+1,:);
%     PlotParticle2D(X(i),Y(i),R(i),T(i),NCSeg,ClrT(mod(MAT(i)-1,NC)+1,:));
    PlotParticle2D(X(i),Y(i),R(i),T(i),NCSeg,ClrT1);
    if bDispNum==1
        text(X(i),Y(i),R(i),int2str(i));
    end
end