function [X1,Y1,R1,T1,MAT1]=Generate_Cub_Particle(x0,y0,R,N,M)
%--------------------------------------------------------------------------
% All copyrights reserved @ 2014-2050 Dr. Gaofeng Zhao
% TIANJIN UNIVERSITY (China)
% Email: dicetju@qq.com 
%--------------------------------------------------------------------------
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
MAT1=ones(1,N*M);
T1=zeros(1,N*M);
for i=1:N
    for j=1:M
            X1((i-1)*M+j)=x0+(j-1)*R*2.0;
            Y1((i-1)*M+j)=y0+(i-1)*R*2.0;
    end
end