function val = payOff(x, S)
%This function computes the share of total payoff that x should get
%given that it is a part of S

tot = 0;
for i = 1:numel(S)
    tot = tot + utility(S(i));
end
alpha = utility(x)/tot;
val = alpha*(utility(S)-tot)+utility(x);
end