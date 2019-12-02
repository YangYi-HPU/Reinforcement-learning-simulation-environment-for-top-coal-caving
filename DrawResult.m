function DrawResult
    clc
    clear all;
    SaveNum = 12;
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

    global ADamp;% Automatic damping (suggested 0.5 for static case)
    global DeltTScale;% Ratio of actual time step to the calculated value
    global Gy;% Gravity acceleration

    ifTrain = 1;
    % ----create the particals----%% 
    NumRock1=990;
    NumRock2=1536;    
    [X,Y,R,T,~] = Generate_Hex_Particle(0.5,60.5,0.5,40,50,1); %%%(x0,y0,R,Colum,Row,Type)
    % NumType1=100;
    % [X,Y,R,T,~] = Generate_Hex_Particle(0.5,60.5,0.5,2,100,1); %%%(x0,y0,R,Colum,Row,Type)
    % 
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
    HySu= bin2dec('100000');
    [XW1,YW1,XW2,YW2]= MySetWall(HySu);
    set(gcf,'Position',[500 100 500 800])  
    PlotPW(X,Y,T,R,MAT,XW1,YW1,XW2,YW2);
    box on;
    drawnow
    
    for i=1: SaveNum
        i_str = num2str(i);
        X = load(strcat('SaveData\X',i_str));
        X = X.X;
        
        Y = load(strcat('SaveData\Y',i_str));
        Y = Y.Y;
        
        T = load(strcat('SaveData\T',i_str));
        T = T.T;
        
        R = load(strcat('SaveData\R',i_str));
        R = R.R;
        
        MAT = load(strcat('SaveData\MAT',i_str));
        MAT = MAT.MAT;
        
        XW1 = load(strcat('SaveData\XW1',i_str));
        XW1 = XW1.XW1;
        
        XW2 = load(strcat('SaveData\XW2',i_str));
        XW2 = XW2.XW2;
        
        YW1 = load(strcat('SaveData\YW1',i_str));
        YW1 = YW1.YW1;
        
        YW2 = load(strcat('SaveData\YW2',i_str));
        YW2 = YW2.YW2;
        
        X0 = load(strcat('SaveData\X0',i_str));
        X0 = X0.X0;
        
        Y0 = load(strcat('SaveData\Y0',i_str));
        Y0 = Y0.Y0;
        
                
        PlotPW_CL(X,Y,T,R,MAT,XW1,YW1,XW2,YW2,X0,Y0,1);
        drawnow
    
    end
        
    
   


end