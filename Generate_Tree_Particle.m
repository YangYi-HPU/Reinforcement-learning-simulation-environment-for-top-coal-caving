function [X,Y,R,T,MAT]=Generate_Tree_Particle
%--------------------------------------------------------------------------
% All copyrights reserved @ 2014-2050 Dr. Gaofeng Zhao
% TIANJIN UNIVERSITY (China)
% Email: dicetju@qq.com 
%--------------------------------------------------------------------------
% Example 05 (Chapter 3,3.4.3 Tree)
%--------------------------------------------------------------------------
A=imread('Tree.bmp');

[n,m]=size(A);

Nnum=sum(sum(1-A));
iIndex=1;
X=zeros(1,Nnum);
Y=zeros(1,Nnum);
R=10*ones(1,Nnum);
T=zeros(1,Nnum);
MAT=ones(1,Nnum);
for i=1:n
    for j=1:m
        if(A(i,j)==0)
         xCur=10+(j-1)*20;
         yCur=20*n-(10+(i-1)*20);
         X(iIndex)=xCur;
         Y(iIndex)=yCur;
         iIndex=iIndex+1;
        end
    end
end