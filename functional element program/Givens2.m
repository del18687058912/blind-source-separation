function  U  = Givens2( theta,theta1,theta2,theta3)
%��������ת���󣬸���theta������ת����
theta4=theta2+theta3-theta1;
U=[cos(theta)*exp(1i*theta1),  sin(theta)*exp(1i*theta2);
   -sin(theta)*exp(1i*theta3), cos(theta)*exp(1i*theta4)];
end

