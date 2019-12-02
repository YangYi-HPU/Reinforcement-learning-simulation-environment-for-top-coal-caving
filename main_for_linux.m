clc
clear all;
tic
global NumP; % Number of particles
global X; % Vector of the X coordinates (1×NumP)
global Y; % Vector of the Y coordinates (1×NumP)
global R; % Vector of the radius (1×NumP)
global T; % Vecotr of the rotation of particles (1 x NumP)
global MATLIST;% Vector of  material ID of particles (1 x NumP)
global MAT; % Material set: [Density, Kn, Ks,Ft, C, Phi,dViscn,dViscs]
global WRT;% Bond thickness ratio
%-------------------------Data of Walls------------------------------------
global NumW;% Number of Walls
global XW1;% Vector of the X coordinate of the 1st point of the Walls
global YW1;% Vector of the Y coordinate of the 1st point of the Walls
global XW2;% Vector of the X coordinate of the 2nd point of the Walls
global YW2;% Vector of the X coordinate of the 2nd point of the Walls
global VXW;% Vector of the Velocity in X direction of the Walls
global VYW;% Vector of the Velocity in Y direction of the Walls
global MATWLIST;% Vector of material ID of the Walls
global MATW;% Wall material set: [Ft, C, Phi]
%--------------------Data of Boundary Conditions---------------------------
global BDEM_V0; % Boundary condtion of inital velocity [Particle ID, Direction, Value]
global BDEM_V; % Boundary condtion of velocity [Particle ID, Direction, Value]
global BDEM_F; % Boundary condtion of force [Particle ID, Direction, Value]
global BSDEM_F;% Truss like boundary [Particle ID, Fixed X, Fixed Y]
%------------------------Solver Configuration------------------------------
global NumLoop;% Number of loops
global ADamp;% Automatic damping (suggested 0.5 for static case)
global DeltTScale;% Ratio of actual time step to the calculated value
global Gy;% Gravity acceleration
%-----------------------Display and Post processing------------------------
global NumDisp;% Number of cycles for each display
% global StrFile;% File name of the output images
global XDisp; % Display window of the model
global YDisp; % Display window of the model
global M_ID; % Vector of particle ID for measurement
global M_TYPE;% Vector of type of data to be measured
global HData;% History data of the measured points
%-----------------------------P2P contact----------------------------------
global MAX_PN;% Max number of potential contact particles of each paritlce
global IDGX; % Grid ID in X direction of particle
global IDGY; % Grid ID in Y direction of each particle
global PP_C; % Contact Table
global Kn_PP;% Normal stiffness table of P2P contacts
global Ks_PP;% Shear stiffness table of P2P contacts
global Ft_PP;% Tensile strenth of P2P contacts
global Fc_PP;% Cohesion strenth of P2P contacts
global Fri_PP;% Friction of P2P contacts
global WT_PP; % Wall thickness of P2P contacts
global Vn_PP; % Normal viscous coefficent of P2P contacts
global Vs_PP; % Shear viscous coefficent of P2P contacts
%---------------------------P2W contact------------------------------------
global MaxWP;% Max number of potential contact particles of each wall
global PW_C;% Contact Table of P2W contacts
global Kn_PW;% Normal stiffness table of P2W contacts
global Ks_PW;% Shear stiffness table of P2W contacts
global Ft_PW;% Tensile strenth of P2W contacts
global Fc_PW;% Cohesion strenth of P2W contacts
global Fri_PW;% Friction of P2W contacts
global Vn_PW; % Normal viscous coefficent of P2W contact
global Vs_PW; % Shear viscous coefficent of P2W contact
%----------------------Display and Output Control--------------------------
global bFigOut; % 1/0: Save/(Not save)  image files during calculation 
global bBondPlot;% 1/0: Plot/(Not plot) the bond during calculation
global bDispNum;% 1/0: Plot/(Not plot) the particle number
global bDispDisc;%1/0: Plot/(Not plot) the particle model during caculation
global bParticleModel;%1/0: Plot/Not plot the Geometry model
global unReceived;
MAX_PN=6; % 设每个Particle接触的其他Particle数位6
HData=[]; % History Data  历史数据
Qvalue=zeros(2,12);  %% row1:open, action=0, Action[1];   row2:close action=1,Action[2] 
Reward=zeros(5,1);
Value=zeros(5,1); 
Action=[1,2]; %% 1 = open, 2 = close
State=8*ones(1,5);
RewardCoal=1;
RewardRock=-3;
StateNum = [8,1];
action=ones(1,5);
episode = 0;
HySu=0;
HyPress=zeros(1,5);
PI = zeros(2, 12, 5);
alf = 0.2;
gma = 0.1;
ifTrain = 1;
saveCounter = 0;
RewardEpisode=0;
TotalReward = [];
TotalRecall = [];

if ifTrain==1
    eValue = 0.98; % eValue 用于探索
    episodeNum = 10; 
    NumLoop=3000; 
    NumDisp=50;
%     temp=load ('Qvalue.mat');
%     Qvalue =temp.Qvalue;

%     for j=1:12
%         sum_all = exp(Qvalue(1,j)) + exp(Qvalue(2,j));
%         Qvalue(1,j) = exp(Qvalue(1,j))/sum_all;
%         Qvalue(2,j) = exp(Qvalue(2,j))/sum_all;
%     end
    for i =1:5
        PI(:,:,i) = Qvalue;        
    end
else
    episodeNum =1;
    NumLoop = 3000;
    NumDisp = 50;
    temp = load ('PI.mat');
    PI = temp.PI;
    eValue = 0.01; % eValue 用于探索
end
while(episode < episodeNum)
    
 %%----(1)create the partical model-----%%
    bFigOut=1;
    bBondPlot=0;
    bDispNum=0;
    bDispDisc=1;
    bParticleModel=1;
    % ----create the particals----%% 
    NumRock1=990;
    NumRock2=1536;    
    [X,Y,R,T,~] = Generate_Hex_Particle(0.5,60.5,0.5,40,50,1); %%%(x0,y0,R,Colum,Row,Type)
 
%     [X,Y,R,T,~] = Generate_Hex_Particle(0.5,60.5,0.5,2,50,1); %%%(x0,y0,R,Colum,Row,Type)
%     NumRock1=10;
%     NumRock2=15;
    [X,Y,R,T,MAT] = MyAddMaterial(X,Y,R,T,NumRock1,NumRock2, ifTrain); 
    close;
    MATLIST=[1500     1e8       1e7       0          0        37       0        0;  %% 煤的材质
             2500     1e8       1e7       0          0        37       0        0; %% 岩石的材质
             5500     1e8       1e7       0          0        37       0        0;
             7500     1e8       1e7       0          0        37       0        0]; %% 岩石的材质
            %[密度 法向刚度Kn 切向刚度Ks  抗张强度Ft  内聚力C  摩察角  法向粘性   切向粘性 ] 
    %------ create the wall------%% 
    MATW = ones(1,45);
    VXW = zeros(1,45);
    VYW = zeros(1,45);%Block caving
    NumW = 45;
    WRT = 0.8;
    MATWLIST = [0   0    60];
    % Gravity
    Gy = -300.0;
    ADamp = 0.5;
    DeltTScale = 0.1;
    %%-------end(1)-------%%
    
    NumP=length(X);% Number of particles
    M=zeros(1,NumP);% Inital mass vector
    I=zeros(1,NumP);% Inital moment of inertia
    unReceived = zeros(3,NumP);  %% 1:Y_PID, 2:Current Y postion, 3:last Y postion 
      
    
    %% delet the special dot
    ReDelet=[];
    for i=1:10
       ReDelet = [ReDelet, (i-1)*10+1];
    end
    ReDelet = [ReDelet,100];
    unReceived(:,ReDelet)=[];


    for YPID =1:NumP
        unReceived(1,YPID) = YPID;
        unReceived(2,YPID)=Y(YPID);   
        unReceived(3,YPID)=Y(YPID);
    end

%     if ifTrain==1  %% if the process is for train
%         RewardNum = zeros(5,2);
%         Reward = zeros(5,1);
%         Reward_all = sum(Reward);
%         %%% the initial process 
%         [unReceived,State,StateNum,Reward,RewardNum]= getState(X,Y,MAT,[60,61],unReceived,RewardCoal,RewardRock); 
%         for i =1:5
%             action(i) = policy(State(i),Action, Qvalue, ifTrain, eValue, StateNum, RewardCoal, RewardRock);  
%             HySu= HySu + (action(i)-1)*2^(5-i); 
%         end
%         
%         HySu= HySu + 2^5;       
%     else   %% if the process is for train
%         
%     end  
    HySu= bin2dec('100000');
    [XW1,YW1,XW2,YW2] = MySetWall(HySu);
    
    %%----*****---- plot the result ----*****----%%
%     set(gcf,'Position',[500 10 500 800])  
%     PlotPW(X,Y,T,R,MAT,XW1,YW1,XW2,YW2);
%     box on;
%     drawnow
%     PictureNum = 1;
%     SavePicture(PictureNum)=getframe(gcf);
    XDisp=[0,1200];
    YDisp=[0,1400];
    %%-----***-------end plot --------****------%%
    
    xm=mean(X);
    ym=mean(Y);
    % ---- create the memory particals-----%% 
%     M_ID =   [1, 1, 11, 11, 21,21, 31,31, 41,41, 51,51, 61,61, 71,71, 81,81, 91,91, 100,100];
%     M_TYPE = [7, 8, 7,  8,  7,  8, 7,  8, 7,  8, 7,  8, 7,  8, 7,  8, 7,  8, 7,  8, 7,  8 ];
    BDEM_V0=[];
    BDEM_V=[];
    BDEM_F=[];
    BSDEM_F=[];
    %Get mass and inertia of particles
    for i=1:NumP 
        DENSITY=MATLIST(MAT(i),1);
        M(i)=DENSITY*R(i)*R(i)*pi;
        I(i)=M(i)*R(i)^2/2.0;
    end
    %Store initial particle position
    X0=X;
    Y0=Y;
    T0=T;
    %Store the previous particle position since last contact detection
    XPr=X;
    YPr=Y;
    %Particle Velocity
    Vx=zeros(1,NumP);
    Vy=zeros(1,NumP);
    Vt=zeros(1,NumP);
    %Particle Accelaration
    Ax=zeros(1,NumP);
    Ay=zeros(1,NumP);
    At=zeros(1,NumP);
    %Particle Force
    Fx=zeros(1,NumP);
    Fy=zeros(1,NumP);
    Ft=zeros(1,NumP);
    %Initial Grid ID in X and Y directions
    IDGX=zeros(1,NumP);
    IDGY=zeros(1,NumP);
    %Grid for P2P contact detection
    Gx1=min(X)-max(R);
    Gy1=min(Y)-max(R);
    dGridSize=max(R)*2.0;
    for i=1:NumP
        IDGX(i)=floor((X(i)-Gx1)/dGridSize);
        IDGY(i)=floor((Y(i)-Gy1)/dGridSize);
    end
    %P2P contacts
    PP_C=zeros(MAX_PN,NumP); % Contact Table (1xNumP)
    Fn_PP=PP_C;% Normal force
    Fs_PP=PP_C;% Shear force
    Ft_PP=PP_C;% Tensile strength
    Fc_PP=PP_C;% Cohension 
    Fri_PP=PP_C;% Friction
    Kn_PP=PP_C;% Normal stiffness 
    Ks_PP=PP_C;% Shear stiffness
    WT_PP=PP_C;% Wall thickness
    MZ_PP=PP_C;% Moment of bond contacts
    Vn_PP=PP_C;% Normal viscous coefficent
    Vs_PP=PP_C;% Shear viscous coefficent
    % Initial Contact Detection 
    dContactGapRatio=0.01; % Theshold ratio for bond P2P contacts
    dGap=dContactGapRatio*mean(R);% Theshold value for P2P bond contact detection
    dGap2=mean(R)*0.5;% Gap for potential P2P contacts
    ContactDetection(dGap);%Intial P2P contact table
    % Material paramters of P2P contacts
    parfor i=1:NumP
        for j=1:MAX_PN
            jP=PP_C(j,i);
            if jP>0
               iMat=MAT(i);
               jMat=MAT(jP);
               Temp_Kn=0.5*(MATLIST(iMat,2)+MATLIST(jMat,2));
               Temp_Ks=0.5*(MATLIST(iMat,3)+MATLIST(jMat,3));
               Temp_Ft=min(MATLIST(iMat,4),MATLIST(jMat,4));
               Temp_Fc=min(MATLIST(iMat,5),MATLIST(jMat,5));
               Temp_Fri=min(MATLIST(iMat,6),MATLIST(jMat,6));
               Temp_Vn=0.5*(MATLIST(iMat,7)+MATLIST(jMat,7));
               Temp_Vs=0.5*(MATLIST(iMat,8)+MATLIST(jMat,8));
               Kn_PP(j,i)=Temp_Kn;
               Ks_PP(j,i)=Temp_Ks;
               Ft_PP(j,i)=Temp_Ft;
               Fc_PP(j,i)=Temp_Fc;
               Vn_PP(j,i)=Temp_Vn;
               Vs_PP(j,i)=Temp_Vs;
               Fri_PP(j,i)=tan(Temp_Fri/180*pi);
               WT_PP(j,i)=min(R(i),R(j))*WRT;
            end
        end    
    end
    %Get potential P2P contacts
    PushBufferContact(dGap2);
    % Time Step Begin
    K=max(MATLIST(MAT(1),2),MATLIST(MAT(1),3));
    DeltT=2*sqrt(M(1)/K);
    for i=2:NumP
        K=max(MATLIST(MAT(i),2),MATLIST(MAT(i),3));
        dTemp=2*sqrt(M(i)/K);
        if dTemp<DeltT
            DeltT=dTemp;
        end
    end
    DeltT=DeltT*DeltTScale;% actual time step
    % Time Step End
    Tcur=0.0;% Current time
    dBufferGap2=(dGap2*0.3)*(dGap2*0.3);% The max buffer size of contact detection 
    % Get boundary condition information
    [Bn,Bm]=size(BDEM_V0); % [ID, nType,Val]
    [BnV,BmV]=size(BDEM_V);% [ID, nType, Val]
    [BnF,BmF]=size(BDEM_F);% [ID, nType, Val]
    [BSnF,BSmF]=size(BSDEM_F);% [ID, nPX,nPY]
    % Apply initial particle velcoity
    for i=1:Bn
        iBType=BDEM_V0(i,2);
        switch iBType
            case 1
                Vx(BDEM_V0(i,1))=BDEM_V0(i,3);
            case 2
                Vy(BDEM_V0(i,1))=BDEM_V0(i,3);
            case 3
                Vt(BDEM_V0(i,1))=BDEM_V0(i,3);
        end
    end
    %
    E_PEG=[];%Kinematic Energy
    E_KE=[];%Strain Energy
    E_DE=[];%Gravity Potentional Energy
    
 %%%----------each episode----------%%% 

    RewardEpisode = 0; 
    for LoopCount=1:NumLoop         
        %%% set the state of support
        if mod(LoopCount,NumDisp)==0            
            StatePre = State;
            [unReceived,State,StateNum,Reward,RewardNum] = getState(X,Y,MAT,[60,61],unReceived,RewardCoal,RewardRock);            
            EndState = 1;
            for i =1:5
                EndState = EndState &&  (State(i) ==1 || State(i)==2); 
            end
            if EndState==1 
                HySu= bin2dec('111111');
                RewardEpisode = RewardEpisode+ sum(Reward);   
            else                 
                RewardEpisode = RewardEpisode+ sum(Reward);                
                HySu=0; 
                for i=1:5              
                    Qvalue(action(i),StatePre(i)) = Qvalue(action(i),StatePre(i)) + ...
                    alf*( Reward(i) + gma*max(Qvalue(:,State(i))) - Qvalue(action(i),StatePre(i))); 
                end            
                for i =1:5
                    action(i) = policy(State(i),Action,Qvalue,ifTrain,eValue,StateNum,RewardCoal,RewardRock);                 
                    HySu= HySu + (action(i)-1)*2^(5-i); % Initial Hydrualic Surpport State        
                end 
                HySu = HySu + 2^5;
            end
            show_reulst(Qvalue, episode, LoopCount, action, StatePre);
%             [XW1,YW1,XW2,YW2]= MySetWall(HySu); 
%             PlotPW_CL(X,Y,T,R,MAT,XW1,YW1,XW2,YW2,X0,Y0,1);
%             drawnow  
            save('Qvalue','Qvalue');
            save('PI','PI');
            saveCounter = saveCounter+1;
            tempCounter = num2str(saveCounter);
            save(strcat('SaveData/X',tempCounter),'X');
            save(strcat('SaveData/Y',tempCounter),'Y');
            save(strcat('SaveData/T',tempCounter),'T');
            save(strcat('SaveData/R',tempCounter),'R');
            save(strcat('SaveData/MAT',tempCounter),'MAT');
            save(strcat('SaveData/XW1',tempCounter),'XW1');
            save(strcat('SaveData/XW2',tempCounter),'XW2');
            save(strcat('SaveData/YW1',tempCounter),'YW1');
            save(strcat('SaveData/YW2',tempCounter),'YW2');
            save(strcat('SaveData/X0',tempCounter),'X0');
            save(strcat('SaveData/Y0',tempCounter),'Y0'); 
            if EndState==1 
                EndBreak=1;
                break 
            end
          
%             if ifTrain==0
% %                 PlotPW_CL(X,Y,T,R,MAT,XW1,YW1,XW2,YW2,X0,Y0,1);
% %                 drawnow
%                 %%Plot Truss String Boundary
%                 for j=1:BSnF
%                     BSID=BSDEM_F(j,1);
%                     BS_X=BSDEM_F(j,2);
%                     BS_Y=BSDEM_F(j,3);
%                     plot([X(BSID) BS_X],[Y(BSID) BS_Y],'k','linewidth',1);
%                     plot([X(BSID) BS_X],[Y(BSID) BS_Y],'ko','linewidth',1);            
%                 end                 
%             end
        end  
        
        % Initial P2W contacts
        NumW=length(XW1);% number of walls
        if NumW>0
            x1=XW1(1);
            x2=XW2(1);
            y1=YW1(1);
            y2=YW2(1);
            MaxWP=ceil(sqrt((x2-x1)*(x2-x1)+(y2-y1)*(y2-y1))/R(1))+6;
            for i=2:NumW
                x1=XW1(i);
                x2=XW2(i);
                y1=YW1(i);
                y2=YW2(i);
                dTMaxWP=ceil(sqrt((x2-x1)*(x2-x1)+(y2-y1)*(y2-y1))/R(1))+6;
                if dTMaxWP>MaxWP
                    MaxWP=dTMaxWP;
                end
            end
            PW_C=zeros(MaxWP,NumW);%Contact table of P2W contacts
            Fn_PW=PW_C;% Normal force of P2W contacts
            Fs_PW=PW_C;% Shear force of P2W contacts
            Ft_PW=PW_C;% Tensile strength of P2W contacts
            Fc_PW=PW_C;% Cohension strength of P2W contacts
            Fri_PW=PW_C;% Friction of P2W contacts
            Kn_PW=PW_C;% Normal stiffness of P2W contacts
            Ks_PW=PW_C;% Shear stiffness of P2W contacts
            Vn_PW=PW_C;% Viscous coefficent P2W contacts
            Vs_PW=PW_C;% Viscous coefficent P2W contacts
            FWX=zeros(1,NumW);%Reaction force on the wall in X direction
            FWY=zeros(1,NumW);%Reaction force on the wall in Y direction
            %Inital P2W contact table
            size(PW_C);
            ContactDetection_PW(dGap);
            %Material paramters of P2W contacts
            for i=1:NumW
                for j=1:MaxWP
                    jP=PW_C(j,i);
                    if jP>0
                       iMat=MATW(i);
                       jMat=MAT(jP);
                       Temp_Kn=MATLIST(jMat,2);
                       Temp_Ks=MATLIST(jMat,3);
                       Temp_Ft=MATWLIST(iMat,1);
                       Temp_Fc=MATWLIST(iMat,2);
                       Temp_Fri=MATWLIST(iMat,3);
                       Temp_Vn=MATLIST(jMat,7);
                       Temp_Vs=MATLIST(jMat,8);
                       Kn_PW(j,i)=2.0*Temp_Kn;
                       Ks_PW(j,i)=2.0*Temp_Ks;
                       Ft_PW(j,i)=Temp_Ft;
                       Fc_PW(j,i)=Temp_Fc;
                       Fri_PW(j,i)=tan(Temp_Fri/180*pi);
                       Vn_PW(j,i)=Temp_Vn;
                       Vs_PW(j,i)=Temp_Vs;
                    end
                end    
            end
        else
            PW_C=[];
        end        
        if NumW>0
           PushBufferContactPW(dGap2);%Get potential P2W contacts
        end        
        % Temp variables for Kinematic, Strain and Gravity Potentional Energy
        dTemp_KE=0.0;
        dTemp_DE=0.0;
        dTemp_PEG=0.0;
        %Initial Particle Forces
        parfor j=1:NumP
            Fx(j)=0.0;
            Fy(j)=M(j)*Gy;
            Ft(j)=0.0;
        end        
        %Apply Force Boundary
        for j=1:BnF
            iBType=BDEM_F(j,2);
            switch iBType
                case 1
                    Fx(BDEM_F(j,1))=Fx(BDEM_F(j,1))+BDEM_F(j,3);
                case 2
                    Fy(BDEM_F(j,1))=Fy(BDEM_F(j,1))+BDEM_F(j,3);
                case 3
                    Ft(BDEM_F(j,1))=BDEM_F(j,3);
            end
        end        
        % Truss String Boundary
        for j=1:BSnF
            BSID=BSDEM_F(j,1);
            BS_X=BSDEM_F(j,2);
            BS_Y=BSDEM_F(j,3);
            L0=sqrt((X0(BSID)-BS_X)*(X0(BSID)-BS_X)+(Y0(BSID)-BS_Y)*(Y0(BSID)-BS_Y));
            DX=BS_X-X(BSID);
            DY=BS_Y-Y(BSID);
            L=sqrt(DX*DX+DY*DY);
            DX=DX/L;
            DY=DY/L;
            TUn=L-L0;
            Temp_Kn=MATLIST(MAT(BSID),2);
            Fx(BSID)=Fx(BSID)+DX*TUn*Temp_Kn;
            Fy(BSID)=Fy(BSID)+DY*TUn*Temp_Kn;
            dTemp_DE=dTemp_DE+0.5*TUn*TUn*Temp_Kn;
        end        
        %P2P contact force
        parfor j=1:NumP
            for k=1:MAX_PN
                jP=PP_C(k,j);
                if jP>0
                    R1=R(j);
                    R2=R(jP);
                    Xdef=X(jP)-X(j);
                    Ydef=Y(jP)-Y(j);
                    D=sqrt(Xdef*Xdef+Ydef*Ydef);
                    SinAlpha=Ydef/D;
                    CosAlpha=Xdef/D;
                    Vdefx=Vx(jP)-Vx(j);
                    Vdefy=Vy(jP)-Vy(j);
                    Vn=Vdefx*CosAlpha+Vdefy*SinAlpha;
                    Vs=-SinAlpha*Vdefx+Vdefy*CosAlpha-Vt(j)*R1-Vt(jP)*R2;
                    Dn=Vn*DeltT;
                    Ds=Vs*DeltT;
                    if Ft_PP(k,j)==0.0 && Fn_PP(k,j)==0.0%Contact treatment
                       TUn=D-R1-R2; 
                       if TUn<0.0 && Dn<0.0
                            Dn=TUn;
                            Ds=Ds*(TUn/Dn);
                       end
                    end
                    Fn_PP(k,j)=Fn_PP(k,j)+Kn_PP(k,j)*Dn;
                    Fs_PP(k,j)=Fs_PP(k,j)+Ks_PP(k,j)*Ds;
                    FVn=Vn_PP(k,j)*Kn_PP(k,j)*Vn;
                    FVs=Vs_PP(k,j)*Ks_PP(k,j)*Vs;
                    if WT_PP(k,j)==0.0 % Classical bond treatment
                        if Ft_PP(k,j)==0.0 %Contact treatment
                            TUn=D-R1-R2; 
                            if TUn>0.0
                                Fn_PP(k,j)=0.0;
                                Fs_PP(k,j)=0.0;
                                FVn=0.0;
                                FVs=0.0;
                            end
                        end
                        TempFn=Fn_PP(k,j);
                        TempFs=Fs_PP(k,j);
                        %---Begin--MC---
                        if TempFn>Ft_PP(k,j)
                            Ft_PP(k,j)=0.0;
                            Fc_PP(k,j)=0.0;
                            Fn_PP(k,j)=0.0;
                            Fs_PP(k,j)=0.0;
                            FVn=0.0;
                            FVs=0.0;    
                        else
                            if abs(TempFs)> Fc_PP(k,j)-TempFn*Fri_PP(k,j);
                                if TempFn>0.0
                                    Ft_PP(k,j)=0.0;
                                    Fc_PP(k,j)=0.0;
                                    Fn_PP(k,j)=0.0;
                                    Fs_PP(k,j)=0.0;
                                    FVn=0.0;
                                    FVs=0.0;
                                else
                                    if abs(TempFs)>0.0
                                        Fs_PP(k,j)=Fs_PP(k,j)*(Fc_PP(k,j)-TempFn*Fri_PP(k,j))/abs(TempFs); 
                                        Ft_PP(k,j)=0.0;
                                        Fc_PP(k,j)=0.0;
                                    end
                                end
                            end 
                        end
                        %--End-MC---
                        %--Contact Force to Particle
                        Fx(j)=Fx(j)+(Fn_PP(k,j)+FVn)*CosAlpha-(Fs_PP(k,j)+FVs)*SinAlpha;
                        Fy(j)=Fy(j)+(Fn_PP(k,j)+FVn)*SinAlpha+(Fs_PP(k,j)+FVs)*CosAlpha;
                        Ft(j)=Ft(j)+(Fs_PP(k,j)+FVs)*R1;
                    else %Bond treatment
                        MZ=0.0;
                        MUZ=(Vt(jP)-Vt(j))*DeltT;
                        DMUn=WT_PP(k,j)*MUZ;
                        MFn=DMUn*Kn_PP(k,j)*0.25;
                        MZ=WT_PP(k,j)*MFn;
                        MZ_PP(k,j)=MZ_PP(k,j)+MZ;
                        MZ=MZ_PP(k,j);
                        MFn=MZ/WT_PP(k,j);
                        if Ft_PP(k,j)==0.0 %Contact treatment
                            TUn=D-R1-R2; 
                            if TUn>0.0
                                Fn_PP(k,j)=0.0;
                                Fs_PP(k,j)=0.0;
                                FVn=0.0;
                                FVs=0.0;
                            else
                            %Fn_PP(k,j)=TUn*Kn_PP(k,j);
                            end
                            MZ=0.0;
                        end
                        TempFn=Fn_PP(k,j);
                        TempFs=Fs_PP(k,j);
                        %---Begin-MC---
                        if TempFn*0.5>Ft_PP(k,j)*0.5-abs(MFn)
                            Ft_PP(k,j)=0.0;
                            Fc_PP(k,j)=0.0;
                            Fn_PP(k,j)=0.0;
                            Fs_PP(k,j)=0.0;
                            WT_PP(k,j)=0.0; 
                            MZ=0.0;
                            FVn=0.0;
                            FVs=0.0;
                        else
                            if abs(TempFs*0.5)> Fc_PP(k,j)*0.5-(TempFn*0.5+abs(MFn))*Fri_PP(k,j);
                                if TempFn>0.0
                                    Ft_PP(k,j)=0.0;
                                    Fc_PP(k,j)=0.0;
                                    Fn_PP(k,j)=0.0;
                                    Fs_PP(k,j)=0.0;
                                    WT_PP(k,j)=0.0;
                                    MZ=0.0;
                                    FVn=0.0;
                                    FVs=0.0;
                                else
                                    if abs(TempFs)>0.0
                                        Fs_PP(k,j)=Fs_PP(k,j)*(Fc_PP(k,j)-TempFn*Fri_PP(k,j))/abs(TempFs); 
                                        Ft_PP(k,j)=0.0;
                                        Fc_PP(k,j)=0.0;
                                    end
                                    WT_PP(k,j)=0.0;
                                    MZ=0.0;
                                end
                            end 
                        end
                        %--End-MC---
                        %--Contact Force to Particle
                        Fx(j)=Fx(j)+(Fn_PP(k,j)+FVn)*CosAlpha-(Fs_PP(k,j)+FVs)*SinAlpha;
                        Fy(j)=Fy(j)+(Fn_PP(k,j)+FVn)*SinAlpha+(Fs_PP(k,j)+FVs)*CosAlpha;
                        Ft(j)=Ft(j)+(Fs_PP(k,j)+FVs)*R1+MZ;
                        MFn=MZ/WT_PP(k,j);
                        if(Kn_PP(k,j)>0.0) %Add strain energy due to bending of bond
                           dTemp_DE=dTemp_DE+0.5*MFn*(MFn/Kn_PP(k,j));
                        end
                    end
                end
            end
        end    
    %P2W contact force
    for j=1:NumW
       FWX(j)=0.0;
       FWY(j)=0.0;
       for k=1:MaxWP
           jP=PW_C(k,j);
           if jP>0
              x1=XW1(j);
              y1=YW1(j);
              x2=XW2(j);
              y2=YW2(j);
              %---contact point---
              [XTemp,YTemp]=Contact_Pt_P_W2(x1,y1,x2,y2,X(jP),Y(jP),R(jP),dGap);
              Xdef=X(jP)-XTemp;
              Ydef=Y(jP)-YTemp;
              D=sqrt(Xdef*Xdef+Ydef*Ydef);
              SinAlpha=Ydef/D;
              CosAlpha=Xdef/D;            
              Vdefx=Vx(jP)-VXW(j);
              Vdefy=Vy(jP)-VYW(j);
              Vn=Vdefx*CosAlpha+Vdefy*SinAlpha;
              Vs=-SinAlpha*Vdefx+Vdefy*CosAlpha-Vt(jP)*R(jP);
              Dn=Vn*DeltT;
              Ds=Vs*DeltT;
              %Contact treatment
              if Ft_PW(k,j)==0.0 && Fn_PW(k,j)==0.0
                 TUn=D-R(jP); 
                 if TUn<0.0 && Dn<0.0
                    Dn=TUn;
                    Ds=Ds*(TUn/Dn);
                 end
              end
              Fn_PW(k,j)=Fn_PW(k,j)+Kn_PW(k,j)*Dn;
              Fs_PW(k,j)=Fs_PW(k,j)+Ks_PW(k,j)*Ds;
              FVn=Vn_PW(k,j)*Kn_PW(k,j)*Vn;
              FVs=Vs_PW(k,j)*Ks_PW(k,j)*Vs;
              if Ft_PW(k,j)==0.0 %Contact treatment
                 TUn=D-R(jP); 
                 if TUn>0.0
                    Fn_PW(k,j)=0.0;
                    Fs_PW(k,j)=0.0;
                    FVn=0.0;
                    FVs=0.0;
                 end
              end
              TempFn=Fn_PW(k,j);
              TempFs=Fs_PW(k,j);
              %--Begin-MC---
              if TempFn>Ft_PW(k,j)
                 Ft_PW(k,j)=0.0;
                 Fc_PW(k,j)=0.0;
                 Fn_PW(k,j)=0.0;
                 Fs_PW(k,j)=0.0;
                 FVn=0.0;
                 FVs=0.0;
              else
                 if abs(TempFs)> Fc_PW(k,j)-TempFn*Fri_PW(k,j)
                    if TempFn>0.0
                       Ft_PW(k,j)=0.0;
                       Fc_PW(k,j)=0.0;
                       Fn_PW(k,j)=0.0;
                       Fs_PW(k,j)=0.0;
                       FVn=0.0;
                       FVs=0.0;
                    else
                       if abs(TempFs)>0.0
                          Fs_PW(k,j)=Fs_PW(k,j)*(Fc_PW(k,j)-TempFn*Fri_PW(k,j))/abs(TempFs); 
                          Ft_PW(k,j)=0.0;
                          Fc_PW(k,j)=0.0;
                       end
                    end
                 end 
              end
              %--End-MC---
              %--Contact Force to Particle
              dWTempFx=((Fn_PW(k,j)+FVn)*CosAlpha-(Fs_PW(k,j)+FVs)*SinAlpha);
              dWTempFy=((Fn_PW(k,j)+FVn)*SinAlpha+(Fs_PW(k,j)+FVs)*CosAlpha);
              Fx(jP)=Fx(jP)-dWTempFx;
              Fy(jP)=Fy(jP)-dWTempFy;
              Ft(jP)=Ft(jP)+((Fs_PW(k,j)+FVs)*R(jP));
              FWX(j)=FWX(j)+dWTempFx;
              FWY(j)=FWY(j)+dWTempFy;
            end
       end
    end
    %Store particle force
    Fx0=Fx;
    Fy0=Fy;
    Ft0=Ft;
    %Local damping
    Fx=Fx-ADamp*sign(Vx).*abs(Fx);
    Fy=Fy-ADamp*sign(Vy).*abs(Fy);
    Ft=Ft-ADamp*sign(Vt).*abs(Ft);
    %Update Accelaration 
    Ax=Fx./M;
    Ay=Fy./M;
    At=Ft./I;
    %Update Velocity 
    Vx=Vx+Ax*DeltT;
    Vy=Vy+Ay*DeltT;
    Vt=Vt+At*DeltT;
    %Vleoicty Boundary Condition
    for j=1:BnV
        iBType=BDEM_V(j,2);
        switch iBType
            case 1
                Vx(BDEM_V(j,1))=BDEM_V(j,3);
            case 2
                Vy(BDEM_V(j,1))=BDEM_V(j,3);
            case 3
                Vt(BDEM_V(j,1))=BDEM_V(j,3);
        end
    end   
    %Update Position 
    X=X+Vx*DeltT;
    Y=Y+Vy*DeltT;
    T=T+Vt*DeltT;
    %Update Time 
    Tcur=Tcur+DeltT;
    TMTemp=Tcur;% Current time
    %Update Wall's Positions 
    for j=1:NumW
        XW1(j)=XW1(j)+VXW(j)*DeltT;
        YW1(j)=YW1(j)+VYW(j)*DeltT;
        XW2(j)=XW2(j)+VXW(j)*DeltT;
        YW2(j)=YW2(j)+VYW(j)*DeltT;
    end
    %Record data of measure points
    for j=1:length(M_ID)
        switch M_TYPE(j)
            case 1% X Position
                TMTemp=[TMTemp,X(M_ID(j))];
            case 2% Y Position
                TMTemp=[TMTemp,Y(M_ID(j))];
            case 3% T Rotation
                TMTemp=[TMTemp,T(M_ID(j))];
            case 4% UX
                TMTemp=[TMTemp,X(M_ID(j))-X0(M_ID(j))];
            case 5% UY
                TMTemp=[TMTemp,Y(M_ID(j))-Y0(M_ID(j))];
            case 6% UT
                TMTemp=[TMTemp,T(M_ID(j))-T0(M_ID(j))];
            case 7% FX
                TMTemp=[TMTemp,Fx0(M_ID(j))];
            case 8% FY
                TMTemp=[TMTemp,Fy0(M_ID(j))];
            case 9% VX
                TMTemp=[TMTemp,Vx(M_ID(j))];
            case 10% VY
                TMTemp=[TMTemp,Vy(M_ID(j))];
            case 11% FX of wall
                TMTemp=[TMTemp,FWX(M_ID(j))];                
            case 12% FY of wall
                TMTemp=[TMTemp,FWY(M_ID(j))];
        end
    end
    HData=[HData;TMTemp];% Measured data    
    % Calculate strain energy of P2W contacts
    for j=1:NumW
        for k=1:MaxWP    
            jP=PW_C(k,j);
            if jP>0
                if Kn_PW(k,j)>0.0
                   dTemp_DE=dTemp_DE+0.5*Fn_PW(k,j)*(Fn_PW(k,j)/Kn_PW(k,j));
                end
                if Ks_PW(k,j)>0.0
                   dTemp_DE=dTemp_DE+0.5*Fs_PW(k,j)*(Fs_PW(k,j)/Ks_PW(k,j));
                end
            end
        end
    end
     % Calculate strain energy of P2P contacts 
     parfor j=1:NumP
        for k=1:MAX_PN      
            jP=PP_C(k,j);
            if jP>0
               if Kn_PP(k,j)>0.0
                  dTemp_DE=dTemp_DE+0.25*Fn_PP(k,j)*(Fn_PP(k,j)/Kn_PP(k,j));
               end
               if Ks_PP(k,j)>0.0
                  dTemp_DE=dTemp_DE+0.25*Fs_PP(k,j)*(Fs_PP(k,j)/Ks_PP(k,j));
               end
            end
        end
        dTemp_PEG=dTemp_PEG+M(j)*Gy*(Y0(j)-Y(j));
        dTemp_KE=dTemp_KE+0.5*M(j)*Vx(j)*Vx(j)+0.5*M(j)*Vy(j)*Vy(j)+0.5*I(j)*Vt(j)*Vt(j);
     end
     E_PEG=[E_PEG,dTemp_PEG];
     E_KE=[E_KE,dTemp_KE];
     E_DE=[E_DE,dTemp_DE];     
     %Contact detection
     dMoveLen2=max((XPr-X).^2+(YPr-Y).^2);
     if(dBufferGap2<dMoveLen2)
        % Update the grid ID of particles
        Gx1=min(X);
        Gy1=min(Y);
        for j=1:NumP
            IDGX(j)=floor((X(j)-Gx1)/dGridSize);
            IDGY(j)=floor((Y(j)-Gy1)/dGridSize);
        end       
        XPr=X;
        YPr=Y;
        PushBufferContact(dGap2);
        if NumW>0
           PushBufferContactPW(dGap2);
        end
     end      
    end
    
    %% Caculate the reward and recall rate of this epsodi
    TotalReward = [TotalReward, RewardEpisode];

    CoalNum = 0;
    for i=1:NumP 
        if MAT(i) == 1
             CoalNum = CoalNum + 1;
        end
    end
    
    [mm, nn] = size(unReceived);
    unCoalNum = 0;
    for i = 1:nn
        PID = unReceived(1,i);
        if MAT(PID)==1
            unCoalNum = unCoalNum+1;
        end
    end
    Recall = (CoalNum-unCoalNum)/CoalNum;
    TotalRecall = [TotalRecall,Recall];    
    save('SaveData/TotalRecall','TotalRecall');
    save('SaveData/TotalReward','TotalReward');    
    episode = episode + 1;
    
end
toc
% reward= load('SaveData/TotalReward');
% figure(2)
% plot(reward.TotalReward)
% 
% figure(3)
% rewcall = load('SaveData/TotalRecall'); 
% plot(rewcall.TotalRecall)





