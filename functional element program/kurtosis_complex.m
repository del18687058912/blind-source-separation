function  yy=kurtosis_complex(y)

kurt_y2_1 = abs(kurt_complex(y(1,:)));  % ��ÿ·�źŵķ�ȵ�ģ
kurt_y2_2 = abs(kurt_complex(y(2,:)));

yy = sum([kurt_y2_1 kurt_y2_2 ]);     % ���ĵĹ�ʽ������͵�
%yy = mean([kurt_y2_1 kurt_y2_2 kurt_y2_3]);   % �þ�ֵҲ����

% function  yy=kurtosis(y,w)
% y = white(y);
% y_2 = y;
% kurt_y2_1 = kurt(y_2(1,:))^2;
% kurt_y2_2 = kurt(y_2(2,:))^2;
% kurt_y2_3 = kurt(y_2(3,:))^2;
% yy = mean([kurt_y2_1 kurt_y2_2 kurt_y2_3]);


% function  yy=kurtosis(y,w)
% % y = white(y);
% for i = 1:3
%     kurtt(i) = kurt(y(i,:));
%     cum(i) = mean(y(i,:).^3);
% %     1.���ʹ���
% %     Hy(i) = 1.4174 + kurtt(i) * cum(i)^2 * (3/8) + kurtt(i)^3 * (1/16) - cum(i)^2 * (1/12) - kurtt(i)^2 * (1/48);
% %     2.���<<������Ϣ����׼���äԴ���뷽��>>
% %       Hy(i) =  10 - abs(cum(i)^2 * (1/12) + kurtt(i)^2 * (1/48) + cum(i)^4 * (7/48) - kurtt(i) * cum(i)^2 * (1/8));
% %     3.̷����<<�������źŵ���С����Ϣ��ä�����㷨>>
%       Hy(i) =  10 - cum(i)^2 * (1/12) - kurtt(i)^2 * (1/48) + kurtt(i)^3 * (1/48) + kurtt(i) * cum(i)^2 * (1/8);
% 
% %       Hy(i) =  10 - cum(i)^2 * (1/12) - kurtt(i)^2 * (1/48) + kurtt(i)^3 * (1/16) + kurtt(i) * cum(i)^2 * (5/8);
% end
% % 0.6162
% yy = Hy(1) + Hy(2) + Hy(3) - log10(abs(det(w)));
% % yy = Hy(1) + Hy(2) + Hy(3) - log(abs(det(w)));
% 
% 
% 



























