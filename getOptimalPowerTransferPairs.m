function [X , Qcp]= getOptimalPowerTransferPairs(S)
% This functions returns all the optimal power transfer pairs X after power
% exchange between buyer and seller microgrids and also between
% macrostation and microgrids. Qcp is a vector of remaining power after
% power exchange
global n Q dist available;
X=[];
Qcp = Q(S);
sidx = find(Qcp>0);
bidx = find(Qcp<0);
Ps = Qcp(sidx);
sidx = S(sidx);
Pb = Qcp(bidx);
bidx = S(bidx);
[~,Sindex] = sort(Ps,'descend');
[~,Bindex] = sort(abs(Pb),'descend');
sidx = sidx(Sindex);
bidx = bidx(Bindex);
%disp(sidx);
%disp(bidx);
Qcp = Q;
available = ones(n,n);
for i = bidx
    while ~(Qcp(i)<=0.001 && Qcp(i)>= - 0.001)
        %disp(Qcp(i));
        nearest_mg = -1;
        min_dist = 10^9;
        for j = sidx
            %fprintf('j= %d Qcp(j)=%d available = %d\n',j,Qcp(j),available(i,j))
            if dist(i+1,j+1)<min_dist && Qcp(j)>0 && available(i,j)
                min_dist = dist(i+1,j+1);
                nearest_mg = j;
            end
        end
        %fprintf('%d -- %d available = %d\n',i,nearest_mg,available(i,j));
        if nearest_mg==-1
            Bij = B(0,i,Qcp);
            %fprintf('power tf bet 0 to %d = %f\n',i,Bij);
            Plij = Ploss(0,i,Qcp);
            Qcp(i) = min(Qcp(i)+Bij-Plij,0);
            X = [X;[0 i Bij Plij]];
            break;
        end
        Bij = B(nearest_mg,i,Qcp);
        Plij = Ploss(nearest_mg,i,Qcp);
        %fprintf('power tf bet %d to %d = %f\n',nearest_mg,i,Bij);
        Qcp(nearest_mg) = Qcp(nearest_mg) - Bij;
        Qcp(i) = min(Qcp(i)+Bij-Plij,0);
        %disp('few things');
        %disp(Bij);
        %disp(Plij);
        %disp(Qcp(i))
        %disp(Qcp(nearest_mg));
        X = [X;[nearest_mg i Bij Plij]];
    end
end
for i = sidx
    if Qcp(i)>0
       Bij = B(0,i,Qcp);
       Plij = Ploss(0,i,Qcp);
       %fprintf('power tf bet %d to 0 = %f\n',i,Bij);
       Qcp(i) = Qcp(i) - Bij;
       X = [X;[i 0 Bij Plij]];
    end
end
end
