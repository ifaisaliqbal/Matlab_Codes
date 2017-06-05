clc;
clear;
close all;
x = 100*rand(1,500)-50;
y = 100*rand(1,500)-50;
ind = 1;
for i = 1:length(x)
   if((x(1,i)+y(1,i))<0)
       xn(1,ind) = x(1,i);
       yn(1,ind) = y(1,i);
       sig(ind)=-1;
       scatter(xn(1,ind),yn(1,ind));
       ind = ind+1;
       hold on;
       
   end
   
   if((x(1,i)+y(1,i))>10)
       xn(1,ind) = x(1,i);
       yn(1,ind) = y(1,i);
       sig(ind)=1;
       scatter(xn(1,ind),yn(1,ind));
       ind = ind+1;
       
   end
end
clear x;
clear y;
scatter(xn,yn);
ind=1;

for i = 1:length(xn)
d{1,i}=[xn(1,i) yn(1,i)];    
end

for i = 1:length(xn)
    for j =1:length(yn)
    s(i,j)=(sig(i)*d{1,i})*(sig(j)*d{1,j}');
    end
end
ss = size(xn,2);
f = ones(1,ss);
f = f*-1;
H=s;
Aeq = sig;
beq = 0;
ub = ones(1,ss);
ub = ub*Inf;
lb = zeros(1,ss);
[alpha,fval,exitflag,output,lambda] = quadprog(H,f,[],[],Aeq,beq,lb,ub);
beta = 0;
for i = 1:size(ss)
   beta = beta + alpha(i)* sig(i)* [xn(i) yn(i)];
end
hold on;
comp = find(alpha>0.0001)
for i = 1:size(comp)
   scatter(xn(1,comp),yn(1,comp),'r+') 
end
