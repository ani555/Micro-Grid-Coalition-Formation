function plotRes()
fid = fopen('D:/Result.txt', 'r');
A=fscanf(fid, '%f %f \n',[2 20]);
fclose(fid);
disp(A);
B = A(:,10:20)';
A= A(:,1:10)';
m = size(A,1);
mg5avg = sum(A)/m;
mg7avg = sum(B)/m;
y = [mg5avg;mg7avg];
x = [5,7];
bar(x,y);
xlabel('No. of microgrids');
ylabel('Power loss in MW')'
legend('Cooperative method','Non Cooperative Method');
title('Power loss for 5 and 7 microgrid structure averaged over 10 readings');
end