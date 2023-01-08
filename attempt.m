tc = 0.045:0.001:0.055;
delta = 3.4:0.05:4;
T_ref = 1.6;
n_ref =1.2;

%tc = 0.045;
%delta = 3.5;
%tc = 0.046;
%delta = 3.4;

gaussEqn = 'a*exp(-(x/T)^n))+ d';
%startPoints = [1 1 1 0];

Tm = zeros(length(tc),length(delta));
nm = zeros(length(tc),length(delta));

for i = 1 : length(tc)
    for j = 1 : length(delta)
        [x_sim,y_sim,~] = runOUforSomeTc_and_Delta(tc,delta,0.02,450);
        %f1 = lsqcurvefit(f_fit,[0.1,1,1,0.1],x_sim,y_sim);
           
        f1 = fit(x_sim',y_sim',gaussEqn);
        
        Tm(i,j)=abs(f1.T-T_ref);
        nm(i,j)=abs(f1.n-n_ref);
       
        M(i,j)=abs(f1.T-T_ref)+abs(f1.n-n_ref);
        j
    end
    i
end