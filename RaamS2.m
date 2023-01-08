%% Calculate S2 (based on Uzdin, ArXiv:2112.00546v1, Dec. 2021, p. 6)

% S2 = 3/2*R0 - 2*R1 + 1/2*R2
% where Rk is the fidelity of the state (with respect to the initial state)
% after k repetitions of the "unitary"
% In our case, this could be just some trivial unit evolution ("nothing")
% for a given time dt

% We use the time trace data calculated (simulated) by
% ornsteinUhlenbeckSimulation.m

% time vector is t
% results vector is M

% our cycle unit is dt

R0 = M(1);
S2 = [];
t2 = [];

for k=2:floor(length(t)/2)
    R1 = M(k);
    R2 = M(2*k);
    S2 = [S2 (3/2*R0 - 2*R1 + 1/2*R2)];
    purity_loss =  S2 + S2^2;
    t2 = [t2 t(k)];
end

