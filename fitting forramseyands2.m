
x = data.time.';
 y = data.signal.referenced;
%%% fitting for ramsey 
[xData, yData] = prepareCurveData( t, M );

% Set up fittype and options.
ft = fittype( 'a*exp(-(x/T)^n)+d', 'independent', 'x', 'dependent', 'y' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display = 'Off';
opts.Lower = [0 -Inf -Inf 1];
opts.StartPoint = [0.0697639860741081 0.262777926507577 0.630670242512203 0.69945860145395];
opts.Upper = [Inf Inf Inf 2];

% Fit model to data.
[fitresult{1}, gof(1)] = fit( xData, yData, ft, opts );