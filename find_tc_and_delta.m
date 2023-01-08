tc = 0.059;
delta = 3.6;
%tc = 0.045;
%delta = 3.5;
%tc = 0.046;
%delta = 3.4;
 lb=[0;0;1;-0.2];
 ub=[1,30,2,0.2];
x = data.time.';
 y = data.signal.referenced;
 y = y/max(y);
 f_fit=@(cf,x_sim)cf(1)*(exp(-x_sim/cf(2)).^cf(3))+cf(4);
f2 = lsqcurvefit(f_fit,[ 0.107514126547675,0.263879505112484,0.535559722207305, 0.00207767149867177],x,y,lb,ub);
 plot(x,f_fit([f2],x),'m','LineWidth',1);
 hold on ;
 plot(x,y);
T_ref = f2(2);
n_ref =f2(3);
f_fit=@(cf,x_data)cf(1)*(exp(-x_data/cf(2)).^cf(3))+cf(4);

Tm = zeros(length(tc),length(delta));
nm = zeros(length(tc),length(delta));


for i = 1 : length(tc)
    for j = 1 : length(delta)
        figure()
        [x_sim,y_sim,~] = runOUforSomeTc_and_Delta(tc(i),delta(j),0.002,500);    
         f1  = lsqcurvefit(f_fit,[ 0.107514126547675,0.263879505112484,0.535559722207305, 0.00207767149867177],x_sim,y_sim,lb,ub);
          plot(x_sim,f_fit([f1],x_sim),'m','LineWidth',1);
          hold on;
           plot(x_sim,y_sim);

         Tm(i,j)=abs(f1(2)-T_ref);
        nm(i,j)=abs(f1(3)-n_ref);
       M(i,j)=sqrt((Tm(i,j)).^2+(nm(i,j)).^2);
        j
    end
    i
end