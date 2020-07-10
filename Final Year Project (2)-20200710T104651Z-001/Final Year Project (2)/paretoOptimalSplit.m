function isOpt  = paretoOptimalSplit(U , S)
%This function decides whether it is better to form a split S from the union
% U

global n;
Upf = zeros(1,n);
Spf = zeros(1,n);
for i = 1 : numel(U)
    Upf(U(i)) = payOff(U(i),U);
end
for i = 1:numel(S)
    split = S{i};
    for j = 1:numel(split)
        Spf(split(j)) = payOff(split(j),split);
    end
end
isOpt = (sum(Upf(U)<=Spf(U))==numel(U));
            
        
        

