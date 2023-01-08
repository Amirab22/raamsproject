%% To find the optimum gamma by comparing the defference between the frequency of data and simulation  to be minimum 



%mainAddress = 'H:\.shortcut-targets-by-id\0B090sjH0xr55LTE5QXc4ejBWZkU\NV Lab\Control code\Saves\Setup 1\_AutoSave\';
%%mainAddress = 'H:\.shortcut-targets-by-id\0B090sjH0xr55LTE5QXc4ejBWZkU\NV Lab\Control code\Saves\Setup 1\_AutoSave\';
%file_name = 'ExpRaamS3WithLaser_20221201_111332 ';
%loaded = load([mainAddress,file_name]);
%data = extractDataRamsey(loaded.myStruct);
%xData = data.time';
%yData= data.signal.referenced;

% Set up fittype and options.
%ft = fittype( 'a*exp(-(x/T)^n)*cos(2*pi*f*x+p)+dc', 'independent', 'x', 'dependent', 'y' );
%opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
%opts.Display = 'Off';
%opts.Lower = [0 -Inf -0.1 0 1 -4];
%opts.StartPoint = [rand(1),max(yData),0,rand(1),1,rand(1)]; 
%opts.Upper = [Inf 1 Inf Inf 3 4]; 

% Fit model to data.
%[fitresult,~] = fit( xData, yData, ft, opts );
%%%%%%%
gamma = [1.45,2.2, 3.3 ,4.15];
DB_of_WF = [-12, -8, -5, -3];
tc = 36.1635;
delta = 0.09;
simulation_data = struct;
figure(1)
figure(2)
for i = 1:length(gamma)
  [x_sim,y_sim] = runOUforSomeTc_and_Delta(tc,delta,gamma(i), 0.002,515); 
 % [fitresult1,~] = fit( x_sim', y_sim', ft, opts );
% dist(i) =abs(fitresult.f - fitresult1.f);
  figure(1)
  plot(x_sim,y_sim);hold on;
  simulation_data(i).WF_db = DB_of_WF(i);
  simulation_data(i).gamma = gamma(i);
  
  simulation_data(i).x = x_sim; simulation_data(i).y = y_sim;
  
  [T,V] = calculateS2(x_sim,y_sim);
  simulation_data(i).S2_time = T; simulation_data(i).S2_value = V;
  figure(2)
  plot(T,V); hold on; 
end 
%[M,I] = min(dist);
%optimum_gamma = gamma(I);
