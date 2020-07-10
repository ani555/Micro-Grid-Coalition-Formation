function tpl=disp_C(S)
% Function to display the coalitions , power transfer in the coalitions and
% total power loss
tpl=0;
for i = 1:numel(S)
    fprintf('Coalition %d :',i);
    disp(S{i});
    [ptp , Qcp] = getOptimalPowerTransferPairs(S{i});
    m = size(ptp,1);
    for k = 1:m
    fprintf('power transfer from %d to %d = %f MW\n\n',ptp(k,1),ptp(k,2),ptp(k,3));
    tpl = tpl+ptp(k,4);
    end
end
%fprintf('Total power loss = %f MW\n',tpl);
end