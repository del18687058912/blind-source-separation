function [ D ] = Dhanshu( i,y )
%��������
[a,b]=size(y);
D=0;
for j=1:a
A=corrcoef(y(i,:),y(j,:));
D=D+abs(A(1,2)^2);  
end
D=D-1;
end

