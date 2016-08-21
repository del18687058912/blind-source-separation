function  [y]=white(x)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% CubICA (IMPROVED CUMULANT BASED ICA-ALGORITHM)
%
% This algorithm performes ICA by diagonalization of third- and
% fourth-order cumulants simultaneously.
%
%  [R,y]=cubica34(x)
%
% - x is and NxP matrix of observations 
%     (N: Number of components; P: Number of datapoints(samplepoints)) 
% - R is an NxN matrix such that u=R*x, and u has 
%   (approximately) independent components.
% - y is an NxP matrix of independent components
%  
% This algorithm does exactly (1+round(sqrt(N)) sweeps.
% 
% Ref: T. Blaschke and L. Wiskott, "An Improved Cumulant Based
% Method for Independent Component Analysis", Proc. ICANN-2002,
% Madrid, Spain, Aug. 27-30.
%
% questions, remarks, improvements, problems to: t.blaschke@biologie.hu-berlin.de.
%
% Copyright : Tobias Blaschke, t.blaschke@biologie.hu-berlin.de.
%
% 2002-02-22
%
%
% Last change:2003-05-19 
%  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 

  [N,P]=size(x); %3*5000
%   Q=eye(N);
%   resolution=0.001;
  
  % centering and whitening
  
%   fprintf('\ncentering and whitening!\n\n');
%   mean(x,2)Ϊ���о�ֵ���õ�������%
  x=x-mean(x,2)*ones(1,P);
  [V,D]=eig(x*x'/P);% ����Э������������ֵ����������
                    % V-----����������ÿ��Ϊ��������    3*3
                    % D-----����ֵ�������Խ���Ԫ��Ϊ����ֵ  3*3                  
  global gw_white
  gw_white=diag(real(diag(D).^(-0.5)))*V';   % �õ��׻�����. ???????? ��ʽ���ǰ�滹�˸�V��  gw_white=V*diag(real(diag(D).^(-0.5)))*V'��
  y=gw_white*x;     % �׻���ľ��� 
  
%   y = y./y(1,1);