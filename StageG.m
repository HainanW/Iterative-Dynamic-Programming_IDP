function [res1,res2,res3,res4] = StageG(in1,in2,in3,in4,...
                in5,in6,in7,in8,in9,in10,R,N,P,optODE)
% in1 = i % 7 
% in2 = u1_set ;
% in3 = u2_set ;
% in4 = u3_set ;
% in5 = u4_set ;
% in6 = allu1  ;
% in7 = allu2  ; 
% in8 = allu3  ;
% in9 = allu4  ; 
% in10 = g_rec0(:,[7 8]);
% in11 = R
% in12 = N 
% in13 = P
% in14 = optODE

allu1 = zeros(N,P);
allu2 = zeros(N,P);
allu3 = zeros(N,P);
allu4 = zeros(N,P);
ts = linspace(0,0.2,P+1);

for k = 1 : N
    ind = zeros(1,R);
    obj = zeros(1,R);
    for j = 1 : R
        x0 = in10{k,1}';
        [~,res_y] = ode45(@(t,y) dyneqn1(t,y,in2(j),in3(j),...
        in4(j),in5(j)),[ts(in1) ts(in1+1)],x0,optODE);
        x0 = res_y(end,:)';
        xreal = res_y(end,:); 
        dis0 = zeros(1,N);
        for m = 1:N
            dis0(m) = norm(xreal - in10{m,2});
        end
        [~,ind(j)] = min(dis0);
        for counter = (in1+1) : P
            [~,res_y] = ode45(@(t,y) dyneqn1(t,y,in6(ind(j),counter),...
            in7(ind(j),counter),in8(ind(j),counter),in9(ind(j),counter)),...
            [ts(counter) ts(counter+1)],x0,optODE);
            x0 = res_y(end,:)';
        end 
        xlastrow = res_y(end,:);
        obj(j) = xlastrow(8);
    end
    
    [~,a] = max(obj);
    
    allu1(k,in1) = in2(a);
    allu2(k,in1) = in3(a);
    allu3(k,in1) = in4(a);
    allu4(k,in1) = in5(a);
    allu1(k,in1+1:P)= in6(ind(a),in1+1:P);
    allu2(k,in1+1:P)= in7(ind(a),in1+1:P);
    allu3(k,in1+1:P)= in8(ind(a),in1+1:P);
    allu4(k,in1+1:P)= in9(ind(a),in1+1:P);
    
end

res1 = allu1;
res2 = allu2;
res3 = allu3;
res4 = allu4;

end