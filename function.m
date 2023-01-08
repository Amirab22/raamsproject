function [f1(2),f1(3)] = f1(x_sim,y_sim) 

      f1  = lsqcurvefit(f_fit,[0.1,1,1,0.1],x_sim,y_sim,lb,ub);



end 