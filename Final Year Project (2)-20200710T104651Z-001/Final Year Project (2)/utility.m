function v = utility(S)
% This function computes the utility given a coalition S

[ptp ,Qcp] = getOptimalPowerTransferPairs(S);
v=0;
for i = 1:size(ptp,1)
    I = ptp(i,1);
    J = ptp(i,2);
    v = v + ptp(i,4);
end
v = -v;
end
        
        
    
    