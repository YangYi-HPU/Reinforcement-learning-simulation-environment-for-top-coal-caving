function [X1,Y1,X2,Y2] = MySetWall(data)
    
    Bin = dec2bin(data);
    
    X1=[];       
    X2=[];
    Y1=[];
    Y2=[];
    
    for i = 2: 6
         
        if Bin(i)=='1'
            X1 = [X1,(i-2)*10,   (i-2)*10+1];
            Y1 = [Y1, 60,         60       ];
            X2 = [X2,(i-2)*10+1,  (i-1)*10];
            Y2 =[Y2, 60,  60];
        else
            X1 = [X1,(i-2)*10];
            Y1 = [Y1, 60     ];
            X2 = [X2,(i-2)*10+1];
            Y2 =[Y2, 60];
            
        end
    end
    

    X1=[X1, 49,  49, 0  ];
    Y1=[Y1, 60,  60, 0 ];
    X2=[X2, 50, 49, 0 ];
    Y2=[Y2, 60,  61, 100];
    
    for i=1:5
        X1=[X1,  (i-1)*10,  (i-1)*10+1];
        Y1=[Y1,  60,        60];
        X2=[X2,  (i-1)*10,  (i-1)*10+1];
        Y2=[Y2,  61,        61];
    end
    
    X1=[X1,    50,  0 ];
    Y1=[Y1,    0,    0 ];
    X2=[X2,    50,  50];
    Y2=[Y2,    100,  0];   

end