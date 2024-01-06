function out = gridvector(u1grid,u2grid,u3grid,u4grid,x0,N,P,optODE)

tspan = linspace(0,0.2,P+1);
g_rec0 = cell(N,P);
for i = 1 : N
    u1in = u1grid(i,:);
    u2in = u2grid(i,:);
    u3in = u3grid(i,:);
    u4in = u4grid(i,:);
    z0 = x0; 
    for ks = 1 : P
        [~,res_y] = ode45(@(t,y)dyneqn1(t,y,u1in(ks),u2in(ks),...
            u3in(ks),u4in(ks)),[tspan(ks),tspan(ks+1)],z0,optODE);
        z0 = res_y(end,:)'; % 8x1 
        g_rec0{i,ks} = res_y(end,:);
    end
end
out = g_rec0;
end