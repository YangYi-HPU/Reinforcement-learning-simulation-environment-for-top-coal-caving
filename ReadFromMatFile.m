function [X,Y,R,T,MAT]=ReadFromMatFile(sfile)
%--------------------------------------------------------------------------
% All copyrights reserved @ 2014-2020 Dr. Gaofeng Zhao
% TIANJIN UNIVERSITY (China), UNSW (Australia)
% Email: zhaodlsm@gamil.com
%--------------------------------------------------------------------------
% Example 06 (Chapter 3,3.4.4 Mining)
%--------------------------------------------------------------------------
load(sfile,'X','Y','R');
n=length(X);
T=zeros(1,n);
MAT=ones(1,n);