function [fitresult, gof] = fitS2g_power(subt2, subS2g)
%CREATEFIT(SUBT2,SUBS2G1)
%  Create a fit.
%
%  Data for 'untitled fit 1' fit:
%      X Input : subt2
%      Y Output: subS2g1
%  Output:
%      fitresult : a fit object representing the fit.
%      gof : structure with goodness-of fit info.
%
%  See also FIT, CFIT, SFIT.

%  Auto-generated by MATLAB on 01-Sep-2022 13:51:51


%% Fit: 'untitled fit 1'.
[xData, yData] = prepareCurveData( subt2, subS2g );

% Set up fittype and options.
ft = fittype( 'power1' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display = 'Off';
opts.StartPoint = [0.387720865371415 1.19272308982405];

% Fit model to data.
[fitresult, gof] = fit( xData, yData, ft, opts );

% 
% % Plot fit with data.
% figure( 'Name', 'untitled fit 1' );
% h = plot( fitresult, xData, yData );
% legend( h, 'subS2g1 vs. subt2', 'untitled fit 1', 'Location', 'NorthEast', 'Interpreter', 'none' );
% % Label axes
% xlabel( 'subt2', 'Interpreter', 'none' );
% ylabel( 'subS2g1', 'Interpreter', 'none' );
% grid on

