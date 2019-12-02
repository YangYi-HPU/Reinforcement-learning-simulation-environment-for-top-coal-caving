function d_Ln_pi = d_Ln_pi(i,s, ai, c1k, c2k, sgm1k, sgm2k,PI)
    temp = 0;
    for bi = 1:2
        temp = temp + PI(bi,s,i)* phi(bi, s, c1k,sgm1k, c2k, sgm2k);
    end
    d_Ln_pi = phi(ai, s, c1k, sgm1k, c2k, sgm2k) - temp;
end

