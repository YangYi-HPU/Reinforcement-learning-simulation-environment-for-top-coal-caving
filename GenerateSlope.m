function [X,Y,R,T,MAT]=GenerateSlope(X1,Y1,R1,T1)
%--------------------------------------------------------------------------
% All copyrights reserved @ 2014-2050 Dr. Gaofeng Zhao
% TIANJIN UNIVERSITY (China)
% Email: dicetju@qq.com 
%--------------------------------------------------------------------------
% Get a slope model using texture method
%--------------------------------------------------------------------------

idX=floor(X1);
idY=floor(Y1);
A=imread('slope002.bmp');
[NMax,MMax,iTemp]=size(A);
X=[];
Y=[];
R=[];
MAT=[];
T=[];
N=length(X1);

for i=1:N
    if(idX(i)>0 && idY(i)>0 && idX(i)<=MMax &&idY(i)<=NMax)
    iColor=A(NMax-idY(i)+1,idX(i),1);
    switch iColor
        case 0
            X=[X,X1(i)];
            Y=[Y,Y1(i)];
            T=[T,T1(i)];
            R=[R,R1(i)];
            MAT=[MAT,4];
           
        case 127
            X=[X,X1(i)];
            Y=[Y,Y1(i)];
            T=[T,T1(i)];
            R=[R,R1(i)];
            MAT=[MAT,1]; 
            
        case 136
            X=[X,X1(i)];
            Y=[Y,Y1(i)];
            T=[T,T1(i)];
            R=[R,R1(i)];
            MAT=[MAT,3]; 
             
        case 34
            X=[X,X1(i)];
            Y=[Y,Y1(i)];
            T=[T,T1(i)];
            R=[R,R1(i)];
            MAT=[MAT,2]; 
        
    end 
    end
   
end
