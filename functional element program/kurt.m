function  aa=kurt(a)
%�ͶȵĶ���ʽ��E(y^4)-3(E(y^2))^2
% aΪ������
a_2 = a.^2;
a_4 = a.^4;
ea_2 = mean(a_2);
ea_4 = mean(a_4);
aa = ea_4 - 3 * ea_2 ^2;
% aa = ea_4 - 3;


% a_2 = a.^2;
% a_4 = a.^4;
% ea_2 = mean(a_2);
% ea_4 = mean(a_4);
% aa = abs(ea_4 - 3 * ea_2 ^2);
















