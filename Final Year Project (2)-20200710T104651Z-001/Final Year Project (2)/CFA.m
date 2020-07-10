clc; clear all;
global Q;
global R;
global dist;
global U0;
global U1;
global beta;
global n;
% some constants
upperlimit = 316;
lowerlimit = 10;
minp = 1;
maxp = 10;
U0 = 50;
U1 = 22;
beta  = 0.02;

% form the distance matrix randomly
n = input('Enter number of microgrids: ');
pos = minp+(maxp-minp)*rand(n,2);
mac_x = maxp/2;
mac_y = maxp/2;
pos = [[mac_x , mac_y] ; pos];
save('D:/posmat.mat','pos');
d = pdist(pos);
dist = squareform(d);
disp('Distance matrix');
disp(dist);
group = 0:n;
gscatter(pos(:,1),pos(:,2),group);
xlabel('Distance in Km');
ylabel('Distance in Km');

Rpkm = zeros(n+1,n+1) + 0.2;
R = Rpkm.*dist;

% form the Q matrix from a gaussian distribution
G = lowerlimit + (upperlimit-lowerlimit)*rand(1,n);
D = lowerlimit + (upperlimit-lowerlimit)*rand(1,n);
Q = G-D;
save('D:/Qmat.mat','Q');
%fid=fopen('D:/Qdata.txt','a+');
%fprintf(fid,'%f ',Q);
%fprintf(fid,'\n');
%fclose(fid);
disp('Remaining power in each microgrid');
disp(Q);
pause;
% Initially coalition S = [1.....n]
for i = 1:n
    S{i}=i;
end

converged = false;
t = 0;
i=1;
iterations = 200;

tic
% Repeat until convergence
while t<=iterations
i=1;
    %implement merge logic
    while i < numel(S)
    for j = i+1 : numel(S)
        if paretoOptimalUnion(union(S{i},S{j}),{S{i},S{j}})
            U = union(S{i},S{j});
            S{i}=[];
            S{j}=[];
            S=S(~cellfun('isempty',S)); 
            S = {U,S{:}};
            %disp_C(S);
            break;
         end
    end
    % implement split logic
        parts = partitions(S{1});
        parts = {parts{2:end}};
        for p = 1:numel(parts)
            if paretoOptimalSplit(S{1},parts{p})
                for q = 1: numel(parts{p})
                    S = {S{:},parts{p}{q}};
                end
                S{1} = [];
                S=S(~cellfun('isempty',S));
                %disp_C(S);
                break;
            end
        end
        i=i+1;
    end
    t=t+1;
end
etime = toc;
%display coalitions
Ctpl=disp_C(S);
NCtpl = NCPloss();
fprintf('Total power loss by cooperative method = %f MW\n',Ctpl);
fprintf('Total power loss by non-cooperative method = %f MW\n',NCtpl);
fid = fopen('D:/Resultalgo11.txt', 'a+');
fprintf(fid, '%f %f \n',Ctpl,NCtpl);
fclose(fid);
fid=fopen('D:/Timealgo11.txt','a+');
fprintf(fid,'%f\n',etime);
fclose(fid);
group = zeros(1,n+1);
group(1)=0;
for i = 1:numel(S)
    group(S{i}+1)=i;
end

%display coalitions as a graph
gscatter(pos(:,1),pos(:,2),group);
xlabel('Distance in Km');
ylabel('Distance in Km');

                    
                
            
    
