function [ newaveragey ,newaverage2y ] = jieduanaverage1( k,y,oldaveragey,oldaverage2y )
%����y��ƽ��ֵ�ĸ��¹�ʽ
%lamuda���������ӣ�
%k�ǵ�ǰʱ�̵㣻
%y������źţ�
%averagey��y��ƽ��ֵ��
lamuda=0.999;
newaveragey=lamuda*(k-1)/k*oldaveragey+1/k*y(:,k);
newaverage2y=lamuda*(k-1)/k*oldaverage2y+1/k*(y(:,k).^3);

end

