function [ newaveragey ,newaverage2y ] = jieduanaverage1_IVA( iter,Y,oldaveragey,oldaverage2y )
%����y��ƽ��ֵ�ĸ��¹�ʽ
%lamuda���������ӣ�
%k�ǵ�ǰʱ�̵㣻
%y������źţ�
%averagey��y��ƽ��ֵ��
lamuda=0.999;
newaveragey=lamuda*(iter-1)/iter*oldaveragey+1/iter*Y(:,iter,:);
newaverage2y=lamuda*(iter-1)/iter*oldaverage2y+1/iter*(Y(:,iter,:).^3);

end

