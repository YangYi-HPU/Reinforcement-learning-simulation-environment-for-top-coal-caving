function action = e_greedy(e,Action,StateNum,RewardCoal,RewardRock)    

    if rand(1)<=e %% e用于随机探索
        if rand(1)>0.5
            action = Action(1);
        else
            action = Action(2);
        end
    else    %% 否则用于利用，即选择获利最大的方向
        R = StateNum(1)*RewardCoal+StateNum(2)*RewardRock; 
        if R >=0
            action =Action(1);
        else
            action =Action(2);
        end        
    end 
end