function dxdt = myODE3(t,x,Vr,a1f,a1r,abp,dbp,kbp,ab,db,kb,B1,k1f,k1r);

dxdt = zeros(7,1);

%Constraint for E
%x(1) = 10 - x(2) -x(3)-x(6)-x(7);

%Constraint for B
%x(4) = 2 - x(5) - x(6) - x(7);

dxdt(1) = -Vr*(10 - x(2) -x(3)-x(6)-x(7))+x(7)*kbp+x(6)*kb;

dxdt(2) = Vr*(10-x(2)-x(3)-x(6)-x(7))+a1f*x(3)-a1r*x(2)+x(7)*B1+x(6)*B1;

k1f = k1f .* x(3);

dxdt(3) = -a1f*x(3)+a1r*x(2)-x(3)*(x(5)*a1f+x(4)*a1r)+dbp*x(7)+db*x(6);

dxdt(4) = -ab*(2 - x(5) - x(6) - x(7))*x(3)+kb*x(6)+db*x(6)+B1*x(6)-k1f*(2 - x(5) - x(6) - x(7))+k1r*x(5);
 
dxdt(5) = -abp*x(5)*x(3)+kbp*x(7)+dbp*x(7)+B1*x(7)-k1r*x(5)+k1f*(2 - x(5) - x(6) - x(7));

dxdt(6) = -db*x(6)+ab*x(3)*(2 - x(5) - x(6) - x(7))-kb*x(6)-B1*x(6);

dxdt(7) = -dbp*x(7)+abp*x(3)*x(5)-kbp*x(7)-B1*x(7);



