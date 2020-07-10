function pl = Ploss(I, J,q)
% This function computes the power loss due power transfer between two
% microgrids i and j

global U1 U0 R beta;
pl=0;
Bij = B(I,J,q);
if I~=0
    pl = (R(I+1,J+1)*Bij*Bij)/(U1*U1);
else
    pl = (R(I+1,J+1)*Bij*Bij)/(U0*U0) + beta*Bij;
end