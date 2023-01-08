%#to find the optimum value of tc and delta 

mainAddress = 'H:\.shortcut-targets-by-id\0B090sjH0xr55LTE5QXc4ejBWZkU\NV Lab\Control code\Saves\Setup 1\_AutoSave\';
file_name = 'Ramsey_20221128_234308 ';
loaded = load([mainAddress,file_name]);
data = extractDataRamsey(loaded.myStruct);
xData = data.time';
yData= data.signal.referenced;

% Set up fittype and options.
ft = fittype( 'a*exp(-(x/T)^n+c)', 'independent', 'x', 'dependent', 'y' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display = 'Off';
opts.Upper = [Inf, Inf, Inf , Inf];
opts.Lower = [0, 0, -0.1 , 1];
opts.StartPoint = [rand(1),max(yData),0,1]; 

% Fit model to data.
[fitresult,~] = fit( xData, yData, ft, opts );
%%%%%%%
x = linspace(0,10,1000);


y1 = feval(fitresult,x);

tc_guess= 36;
delta_guess = 0.09;
fun = @(x)normFits(x,fitresult);
A = [];
b = [];
Aeq = [];
beq = [];
lb = [0,0];
ub = [50,7];
sol = fmincon(fun,[tc_guess,delta_guess],A,b,Aeq,beq,lb,ub);

% contrast = 1; 

% obj_fun = @(params) norm(f(params(1),params(2),x)-y1); 
% 
% % options = optimset('MaxIter',1000)
% sol = fminsearch(obj_fun,[tc_guess,delta_guess]);

contrast = fitresult.a;

f = @(tc,delta,x) contrast*exp(-delta^2*tc^2*((x/tc)+exp(-(x/tc))-1));
plot(x,y1)
hold on
tc_sol = sol(1); delta_sol = sol(2); 
plot(x,f(tc_sol ,delta_sol,x),'.')