mainAddress = 'H:\.shortcut-targets-by-id\0B090sjH0xr55LTE5QXc4ejBWZkU\NV Lab\Control code\Saves\Setup 1\_AutoSave\';
file_name = 'RamseyWithLaser_20221129_120958';
loaded = load([mainAddress,file_name]);
data = extractDataRamsey(loaded.myStruct);
[xData, yData] = prepareCurveData(data.time, data.signal.referenced/max(data.signal.referenced ));
% Set up fittype and options.
ft = fittype( 'a*exp(-(x/T)^n)', 'independent', 'x', 'dependent', 'y' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display = 'Off';
opts.StartPoint = [0.964888535199277 0.791917660194978 0.957506835434298];
% Fit model to data.
[fitresult,~] = fit( xData, yData, ft, opts );
%%%%%%%
x = linspace(0,10,1000);
y1 = feval(fitresult,x);
contrast = 1;
f = @(tc,delta,x) exp(-delta^2*tc^2*((x/tc)+exp(-(x/tc))-1));
obj_fun = @(params) norm(f(params(1),params(2),x)-y1);
tc_guess = 0.049;
delta_guess = 4.2;
% options = optimset('MaxIter',1000)
sol = fminsearch(obj_fun,[tc_guess,delta_guess]);
plot(x,y1)
hold on
tc_sol = sol(1); delta_sol = sol(2);
plot(x,f(tc_sol ,delta_sol,x),'.')












