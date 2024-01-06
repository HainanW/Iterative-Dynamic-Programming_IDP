function [res1,res2,res3,res4] = StageI(in1,in2,in3,...
                in4,in5,in6,in7,in8,x0,in10,R,N,P,optODE)
% in1 = u1_set ;
% in2 = u2_set ;
% in3 = u3_set  ;
% in4 = u4_set  ;
% in5 = allu1 ; 
% in6 = allu2 ;
% in7 = allu3 ;
% in8 = allu4 ;
% in9 = x0    ; 

ind = zeros(1,R);
obj = zeros(1,R);

ts = linspace(0,0.2,P+1);

for j = 1 : R
    
    z0 = x0;
    [~,res_y] = ode45(@(t,y) dyneqn1(t,y,in1(j),in2(j),in3(j),in4(j)),...
        [ts(1) ts(2)],z0,optODE);
    z0 = res_y(end,:)';
    xreal = res_y(end,:);
    dis0 = zeros(1,N);
    for m = 1:N
        dis0(m) = norm(xreal - in10{m,1});
    end
    [~,ind(j)] = min(dis0);
    for k = 2 : P
        [~,res_y] = ode45(@(t,y) dyneqn1(t,y,in5(ind(j),k),...
            in6(ind(j),k),in7(ind(j),k),in8(ind(j),k)),...
            [ts(k) ts(k+1)],z0,optODE);
        z0 = res_y(end,:)';
    end
    res_lastrow = res_y(end,:);
    obj(j) = res_lastrow(8);
end

[~,a] = max(obj);
u1_opt(1,1) = in1(a);
u2_opt(1,1) = in2(a);
u3_opt(1,1) = in3(a);
u4_opt(1,1) = in4(a);

u1_opt(1,2:P)= in5(ind(a),2:P);
u2_opt(1,2:P)= in6(ind(a),2:P);
u3_opt(1,2:P)= in7(ind(a),2:P);
u4_opt(1,2:P)= in8(ind(a),2:P);

res1 = u1_opt;
res2 = u2_opt;
res3 = u3_opt;
res4 = u4_opt;

end