function [ Kurt ] = kurt_complex( y )
%���㸴���źŵ��Ͷ�
y=white(y);
Kurt=mean(abs(y).^4)-2;

end

