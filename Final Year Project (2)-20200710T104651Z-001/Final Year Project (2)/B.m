function Bij = B(i , j, q)
% This function computes power transfer between two pairs of microgrids i and j
% q is the vector containing the remaining power

global beta U0 U1 R available;
b=0;
U=U1;
Bij = 0;
if i==0
    b = beta;
    U = U0; 
end
D=(1-b)^2 + 4*(R(i+1,j+1)*q(j))/(U*U);
%disp('inside Bij')
%disp(i);
%disp(j);
%disp(D);
if i==0
    if(q(j)>0)
        Bij = q(j);
        %disp('case1');
    else
        %disp('case2');
        r1 = (1-b - sqrt(D))*(U*U)/(2.0*R(i+1,j+1));
        r2 = (1-b + sqrt(D))*(U*U)/(2.0*R(i+1,j+1));
        if r1>0
            Bij = r1;
        else
            Bij = r2;
        end
        %fprintf('Bij = %f U = %f R=%f b = %f\n',Bij,U,R(i+1,j+1),b);
    end     
elseif (i~=0)
    if abs(q(i))> abs(q(j))
        %disp('case3');
        r1 = (1-b - sqrt(D))*(U*U)/(2.0*R(i+1,j+1));
        r2 = (1-b + sqrt(D))*(U*U)/(2.0*R(i+1,j+1));
        if r1>0
        Bij = r1;
        else
        Bij = r2;
        end
        %fprintf('Bij = %f U = %f R=%f b = %f\n',Bij,U,R(i+1,j+1),b);
    else
        %disp('case4');
        max_P =((1-b)*U*U)/(2*R(i+1,j+1));
        Bij = min(q(i),max_P);
        if Bij == max_P
            available(i,j)=0;
            available(j,i)=0;
        end
        %fprintf('Bij = %f U = %f R=%f b = %f\n',Bij,U,R(i+1,j+1),b);
    end
end
if D<0.0
    if i==0
        tmp=i;
        i=j;
        j=tmp;
    end
    %disp('case5');
    max_P =((1-b)*U*U)/(2*R(i+1,j+1));
    Bij=  min(abs(q(i)), max_P);
    if Bij == max_P && i~=0 && j~=0
        available(i,j)=0;
        available(j,i)=0;
    end
    %fprintf('Bij = %f U = %f R=%f b = %f\n',Bij,U,R(i+1,j+1),b);
end
end
    