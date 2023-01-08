 clearvars
% clf

[Sx,Sy,Sz] = generateS();%spin matrices 

psi0 = [1;1]/sqrt(2);
rho0 = psi0*psi0';

%% OU parameters

if (~exist('tc','var'))
      tc = 0.0985;
end
if (~exist('delta','var'))
   delta = 2.614;
end

if (~exist('contrast','var'))
    contrast = 1;
end
if (~exist('noise','var'))
    noise = 0.2;
end

T22 = sqrt(2)/delta;

sig = sqrt(2*tc)*delta;
th = 1/tc;

% Trying to relate the coupling coefficient we normally use (as in Sousa)
% to the diffusion coefficient used by OU and Gillespie.
% This is taken from Yonatan and Dima's lablog post (how do we perform
% simulations of noise?)
D = delta^2/(2*tc);


% Sy driving coefficient
if (~exist('gamma','var'))
    gamma = 1.45;  %0.1;
end

%%

dt = 0.0002; % size of time steps
N = 5150;  % number of time steps
t = ((1:N)-1)*dt;


M = [];
Ball = [];

if (~exist('no_dt'))
    no_dt = 0;
end

Rep = 200;
% Repeat time evolution Rep times, to average over random noise instances
for r=1:Rep
t_p1 =
    % why this initial value?
%     B = randn()/sqrt(2*th);
    % try this
    B = randn()*delta/2;
    t_p1
    S = [];
    Brep = [];
    if i>t_p1 | t<N-t_p2
        Ub = expm(-1i*B*Sz*dt - 1i*gamma*Sy*dt); %progressing in time with gamma
        else
        Ub = expm(-1i*B*Sz*dt); %progressing in time without gamma
    end
    rho = rho0;

    % run time evolution
    for i=1:N    

        signal = trace(rho*Sx);
        meas = signal*contrast + randn()*noise;
        
%         S = [S trace(rho*Sx)];
        S = [S meas];

        %% evolve state
        rho = Ub*rho*Ub';

        ex = exp(-th*dt);       
        Brep = [Brep B];
%         B = B*ex+sqrt(delta/th/2*(1-ex^2))*randn();
        B = B*ex+sqrt(D/th/2*(1-ex^2))*randn();
        Ub = expm(-1i*B*Sz*dt - 1i*gamma*Sy*dt);
    end

    M = [M;S];
    Ball = [Ball;Brep];

    if (~no_dt)
        r
    end
end
M = mean(real(M));% is the fitting 

% x2 = 1/2*exp(-delta^2*tc^2*((t/tc)+exp(-(t/tc))-1))+1/2;
c = contrast*exp(-delta^2*tc^2*((t/tc)+exp(-(t/tc))-1)); % the expected signal with avg noise 
figure();
plot(t,M)
hold on
plot(t,c);
hold off
