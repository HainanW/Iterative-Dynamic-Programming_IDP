function dx = dyneqn1(t,x,in1,in2,in3,in4)

%DYNEQN1 
%:dynmaic state space eqn within ONE time step 

q = in1+in2+in4;
dx = zeros(8,1);
dx(1) = in4 - q*x(1) - 17.6*x(1)*x(2) - 23*x(1)*x(6)*in3;
dx(2) = in1 - q*x(2) - 17.6*x(1)*x(2) -146*x(2)*x(3);
dx(3) = in2 - q*x(3) -   73*x(2)*x(3);
dx(4) = -q*x(4) + 35.2*x(1)*x(2)- 51.3*x(4)*x(5);
dx(5) = -q*x(5) +  219*x(2)*x(3)- 51.3*x(4)*x(5);
dx(6) = -q*x(6) +102.6*x(4)*x(5)-   23*x(1)*x(6)*in3;
dx(7) = -q*x(7) +   46*x(1)*x(6)*in3;
dx(8) = 5.8*(q*x(1)-in4)-3.7*in1-4.1*in2+...
        q*(23*x(4)+11*x(5)+28*x(6)+35*x(7))-5*in3^2-0.099;

end