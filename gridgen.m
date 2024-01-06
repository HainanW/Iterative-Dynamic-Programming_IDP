function  [out1,out2,out3,out4] = gridgen(ru1,ru2,ru3,ru4,...
    u1opt_last,u2opt_last,u3opt_last,u4opt_last,ubounds,N,P)

u1_lb = ubounds(1,1);
u2_lb = ubounds(1,2);
u3_lb = ubounds(1,3);
u4_lb = ubounds(1,4);
u1_ub = ubounds(2,1);
u2_ub = ubounds(2,2);
u3_ub = ubounds(2,3);
u4_ub = ubounds(2,4);
u1_grid = zeros(N,P);
u2_grid = zeros(N,P);
u3_grid = zeros(N,P);
u4_grid = zeros(N,P);
for counter1 = 1: P
    if u1opt_last(counter1)-ru1>u1_lb && u1opt_last(counter1)+ru1>u1_ub
        u1_grid(1,counter1) = u1opt_last(counter1) - ru1;
        u1_grid(2,counter1) = u1opt_last(counter1) - ru1/2;
        u1_grid(3,counter1) = u1opt_last(counter1);
        u1_grid(4,counter1) = (u1opt_last(counter1)+u1_ub)/2;
        u1_grid(5,counter1) = u1_ub;
    elseif u1opt_last(counter1)-ru1>u1_lb && u1opt_last(counter1)+ru1<=u1_ub
        u1_grid(1,counter1) = u1opt_last(counter1) - ru1;
        u1_grid(2,counter1) = u1opt_last(counter1) - ru1/2;
        u1_grid(3,counter1) = u1opt_last(counter1);
        u1_grid(4,counter1) = u1opt_last(counter1) + ru1/2;
        u1_grid(5,counter1) = u1opt_last(counter1) + ru1;
    elseif u1opt_last(counter1)-ru1<=u1_lb && u1opt_last(counter1)+ru1>u1_ub
        u1_grid(1,counter1) = u1_lb;
        u1_grid(2,counter1) = (u1opt_last(counter1) + u1_lb)/2;
        u1_grid(3,counter1) = u1opt_last(counter1);
        u1_grid(4,counter1) = (u1opt_last(counter1)+u1_ub)/2;
        u1_grid(5,counter1) = u1_ub;
    else % uopt_last(counter1)-ru<=u_lb && uopt_last(counter1)+ru<=u_lb
        u1_grid(1,counter1) = u1_lb;
        u1_grid(2,counter1) = (u1opt_last(counter1) + u1_lb)/2;
        u1_grid(3,counter1) = u1opt_last(counter1);
        u1_grid(4,counter1) = u1opt_last(counter1) + ru1/2;
        u1_grid(5,counter1) = u1opt_last(counter1) + ru1;
    end
end

for counter1 = 1: P
    if u2opt_last(counter1)-ru2>u2_lb && u2opt_last(counter1)+ru2>u2_ub
        u2_grid(1,counter1) = u2opt_last(counter1) - ru2;
        u2_grid(2,counter1) = u2opt_last(counter1) - ru2/2;
        u2_grid(3,counter1) = u2opt_last(counter1);
        u2_grid(4,counter1) = (u2opt_last(counter1)+u2_ub)/2;
        u2_grid(5,counter1) = u2_ub;
    elseif u2opt_last(counter1)-ru2>u2_lb && u2opt_last(counter1)+ru2<=u2_ub
        u2_grid(1,counter1) = u2opt_last(counter1) - ru2;
        u2_grid(2,counter1) = u2opt_last(counter1) - ru2/2;
        u2_grid(3,counter1) = u2opt_last(counter1);
        u2_grid(4,counter1) = u2opt_last(counter1) + ru2/2;
        u2_grid(5,counter1) = u2opt_last(counter1) + ru2;
    elseif u2opt_last(counter1)-ru2<=u2_lb && u2opt_last(counter1)+ru2>u2_ub
        u2_grid(1,counter1) = u2_lb;
        u2_grid(2,counter1) = (u2opt_last(counter1) + u2_lb)/2;
        u2_grid(3,counter1) = u2opt_last(counter1);
        u2_grid(4,counter1) = (u2opt_last(counter1) + u2_ub)/2;
        u2_grid(5,counter1) = u2_ub;
    else % uopt_last(counter1)-ru<=u_lb && uopt_last(counter1)+ru<=u_lb
        u2_grid(1,counter1) = u2_lb;
        u2_grid(2,counter1) = (u2opt_last(counter1) + u2_lb)/2;
        u2_grid(3,counter1) = u2opt_last(counter1);
        u2_grid(4,counter1) = u2opt_last(counter1) + ru2/2;
        u2_grid(5,counter1) = u2opt_last(counter1) + ru2;
    end
end

for counter1 = 1: P
    if u3opt_last(counter1)-ru3>u3_lb && u3opt_last(counter1)+ru3>u3_ub
        u3_grid(1,counter1) = u3opt_last(counter1) - ru3;
        u3_grid(2,counter1) = u3opt_last(counter1) - ru3/2;
        u3_grid(3,counter1) = u3opt_last(counter1);
        u3_grid(4,counter1) = (u3opt_last(counter1)+u3_ub)/2;
        u3_grid(5,counter1) = u3_ub;
    elseif u3opt_last(counter1)-ru3>u3_lb && u3opt_last(counter1)+ru3<=u3_ub
        u3_grid(1,counter1) = u3opt_last(counter1) - ru3;
        u3_grid(2,counter1) = u3opt_last(counter1) - ru3/2;
        u3_grid(3,counter1) = u3opt_last(counter1);
        u3_grid(4,counter1) = u3opt_last(counter1) + ru3/2;
        u3_grid(5,counter1) = u3opt_last(counter1) + ru3;
    elseif u3opt_last(counter1)-ru3<=u3_lb && u3opt_last(counter1)+ru3>u3_ub
        u3_grid(1,counter1) = u3_lb;
        u3_grid(2,counter1) = (u3opt_last(counter1) + u3_lb)/2;
        u3_grid(3,counter1) = u3opt_last(counter1);
        u3_grid(4,counter1) = (u3opt_last(counter1) + u3_ub)/2;
        u3_grid(5,counter1) = u3_ub;
    else % uopt_last(counter1)-ru<=u_lb && uopt_last(counter1)+ru<=u_lb
        u3_grid(1,counter1) = u3_lb;
        u3_grid(2,counter1) = (u3opt_last(counter1) + u3_lb)/2;
        u3_grid(3,counter1) = u3opt_last(counter1);
        u3_grid(4,counter1) = u3opt_last(counter1) + ru3/2;
        u3_grid(5,counter1) = u3opt_last(counter1) + ru3;
    end
end

for counter1 = 1: P
    if u4opt_last(counter1)-ru4>u4_lb && u4opt_last(counter1)+ru4>u4_ub
        u4_grid(1,counter1) = u4opt_last(counter1) - ru4;
        u4_grid(2,counter1) = u4opt_last(counter1) - ru4/2;
        u4_grid(3,counter1) = u4opt_last(counter1);
        u4_grid(4,counter1) = (u4opt_last(counter1)+u4_ub)/2;
        u4_grid(5,counter1) = u4_ub;
    elseif u4opt_last(counter1)-ru4>u4_lb && u4opt_last(counter1)+ru4<=u4_ub
        u4_grid(1,counter1) = u4opt_last(counter1) - ru4;
        u4_grid(2,counter1) = u4opt_last(counter1) - ru4/2;
        u4_grid(3,counter1) = u4opt_last(counter1);
        u4_grid(4,counter1) = u4opt_last(counter1) + ru4/2;
        u4_grid(5,counter1) = u4opt_last(counter1) + ru4;
    elseif u4opt_last(counter1)-ru4<=u4_lb && u4opt_last(counter1)+ru4>u4_ub
        u4_grid(1,counter1) = u4_lb;
        u4_grid(2,counter1) = (u4opt_last(counter1) + u4_lb)/2;
        u4_grid(3,counter1) = u4opt_last(counter1);
        u4_grid(4,counter1) = (u4opt_last(counter1)+u4_ub)/2;
        u4_grid(5,counter1) = u4_ub;
    else % uopt_last(counter1)-ru<=u_lb && uopt_last(counter1)+ru<=u_lb
        u4_grid(1,counter1) = u4_lb;
        u4_grid(2,counter1) = (u4opt_last(counter1) + u4_lb)/2;
        u4_grid(3,counter1) = u4opt_last(counter1);
        u4_grid(4,counter1) = u4opt_last(counter1) + ru4/2;
        u4_grid(5,counter1) = u4opt_last(counter1) + ru4;
    end
end 
out1 = u1_grid;
out2 = u2_grid;
out3 = u3_grid;
out4 = u4_grid;
end 