tc =0.056;
delta = [3:0.1:4];

 lb=[0;0;1;-0.2];
 ub=[1,30,2,0.2];
x = data.time.';
 y = data.signal.referenced;
 y = y/max(y);
 f_fit=@(cf,x_sim)cf(1)*(exp(-x_sim/cf(2)).^cf(3))+cf(4);
f2 = lsqcurvefit(f_fit,[0.1,1,1,0.1],x,y,lb,ub);
Tm = zeros(length(tc),length(delta));
nm = zeros(length(tc),length(delta));


for i = 1:length(tc)
    for j = 1 : length(delta)
            [x_sim,y_sim,~] = runOUforSomeTc_and_Delta(tc,delta,0.02,450); 
         figure(); plot(x_sim,y_sim); 
         f1  = lsqcurvefit(f_fit,[0.1,1,1,0.1],x_sim,y_sim,lb,ub);
         Tm(i,j)=abs(f1(2)-f2(2));
        nm(i,j)=abs(f1(3)-f2(3));
        M(i,j)=sqrt((Tm(i,j))^2+(Tm(i,j))^2);
        z = min(M(i,j));
       
    end
    i
end
