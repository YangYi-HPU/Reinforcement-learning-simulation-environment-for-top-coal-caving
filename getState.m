function [unReceived1,State,StateNum,Rw,Reward] = getState(X,Y,MAT,YRange,unReceived,RewardCoal,RewardRock)
 
    StateNum = zeros(5,2);
    Num = length(unReceived(1,:));
    Reward = zeros(5,2);
    Rw = zeros(5,1);
    RecordDelet = [];
    State=2*ones(1,5);
    for i = 1: Num
        PID = unReceived(1,i);  %%  get the ID
        unReceived(2,i) = Y(PID);  %% get the current Y postion        
        WID = fix(X(PID)/10)+1; %% get the window ID, i.e. the partical fail from the window        
        if unReceived(2,i) > YRange(1) && unReceived(2,i) <YRange(2)  %% 到达放煤口边缘            
            switch MAT(PID)
                case 1  %% coal
                    StateNum(WID,1) = StateNum(WID,1)+1;                    
                case 2   %% rock
                    StateNum(WID,2) = StateNum(WID,2)+1;  
                case 4   %% rock
                    StateNum(WID,2) = StateNum(WID,2)+1;
            end  
        elseif unReceived(2,i) <=YRange(1) && unReceived(3,i) > YRange(1) %% 通过放煤口            
            switch MAT(PID)
                case 1
                    Reward(WID,1) = Reward(WID,1)+1;                    
                case 2
                    Reward(WID,2) = Reward(WID,2)+1; 
                case 4
                    Reward(WID,2) = Reward(WID,2)+1; 
            end 
            RecordDelet = [RecordDelet,i];
        end 
        unReceived(3,i) = unReceived(2,i);
    end   
    
    unReceived(:,RecordDelet)=[];
    unReceived1 = unReceived;
    
    
    total = StateNum(:,1)+ StateNum(:,2);
 
    %----the state illustration-----%   
  
 % rate is denote the rate of coal to all(coal+rock)
 % rate=0, 0-0.1,0.1-0.2,0.2-0.3,0.3-0.4,0.4-0.5,0.5-0.6,0.6-0.7,0.7-0.8,0.8-0.9,0.9-1.0,1.0
 %State=1,  2,    3,      4,      5,      6,      7,      8,      9,      10,     11,     12
    for i =1:5       
        if total(i) == 0   % there is nothing 
            State(i)=1;
        else
            State(i) = fix(StateNum(i,1)/total(i)*10)+2;
        end
    end
    Rw = Reward(:,1)*RewardCoal+Reward(:,2)*RewardRock;
%     Rw = Rw;%% This is time cost in the reward
   
end