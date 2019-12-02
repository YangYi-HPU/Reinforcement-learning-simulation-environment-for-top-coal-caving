function Pre_PostDEM (option,iEx)
%--------------------------------------------------------------------------
% All copyrights reserved @ 2014-2020 Dr. Gaofeng Zhao
% TIANJIN UNIVERSITY (China), UNSW (Australia)
% Email: zhaodlsm@gamil.com
%--------------------------------------------------------------------------
%Preprocessor DICE2D
%Input:
%iEx: option=0
%--------------------------------------------------------------------------
global X;
global Y;
global R;
global T;
global MAT;
global XW1;
global YW1;
global XW2;
global YW2;
global MATW;
global MATLIST;
global MATWLIST;
global NumLoop;
global NumDisp;
global Gx;
global Gy;
global ADamp;
global DeltTScale;
global StrFile;
global XDisp;
global YDisp;
global M_ID;
global M_TYPE;
global BDEM_V0;
global BDEM_V;
global BDEM_F;
global BSDEM_F;
global WRT;
global VXW;
global VYW;
global HData;

if option==0% Preprocessor
    switch(iEx)
        case 1
          [X,Y,R,T,MAT,XW1,YW1,XW2,YW2,MATW,MATLIST,MATWLIST,NumLoop,NumDisp,Gx,Gy,ADamp,DeltTScale,StrFile,XDisp,YDisp,M_ID,M_TYPE,BDEM_V0,BDEM_V,BDEM_F,BSDEM_F,WRT,VXW,VYW]=Ex_I_001;
        case 2
          [X,Y,R,T,MAT,XW1,YW1,XW2,YW2,MATW,MATLIST,MATWLIST,NumLoop,NumDisp,Gx,Gy,ADamp,DeltTScale,StrFile,XDisp,YDisp,M_ID,M_TYPE,BDEM_V0,BDEM_V,BDEM_F,BSDEM_F,WRT,VXW,VYW]=Ex_I_002;
        case 3
          [X,Y,R,T,MAT,XW1,YW1,XW2,YW2,MATW,MATLIST,MATWLIST,NumLoop,NumDisp,Gx,Gy,ADamp,DeltTScale,StrFile,XDisp,YDisp,M_ID,M_TYPE,BDEM_V0,BDEM_V,BDEM_F,BSDEM_F,WRT,VXW,VYW]=Ex_I_003;
        case 4
          [X,Y,R,T,MAT,XW1,YW1,XW2,YW2,MATW,MATLIST,MATWLIST,NumLoop,NumDisp,Gx,Gy,ADamp,DeltTScale,StrFile,XDisp,YDisp,M_ID,M_TYPE,BDEM_V0,BDEM_V,BDEM_F,BSDEM_F,WRT,VXW,VYW]=Ex_I_004;
        case 5
          [X,Y,R,T,MAT,XW1,YW1,XW2,YW2,MATW,MATLIST,MATWLIST,NumLoop,NumDisp,Gx,Gy,ADamp,DeltTScale,StrFile,XDisp,YDisp,M_ID,M_TYPE,BDEM_V0,BDEM_V,BDEM_F,BSDEM_F,WRT,VXW,VYW]=Ex_I_005;
        case 6
          [X,Y,R,T,MAT,XW1,YW1,XW2,YW2,MATW,MATLIST,MATWLIST,NumLoop,NumDisp,Gx,Gy,ADamp,DeltTScale,StrFile,XDisp,YDisp,M_ID,M_TYPE,BDEM_V0,BDEM_V,BDEM_F,BSDEM_F,WRT,VXW,VYW]=Ex_I_006;
        case 7
          [X,Y,R,T,MAT,XW1,YW1,XW2,YW2,MATW,MATLIST,MATWLIST,NumLoop,NumDisp,Gx,Gy,ADamp,DeltTScale,StrFile,XDisp,YDisp,M_ID,M_TYPE,BDEM_V0,BDEM_V,BDEM_F,BSDEM_F,WRT,VXW,VYW]=Ex_I_007;
        case 8
          [X,Y,R,T,MAT,XW1,YW1,XW2,YW2,MATW,MATLIST,MATWLIST,NumLoop,NumDisp,Gx,Gy,ADamp,DeltTScale,StrFile,XDisp,YDisp,M_ID,M_TYPE,BDEM_V0,BDEM_V,BDEM_F,BSDEM_F,WRT,VXW,VYW]=Ex_I_008;
        case 9
          [X,Y,R,T,MAT,XW1,YW1,XW2,YW2,MATW,MATLIST,MATWLIST,NumLoop,NumDisp,Gx,Gy,ADamp,DeltTScale,StrFile,XDisp,YDisp,M_ID,M_TYPE,BDEM_V0,BDEM_V,BDEM_F,BSDEM_F,WRT,VXW,VYW]=Ex_I_009;
        case 10
          [X,Y,R,T,MAT,XW1,YW1,XW2,YW2,MATW,MATLIST,MATWLIST,NumLoop,NumDisp,Gx,Gy,ADamp,DeltTScale,StrFile,XDisp,YDisp,M_ID,M_TYPE,BDEM_V0,BDEM_V,BDEM_F,BSDEM_F,WRT,VXW,VYW]=Ex_I_010;
        case 11
          [X,Y,R,T,MAT,XW1,YW1,XW2,YW2,MATW,MATLIST,MATWLIST,NumLoop,NumDisp,Gx,Gy,ADamp,DeltTScale,StrFile,XDisp,YDisp,M_ID,M_TYPE,BDEM_V0,BDEM_V,BDEM_F,BSDEM_F,WRT,VXW,VYW]=Ex_I_011;
        case 12
          [X,Y,R,T,MAT,XW1,YW1,XW2,YW2,MATW,MATLIST,MATWLIST,NumLoop,NumDisp,Gx,Gy,ADamp,DeltTScale,StrFile,XDisp,YDisp,M_ID,M_TYPE,BDEM_V0,BDEM_V,BDEM_F,BSDEM_F,WRT,VXW,VYW]=Ex_I_012;
      end
elseif option==1 %Postprocessor
     switch(iEx)
         case 1
            Ex_P_001(HData,StrFile);
         case 2
            Ex_P_002(HData,StrFile);
         case 3
            Ex_P_003(HData,StrFile);
         case 4
            Ex_P_004(HData,StrFile);
         case 5
            Ex_P_005(HData,StrFile);
         case 6
            Ex_P_006(HData,StrFile);
         case 7
            Ex_P_007(HData,StrFile);
         case 8
            Ex_P_008(HData,StrFile);
         case 9
            Ex_P_009(HData,StrFile);
         case 10
            Ex_P_010(HData,StrFile);
         case 11
            Ex_P_011(HData,StrFile);
         case 12
            Ex_P_012(HData,StrFile);
     end
end
