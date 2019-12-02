function action = policy(State,Action,Qvalue,ifTrain,e,StateNum,RewardCoal,RewardRock)
    if State ==1 || State == 2 
            action = Action(2);
    else
        if ifTrain ==1            
            action = e_greedy(e,Action,StateNum,RewardCoal,RewardRock); 
        else
            if Qvalue(1,State)>=Qvalue(2,State)
                action=Action(1);
            else
                action=Action(2);
            end        
        end
    end
end