function [y] = newjuanjipso(x,s)
n = 20;         % ������
N = 40;         % ����ά��
L=30;           % ���ۻ�������
qmax = 1;qmin = -1;%����λ�÷�Χ
for i = 1:n
    for j=1:N
    q_xsf(i,j)=(qmax-qmin)*rand+qmin;%����λ�ó�ʼ��
    end
end
for i=1:n
   for j=1:N
        v(i,j)=0.001 * (rand-0.5) ;  % �����ٶ������ʼ��
   end
   
end
pbest_xsf = rand(n,N);                        % ��ʼ�����Ӹ�������λ��
gbest_xsf = rand(1,N);
kur_gbest_xsf = 0;                            % ��ʼ��ȫ�֣�Ⱥ�壩���ŷ��ֵ
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ��ʼ����ȷ��ÿһ�����ӵĳ�ʼλ�úͷ��
% �ҵ���ʼ״̬�µ�ȫ���������Ӻ������ֵ      
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i = 1:n
    ww=reshape(q_xsf(i,:),4,10);       % ������λ��ȷ���������
    pbest_xsf(i,:) = q_xsf(i,1:40);     % ������ӵ�λ��
   y(1,:) = filter(ww(1,:),1,x(1,:))+filter(ww(2,:),1,x(2,:));
   y(2,:) = filter(ww(3,:),1,x(1,:))+filter(ww(4,:),1,x(2,:));
   y = white(y);                    % �׻������ܹؼ�
   y1=y(1,:);
   y2=y(2,:);
  %  kur_y1 = leijiliang_5(x1,x2,ww,L); 
   kur_y1=leijiliang(y1,y2,L);
    %kur_y1 = leijiliang_yi(x1,x2,ww,y1,y2,L);% ���Ľ׻��ۻ���
    p(i) = kur_y1;                     % ��ŵ�i�����ӵķ��ֵ
    kur_pbest_xsf(i) = kur_y1;         % �ѷ��ֵ���������ŷ��ֵ
    if kur_pbest_xsf(i) > kur_gbest_xsf
        gbest_xsf = pbest_xsf(i,:);    %�ҵ�Ⱥ����λ��
        kur_gbest_xsf = kur_pbest_xsf(i);%Ⱥ���ŷ��ֵ
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PSO�Ż�
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
gene_max = 0.8;            % ���Ȩ��
gene_min = 0.3;            % ��СȨ��
vmax = 0.7;                % ����ƶ��ٶ�0.05
num_sum =60;               % ��������
step_max = 0.5;            % ����Ȩ���� �����������ٶȼ�Ȩ��
step_min = 0.5;            % ��С��Ȩ����
for i = 1:num_sum          % ��������
    gene = gene_max - (gene_max - gene_min) * i / num_sum;  % ����Ȩ�أ�Ȩ�صݼ�
    step = step_max - (step_max - step_min) * i / num_sum;  %����û��    
    for j = 1:n                      % ������
      ww=reshape(q_xsf(j,:),4,10); % �����j��������Ŀǰλ��������Ľ�����w
      y(1,:) = filter(ww(1,:),1,x(1,:))+filter(ww(2,:),1,x(2,:));
      y(2,:) = filter(ww(3,:),1,x(1,:))+filter(ww(4,:),1,x(2,:));
      y = white(y);                    % �׻������ܹؼ�
      y1=y(1,:);
      y2=y(2,:);
     kur_y1 = leijiliang(y1,y2,L);             % ���Ľ׻��ۻ���
       % kur_y1 = leijiliang_5(x1,x2,ww,L); 
      %   kur_y1=abs(cum31(y1,y2)+cum22(y1,y2));
     % kur_y1 = leijiliang_yi(x1,x2,ww,y1,y2,L);
        p(j) = kur_y1;                      % �������ӵ�ǰ���ֵ
        if kur_y1 > kur_pbest_xsf(j)              % ������������λ��
            kur_pbest_xsf(j) = kur_y1;
            pbest_xsf(j,:) = q_xsf(j,1:N);        % ��������λ��
        end
        if kur_y1 > kur_gbest_xsf                 % ����ȫ�֣�Ⱥ�壩����λ��
            kur_gbest_xsf = kur_y1;               % ȫ�����ŷ��ֵ
            gbest_xsf = q_xsf(j,1:N);             % ȫ������λ��
        end
        k_best_xsf(i) = kur_gbest_xsf;            % ��¼ÿ�ε�����ȫ�����ŷ��ֵ
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % �����ٶȵĸ���
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        for k = 1:N        % ���Ӹ�ά
            pre = q_xsf(j,k);                     % ��j������λ�������е�kά�ĵ�ǰֵ
            sub1 = pbest_xsf(j,k) - pre;          % �����ӣ��ֲ�����λ�������е�kάֵ-��ǰλ�õĵ�kά�ĵ�ǰֵ��
            sub2 = gbest_xsf(k) - pre;            % ȫ������λ�������е�kάֵ-�����ӵ�ǰλ�õĵ�kά�ĵ�ǰֵ
            prev = v(j,k);                        % ��j�����ӣ���kά�ĵ�ǰ�ٶ�
            tempv = step * (gene * prev + 2 * rand(1) * sub1 + 2 * rand(1) * sub2);   % �������ӵ��ٶ�
            g_bc(i,j,k) = tempv;                  % ��i�ε����У���j�����ӵĵ�kά���ٶȣ�ûɶ�ã�
            % ����ÿһά���˶��ٶ�V����������[-Vmax,Vmax]֮��
            if tempv > vmax
                v(j,k ) = vmax;
            elseif tempv < -1 * vmax
                v(j,k ) = -vmax;
            else
                v(j,k ) = tempv;
            end
        end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % ����λ�õĸ���
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
      for k = 1:N
         q_xsf(j,k)= q_xsf(j,k) + v(j,k );
           if q_xsf(j,k) > qmax
               q_xsf(j,k) = qmax;
           end
           if q_xsf(j,k) < qmin
               q_xsf(j,k) = qmin;
           end
      end
    end
    q_pace(i,:,:) = q_xsf;              %ÿһ�ε������һ�����ӵ�λ��
    qq_gbest_xsf(i,:) = gbest_xsf;      %Ⱥ����λ��
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
     % �źŷ���   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
w=reshape(gbest_xsf,4,10);             % �����ҵ�����������λ�ã�������������
 y(1,:) = filter(w(1,:),1,x(1,:))+filter(w(2,:),1,x(2,:));
 y(2,:) = filter(w(3,:),1,x(1,:))+filter(w(4,:),1,x(2,:));
  y = white(y);     % �õ����շ����ź�
                     

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % �����������ͼ    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
hdl=figure('Name','(3)�������ź�','NumberTitle','off','MenuBar','none','Position',[1000 300 400 400]);
for i = 1:2
   subplot(2,1,i)
   plot(y(i,:));
   xlabel('������');
   ylabel('����');
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% �������ܷ���
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(4)
gplotmatrix(s',y')   %����w*A  
bb=[s(1,:)' y(1,:)'];
dd=[s(2,:)' y(2,:)'];
bb1=[s(1,:)' y(2,:)'];
dd1=[s(2,:)' y(1,:)'];

fprintf('��Դ��ָ��ź������');
format long
cc=corrcoef(bb)  % Դ�ź���ָ����źŵ����ϵ��
ee=corrcoef(dd)
cc2=corrcoef(bb1)  % Դ�ź���ָ����źŵ����ϵ��
ee2=corrcoef(dd1)
%ff=corrcoef(qq)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure(5)
hold on
plot(k_best_xsf,'g');
xlabel('��������');
ylabel('�ʶ�ֵ');

hold off