function [X1,Y1,R1,T1,MAT1]=Generate_Hex_Particle(x0,y0,R,N,M,Type)
%Generate Hex particle packing
%Input:
%(x0,y0):first point;
% R: radius
% N: Columns
% M: Rows
%--------------------------------------------------------------------------
figure;
hold on;
X1=zeros(1,N*M);
Y1=zeros(1,N*M);
R1=ones(1,N*M)*R;
MAT1=Type*ones(1,N*M);

    
T1=zeros(1,N*M);
for i=1:N
    for j=1:M
        if mod(i,2)==1
            X1((i-1)*M+j)=x0+(j-1)*R*2.0;
            Y1((i-1)*M+j)=y0+(i-1)*R*2.0*sin(pi/3);
        else
            X1((i-1)*M+j)=x0+(j-1)*R*2.0+R*2.0*cos(pi/3);
            Y1((i-1)*M+j)=y0+(i-1)*R*2.0*sin(pi/3);      
        end
    end
end
XT=[];
YT=[];
RT=[];
TT=[];
MATT=[];
for i=1:N
    if mod(i,2)==1
        XT=[XT,X1((i-1)*M+1:i*M)];
        YT=[YT,Y1((i-1)*M+1:i*M)];    
        RT=[RT,R1((i-1)*M+1:i*M)]; 
        TT=[TT,T1((i-1)*M+1:i*M)];
        MATT=[MATT,MAT1((i-1)*M+1:i*M)];
    else
        XT=[XT,X1((i-1)*M+1:i*M-1)];
        YT=[YT,Y1((i-1)*M+1:i*M-1)];    
        RT=[RT,R1((i-1)*M+1:i*M-1)]; 
        TT=[TT,T1((i-1)*M+1:i*M-1)];
        MATT=[MATT,MAT1((i-1)*M+1:i*M-1)];       
    end
end
X1=XT;
Y1=YT;
R1=RT;
T1=TT;
MAT1=MATT;