function NCtpl = NCPloss()
global Q;
NCtpl=0;
for i = 1:length(Q)
    NCtpl = NCtpl + Ploss(0,i,Q); 
end
end
