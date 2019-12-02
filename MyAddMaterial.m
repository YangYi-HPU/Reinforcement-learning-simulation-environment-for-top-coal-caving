function [X,Y,R,T,MAT]=MyAddMaterial(X1,Y1,R1,T1,NumType1,NumType2,ifTrain)
 X=[];
 Y=[];
 R=[];
 MAT=[];
 T=[];
 N=length(X1);
 %% MAT=1 coal ;MAT=2  direct rock;  MAT=4 basic rock ; MAT = 3 check press

for i=1:N
   if i<NumType1
       X=[X,X1(i)];
       Y=[Y,Y1(i)];
       T=[T,T1(i)];
       R=[R,R1(i)];
       MAT=[MAT,1];
       
   elseif i>=NumType1 & i<NumType2
       X=[X,X1(i)];
       Y=[Y,Y1(i)];
       T=[T,T1(i)];
       R=[R,R1(i)];
       MAT=[MAT,2]; 
   else
       X=[X,X1(i)];
       Y=[Y,Y1(i)];
       T=[T,T1(i)];
       R=[R,R1(i)];
       MAT=[MAT,4];
   end
end

if ifTrain ==0
    
    PCoal1 = round(NumType1+50*rand(1,30));
    PCoal2 = round(NumType1+100+50*rand(1,20));
    PCoal3 = round(NumType1+200+50*rand(1,10));

    PRock1 = round(NumType1-100+50*rand(1,20));
    PRock2 = round(100+NumType1*rand(1,60));
else
    PCoal1 = round(NumType1+50*rand(1,40));
    PCoal2 = round(NumType1+100+50*rand(1,30));
    PCoal3 = round(NumType1+200+50*rand(1,10));
     
    PRock1 = round(100+NumType1*rand(1,500));
    PRock2 = round(100+NumType1*rand(1,500));
end


for i=1:length(PCoal1)
    MAT(PCoal1(i))=1;
end

for i=1:length(PCoal2)
    MAT(PCoal2(i))=1;
end

for i=1:length(PCoal3)
    MAT(PCoal3(i))=1;
end

if ifTrain ==0
  for i=1:length(PRock1)
    MAT(PRock1(i))=2;
  end  
end

for i=1:length(PRock2)
    MAT(PRock2(i))=2;
end



for i=1:5
    MAT((i-1)*10+1)=3;
end

MAT(50)=3;


