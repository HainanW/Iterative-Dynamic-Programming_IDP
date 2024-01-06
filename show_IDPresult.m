function out = show_IDPresult(dvarO,N)

% in1 = u1
% in2 = u2
% in3 = u3
% in4 = u4
clf
figure(1)
ts = linspace(0,0.2,P+1);
t = zeros(2+2*(P-1),1);
u1 = zeros(2+2*(P-1),1);
u2 = zeros(2+2*(P-1),1);
u3 = zeros(2+2*(P-1),1);
u4 = zeros(2+2*(P-1),1);

t(1,1) = 0;
for i = 1: P 
     t((2*i-1),1) = ts(i);
     t((  2*i),1) = ts(i+1);
    u1((2*i-1),1) = in1(i);
    u1((  2*i),1) = in1(i);
    u2((2*i-1),1) = in2(i);
    u2((  2*i),1) = in2(i);
    u3((2*i-1),1) = in3(i);
    u3((  2*i),1) = in3(i);
    u4((2*i-1),1) = in4(i);
    u4((  2*i),1) = in4(i);    
end



out = plot(t,u1,t,u2,t,u3,t,u4);
xlabel('TIME')
ylabel('Controls')
legend({'u1(t)','u2(t)','u3(t)','u4(t)'},'Location','bestoutside')
end