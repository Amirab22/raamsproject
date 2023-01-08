tc = linspace(7,9,10);
delta = linspace(0.15,0.3,11);
for i = 1 : length(tc)
    for j = 1 : length(delta)
        [x_sim,y_sim,~] = runOUforSomeTc_and_Delta(tc(i),delta(j),0.03,3000);
        for k = 1:length(x)
            [~,closestIndex(i)] = min(abs(x_sim-x(k)));
        end
        RSS(i,j) = sum((y_sim(closestIndex)-transpose(y)).^2);
    end
end