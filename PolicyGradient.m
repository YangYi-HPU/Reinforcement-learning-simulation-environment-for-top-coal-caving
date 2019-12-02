function [mu1, sita1]=PolicyGradient(mu, PI, State ,Press, Action, sita,c1,c2,sgm1,sgm2, lmd1, lmd2, Reward_all)
    
    delt_u = zeros(1,5);
    delt_sita = zeros(1,4);
    
%%% Zs 
    lmd_vk = lmd1*vk1(Press(1),Press(2),Press(3)) + lmd2*vk2(State(1),State(2),State(3));   
    lmd_vk = lmd_vk + lmd1*vk1(Press(3),Press(4),Press(5)) + lmd2*vk2(State(3),State(4),State(5));
    for i =2:4
        lmd_vk = lmd_vk + lmd1*vk1(Press(i-1),Press(i),Press(i+1)) + lmd2*vk2(State(i-1),State(i),State(i+1));        
    end
 
    mu_pi_1 = 0;
    mu_pi_2 = 0;
    for i =1:5
        mu_pi_1 = mu_pi_1 + mu(i)*PI(1,State(i),i);
        mu_pi_2 = mu_pi_2 + mu(i)*PI(2,State(i),i);
    end

    Zs_1 = exp(lmd_vk + mu_pi_1);
    Zs_2 = exp(lmd_vk + mu_pi_2);
    Zs = Zs_1 + Zs_2;
    

%%% partial differential of mu
    for i = 1:5 
        temp = Zs_1*PI(1,State(i),i) + Zs_2*PI(1,State(i),i);   
        temp = temp/Zs;        
        delt_u(i) = PI(Action(i),State(i),i) - gather(temp); 
    end

%   %%% partial differential of sita

  for k =1:4
    for i = 1:5
        temp1 = mu(i)*d_pi(State(i), Action(i), c1(k), c2(k), sgm1(k), sgm2(k));
    end
    sum_pi_1 = 0;
    sum_pi_2 = 0;
    
    for i=1:5
            sum_pi_1 = sum_pi_1 + mu(i)*PI(1,State(i),i)*d_pi(State(i), 1, c1(k), c2(k), sgm1(k), sgm2(k));
            sum_pi_2 = sum_pi_2 + mu(i)*PI(2,State(i),i)*d_pi(State(i), 2, c1(k), c2(k), sgm1(k), sgm2(k));
    end
      
    
    delt_sita(k) = temp1 - gather( (Zs_1*sum_pi_1 + Zs_2*sum_pi_2)/Zs);
    
  end

  mu1= mu + 0.001*Reward_all*delt_u;
  sita1 = sita + 0.001*Reward_all*delt_sita;
  end




