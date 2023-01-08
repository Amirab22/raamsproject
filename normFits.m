function [dist] = normFits (x, fitresult)

t = 0:0.01:10;
tc = x(1);
delta = x(2);
f1 = exp(-delta^2*tc^2*((t/tc)+exp(-(t/tc))-1));

% Set up fittype and options.
ft = fittype( 'exp(-(x/T)^n+c)', 'independent', 'x', 'dependent', 'y' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display = 'Off';
opts.StartPoint = [1 0 2];
opts.Upper = [2 0.2 3];
opts.Lower = [0.1 -0.2 1];

% Fit model to data.
[fitresult1,~] = fit( t', f1', ft, opts );



dist = norm([(fitresult.T - fitresult1.T) (fitresult.n - fitresult1.n)]);


