function [X1,Y1,R1,T1,MAT1]=ReadFromFile(sfile)
%--------------------------------------------------------------------------
% All copyrights reserved @ 2014-2020 Dr. Gaofeng Zhao
% TIANJIN UNIVERSITY (China), UNSW (Australia)
% Email: zhaodlsm@gamil.com
%--------------------------------------------------------------------------
%
%Read Particle Data From File
%
%--------------------------------------------------------------------------
FileID=fopen(sfile,'r');
NumP=fscanf(FileID,'%d',1);
X1=zeros(1,NumP);
Y1=zeros(1,NumP);
R1=zeros(1,NumP);
T1=zeros(1,NumP);
MAT1=ones(1,NumP);
iTempID=0;
for i=1:NumP
    iTempID=fscanf(FileID,'%d',1);
    X1(i)=fscanf(FileID,'%f',1);
    Y1(i)=fscanf(FileID,'%f',1); 
    R1(i)=fscanf(FileID,'%f',1);    
end
fclose(FileID);