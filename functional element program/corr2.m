function [ corr_s1 , corr_s2 ] = corr2( s,y )
%������·�źŵ����ϵ��

bb=[s(1,:)' y(1,:)'];
cc=[s(1,:)' y(2,:)'];
dd=[s(2,:)' y(1,:)'];
ee=[s(2,:)' y(2,:)'];
fprintf('Correlations between sources and recovered signals ...\n');
ff=corrcoef(bb); % Դ�ź���ָ����źŵ����ϵ��
gg=corrcoef(cc);
hh=corrcoef(dd);
ii=corrcoef(ee);
if ff(1,2)>gg(1,2)
    corr_s1=ff(1,2)
else corr_s1=gg(1,2)
end
if hh(1,2)>ii(1,2)
    corr_s2=hh(1,2)
else corr_s2=ii(1,2)
end


end

