function [sumkurt] = sumkurt( y )
%��yi���ζȵľ���ֵ֮��
[n,k]=size(y);
sum=0;
for i=1:n
    sum=sum+abs(kurt(white(y(i,:))));
end
sumkurt=sum;
end

