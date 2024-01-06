%% Perform IDP algorithm on selected problem
% Page 105, 6.2.2
clear all
clc
%% Part1. Specify algorithm parameters

N =  5;      % N: number of grid points, must be a odd number
P = 11;      % P: number of time steps
R = 30;      % R: random candidates of controls
gamma = 0.85; % gamma: region contraction factor
eta = 0.80;   %   eta: region restoration factor
optODE = []; %  optODE = odeset( 'RelTol', 1e-6, 'AbsTol', 1e-6);
N_pass = 30; % Number of passes
N_iter = 30; % Number of iterations in each pass
x0 = [0.1883 0.2507 0.0467 0.0899 0.1804 0.1394 0.1046 0]'; % Initial point for ODE

%% Part2.
% Define initial values for four controls
% Define each time steps and initial region sizes of controls

u1_0 = 10*ones(1,P); % Initial control parameters (pars) for each stage
u2_0 =  3*ones(1,P);
u3_0 =  2*ones(1,P);
u4_0 = 10*ones(1,P);

ru1_0 = 10; % Initial control region size for u1
ru2_0 =  3; % Initial control region size for u2
ru3_0 =  2; % Initial control region size for u3
ru4_0 = 10; % Initial control region size for u4


ubounds = [ 0 0 0 0;  20 6 4 20];
u1_lb = 0;
u1_ub = 20;
u2_lb = 0;
u2_ub = 6;
u3_lb = 0;
u3_ub = 4;
u4_lb = 0;
u4_ub = 20;

% Define
u1opt_rec(1,:) = u1_0;
u2opt_rec(1,:) = u2_0;
u3opt_rec(1,:) = u3_0;
u4opt_rec(1,:) = u4_0;

u1optrec_pass = zeros(N_pass+1,P);
u2optrec_pass = zeros(N_pass+1,P);
u3optrec_pass = zeros(N_pass+1,P);
u4optrec_pass = zeros(N_pass+1,P);

u1optrec_pass(1,:) = u1_0;
u2optrec_pass(1,:) = u2_0;
u3optrec_pass(1,:) = u3_0;
u4optrec_pass(1,:) = u4_0;
%% Part3. % N_pass passes in total, each pass has N_iter iterations
for j = 1: N_pass %
    tic
    ru1 = eta^(j-1)*ru1_0;
    ru2 = eta^(j-1)*ru2_0;
    ru3 = eta^(j-1)*ru3_0;
    ru4 = eta^(j-1)*ru4_0;

    u1opt_rec = [];   % Clear memory of u1opt_rec
    u2opt_rec = [];
    u3opt_rec = [];
    u4opt_rec = [];
    u1opt_rec(1,:) = u1optrec_pass(j,:);% u1opt_rec_lastrow;    % Make the 1st row of uopt_rec the last optimal u
    u2opt_rec(1,:) = u2optrec_pass(j,:);% u2opt_rec_lastrow;    % Make the 1st row of vopt_rec the last optimal v
    u3opt_rec(1,:) = u3optrec_pass(j,:);% u3opt_rec_lastrow;    % Make the 1st row of uopt_rec the last optimal u
    u4opt_rec(1,:) = u4optrec_pass(j,:);% u4opt_rec_lastrow;
    for i = 1 : N_iter % 30 % # of iteration in each pass
        ru1 = gamma^(i-1)*ru1;
        ru2 = gamma^(i-1)*ru2;
        ru3 = gamma^(i-1)*ru3;
        ru4 = gamma^(i-1)*ru4;
        u1opt_last = u1opt_rec(i,:);
        u2opt_last = u2opt_rec(i,:);
        u3opt_last = u3opt_rec(i,:);
        u4opt_last = u4opt_rec(i,:);
        [u1grid,u2grid,u3grid,u4grid] = gridgen(ru1,ru2,ru3,ru4,...
            u1opt_last,u2opt_last,u3opt_last,u4opt_last,ubounds,N,P);
        g_rec0 = gridvector(u1grid,u2grid,u3grid,u4grid,x0,N,P,optODE);

        %% Stage 10
        for ind = P:-1:1
            if ind == P % The optimization runs on the Pth (last stage) first
                u1_min = max(u1_lb,(u1opt_last(P) - ru1));
                u1_max = min((u1opt_last(P) + ru1),u1_ub);
                u2_min = max(u2_lb,(u2opt_last(P) - ru2));
                u2_max = min((u2opt_last(P) + ru2),u2_ub);
                u3_min = max(u3_lb,(u3opt_last(P) - ru3));
                u3_max = min((u3opt_last(P) + ru3),u3_ub);
                u4_min = max(u4_lb,(u4opt_last(P) - ru4));
                u4_max = min((u4opt_last(P) + ru4),u4_ub);
                u1_set = u1_min + (u1_max-u1_min)*rand(R,1);
                u2_set = u2_min + (u2_max-u2_min)*rand(R,1);
                u3_set = u3_min + (u3_max-u3_min)*rand(R,1);
                u4_set = u4_min + (u4_max-u4_min)*rand(R,1);
                [allu1,allu2,allu3,allu4] = StageP(u1_set,u2_set,u3_set,...
                    u4_set,g_rec0(:,P-1),R,N,P,optODE);
            elseif (ind ~= 1) && (ind ~= P)
                % General stages except initial and the first stage,
                % i.e., i == P-1:-1:2
                u1_min = max(u1_lb,(u1opt_last(ind) - ru1));
                u1_max = min((u1opt_last(ind) + ru1),u1_ub);
                u2_min = max(u2_lb,(u2opt_last(ind) - ru2));
                u2_max = min((u2opt_last(ind) + ru2),u2_ub);
                u3_min = max(u3_lb,(u3opt_last(ind) - ru3));
                u3_max = min((u3opt_last(ind) + ru3),u3_ub);
                u4_min = max(u4_lb,(u4opt_last(ind) - ru4));
                u4_max = min((u4opt_last(ind) + ru4),u4_ub);
                u1_set = u1_min + (u1_max-u1_min)*rand(R,1);
                u2_set = u2_min + (u2_max-u2_min)*rand(R,1);
                u3_set = u3_min + (u3_max-u3_min)*rand(R,1);
                u4_set = u4_min + (u4_max-u4_min)*rand(R,1);
                [allu1,allu2,allu3,allu4] = StageG(ind,u1_set,u2_set,u3_set,...
                    u4_set,allu1,allu2,allu3,allu4,g_rec0(:,[ind-1 ind]),R,N,P,optODE);
            else % The first stage will be optimizaed at last
                u1_min = max(u1_lb,(u1opt_last(1) - ru1));
                u1_max = min((u1opt_last(1) + ru1),u1_ub);
                u2_min = max(u2_lb,(u2opt_last(1) - ru2));
                u2_max = min((u2opt_last(1) + ru2),u2_ub);
                u3_min = max(u3_lb,(u3opt_last(1) - ru3));
                u3_max = min((u3opt_last(1) + ru3),u3_ub);
                u4_min = max(u4_lb,(u4opt_last(1) - ru4));
                u4_max = min((u4opt_last(1) + ru4),u4_ub);
                u1_set = u1_min + (u1_max-u1_min)*rand(R,1);
                u2_set = u2_min + (u2_max-u2_min)*rand(R,1);
                u3_set = u3_min + (u3_max-u3_min)*rand(R,1);
                u4_set = u4_min + (u4_max-u4_min)*rand(R,1);
                [u1_opt,u2_opt,u3_opt,u4_opt] = StageI(u1_set,u2_set,u3_set,...
                    u4_set,allu1,allu2,allu3,allu4,x0,g_rec0(:,1),R,N,P,optODE);
            end
        end
        %% End of the 1st time stage
        u1opt_rec(i+1,:) = u1_opt;
        u2opt_rec(i+1,:) = u2_opt;
        u3opt_rec(i+1,:) = u3_opt;
        u4opt_rec(i+1,:) = u4_opt;

        if max(abs(u1opt_rec(i+1,:)-u1opt_rec(i,:))) <= 1e-6 && ...
                max(abs(u2opt_rec(i+1,:)-u2opt_rec(i,:)))<= 1e-6 && ...
                max(abs(u3opt_rec(i+1,:)-u3opt_rec(i,:)))<= 1e-6 && ...
                max(abs(u4opt_rec(i+1,:)-u4opt_rec(i,:)))<= 1e-6
            break
        end
        % !! Undone !! Try: max(abs(u(i+1,:)-u(i,:))) <= 1e-6
    end
    u1optrec_pass(j+1,:)= u1opt_rec(end,:);
    u2optrec_pass(j+1,:)= u2opt_rec(end,:);
    u3optrec_pass(j+1,:)= u3opt_rec(end,:);
    u4optrec_pass(j+1,:)= u4opt_rec(end,:);
    %     if abs(u1optrec_pass(j+1,1)- u1optrec_pass(j,1))<= 1e-5&& ...
    %             abs(u1optrec_pass(j+1,2)- u1optrec_pass(j,2))<= 1e-5&& ...
    %             abs(u1optrec_pass(j+1,3)- u1optrec_pass(j,3))<= 1e-5&& ...
    %             abs(u1optrec_pass(j+1,4)- u1optrec_pass(j,4))<= 1e-5&& ...
    %             abs(u1optrec_pass(j+1,5)- u1optrec_pass(j,5))<= 1e-5
    %
    %         n_pass_getopt = j;
    %         break
    %     end
    % max(abs(u(i+1,:)-u(i,:))) <= 1e-7
    toc
    fprintf('Pass %2.0f done\n',j);

end


% P = 66;
% u1_opt = dvarO(    1 :  P);
% u2_opt = dvarO(  P+1 :2*P);
% u3_opt = dvarO(2*P+1 :3*P);
% u4_opt = dvarO(3*P+1 :4*P);
% Introduce the optimal results from paper 1 and verify that
% by following calculation, x8_optimal is 21.8217.
tspan = linspace(0,0.2,P+1);
x0 = [0.1883 0.2507 0.0467 0.0899 0.1804 0.1394 0.1046 0]';
z0 = x0;
for ks = 1 : P
    [~,res_y] = ode45(@(t,y)dyneqn1(t,y,u1_opt(ks),u2_opt(ks),...
        u3_opt(ks),u4_opt(ks)),...
        [tspan(ks),tspan(ks+1)],z0,[]);
    z0 = res_y(end,:)'; % 4x1
end
fprintf('Optimal x8 = %6.4f \n', z0(8))
