%% Run multiple instances of ornsteinUhlenbeckSimulation, along with RaamS2
% scan Sy driving parameters, to check for S2 sensitivity


% Define whether to display the time evolution index or not
no_dt = 1;

% set values for tc and delta

% Markovian
tc = 0.01;
delta = 5;

% non-Markovian
tc = 50;
delta = 2;

% non-Markovian 2
tc = 1;
delta = 3;

% almost Markovian
% tc = 0.1;
% delta = 2;

% values of Sy driving strength to scan
g = [0:0.05:0.5];


%% include experimental parameters
contrast = 0.1;
noise = 0.02;


Mg = [];
S2g = [];

for ig=1:length(g)
    ig
    gamma = g(ig);

    ornsteinUlhenbeckSimulation;
    RaamS2;

    Mg = [Mg;M];
    S2g = [S2g;S2];

end


% save results in file
fname = ['OU_scanSy_tc_' num2str(tc) '_delta_' num2str(delta) '_g_' num2str(g(1)) '_to_' num2str(g(end)) '_contrast_' num2str(contrast) '_noise_' num2str(noise)];
save(fname,'tc','delta','g','Mg','S2g','t','t2','contrast','noise');


% extract decay_rates from S2g/t2
decay_rates = mean(S2g(1:end,100:500)./t2(100:500),2);

% extract decay_rates from log(Mg)./t
decay_rates_M = -mean(log(Mg(:,100:1000))./t(100:1000),2);

% Fit results to power law to check for Markovian vs. non-Markovian
% behavior
subt = t(100:1000);
subt2 = t2(100:500);
S2_power = [];
S2_rate = [];
M_power = [];
M_rate = [];

for ig=1:length(g)
    subS2g = S2g(ig,100:500);
    [cf,gof] = fitS2g_power(subt2,subS2g);
    S2_power = [S2_power cf.b];
    S2_rate = [S2_rate cf.a./contrast];

    subMg = log(Mg(ig,100:1000));
    [cf,gof] = fitMg_power(subt,subMg);
    M_power = [M_power cf.b];
    M_rate = [M_rate -cf.a];
end