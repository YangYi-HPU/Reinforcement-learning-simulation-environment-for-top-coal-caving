function show_reulst(Qvalue, episode,LoopCount,action,State)

    fprintf('--------episod=%d, loop=%d  ---------\n',episode,LoopCount); 
    fprintf('State  ')
    for i =1:5
        fprintf('%d   ',State(i));
    end
    fprintf('\nAction ')
    for i =1:5
        fprintf('%d   ',action(i));
    end
    fprintf('\n')
    for iQ = 1:12
        fprintf('%3.3f   ',Qvalue(1,iQ));                
    end
    fprintf('\n');    
    for iQ = 1:12
        fprintf('%3.3f   ',Qvalue(2,iQ));                
    end
    fprintf('\n\n');
end
        