function Un=Contact_P_P(x1,y1,x2,y2,R1,R2)
%--------------------------------------------------------------------------
% All copyrights reserved @ 2014-2020 Dr. Gaofeng Zhao
% TIANJIN UNIVERSITY (China), UNSW (Australia)
% Email: gzhaomech@outlook.com
%--------------------------------------------------------------------------
% P2P Contact detection
%--------------------------------------------------------------------------
Un=R1+R2-sqrt((x2-x1)^2+(y2-y1)^2);