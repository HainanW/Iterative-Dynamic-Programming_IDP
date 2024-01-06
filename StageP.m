function [res1,res2,res3,res4] = StageP(u1_set,u2_set,u3_set,u4_set,...
                   in5,R,N,P,optODE) %

% in1 = u1_set  = R x 1;
% in2 = u2_set  = R x 1;
% in3 = u3_set
% in4 = u4_set 
% in5 = g_rec0(:,P-1)
% in6 = R
% in7 = N
% in8 = P
% in9 = optODE


allu1 = zeros(N,P);
allu2 = zeros(N,P);
allu3 = zeros(N,P);
allu4 = zeros(N,P);

ts = linspace(0,0.2,P+1);
tspan = ts(P:P+1);
for k = 1 : N
    obj = zeros(1,R);
    for j = 1 : R
        x0 = in5{k,1}';
        [~,res_y] = ode45(@(t,y) dyneqn1(t,y,u1_set(j),...
           u2_set(j),u3_set(j),u4_set(j)),tspan,x0,optODE);
        res_lastrow = res_y(end,:);
        obj(j) = res_lastrow(8);
    end
    [~,a] = max(obj);
    allu1(k,P) = u1_set(a);
    allu2(k,P) = u2_set(a);
    allu3(k,P) = u3_set(a);
    allu4(k,P) = u4_set(a);
end

res1 = allu1;
res2 = allu2;
res3 = allu3;
res4 = allu4;

end