function action = e_greedy(e,Action,StateNum,RewardCoal,RewardRock)    

    if rand(1)<=e %% e�������̽��
        if rand(1)>0.5
            action = Action(1);
        else
            action = Action(2);
        end
    else    %% �����������ã���ѡ��������ķ���
        R = StateNum(1)*RewardCoal+StateNum(2)*RewardRock; 
        if R >=0
            action =Action(1);
        else
            action =Action(2);
        end        
    end 
end