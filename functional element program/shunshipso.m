function [y] = shunshipso(x,s)
%  ��ʼ������Ⱥ
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
n = 20;        % ������
N=1;
%lieshu = N * N * 2 + 1;                       % 19 N=3���źŵĸ���
%p = rand(n,lieshu);                          % pΪ����w������������ʼ�ٶȵ���� ; 
                                              % Uniformly distributed(���ȷֲ���
% NλΪ���ӵĳ�ʼλ�ã��м�NλΪ��ʼ�ٶȣ�����Ϊ��ֵ(���ֵ)
q(:,1) =  2*pi*(rand(n,1) - 0.5);        % ��[-pi��pi]�������������ת�Ƕ���Ϊ���ӵĳ�ʼλ��
q(:,2) = 0.001 * (rand(n,1) - 0.5); % ��ʼ�����ӵ��ƶ��ٶ� 
q(:,3) = zeros(n,1);                  % qΪ20*7
q_xsf = q;

% ��ʼ��pbest_xsf��gbest_xsf������Ӧ��
pbest_xsf = rand(n,1);                        % ��ʼ����������λ��
kur_gbest_xsf = 0;                            % ��ʼ��ȫ�֣�Ⱥ�壩���ŷ��ֵ
gbest_xsf=zeros(1,1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ��ʼ����ȷ��ÿһ�����ӵĳ�ʼλ�úͷ��
% �ҵ���ʼ״̬�µ�ȫ���������Ӻ������ֵ      
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i = 1:n     %n=20������
    ww=cir2(q_xsf(i,1)); % ȷ���������q(i,1),q(i,2),q(i,3)Ϊ���ӣ��������
    pbest_xsf(i,:) = q_xsf(i,1);            % ������ӵ�λ��
    y1 = ww * x;   
    kur_y1 = kurtosis(y1);                    % kurtosis ���Ͷ�
    %kur_y1 = mi(y1,ww,x); 
    
    q_xsf(i,2) = kur_y1;                      % ��ŵ�i�����ӵķ��ֵ
    kur_pbest_xsf(i) = kur_y1;
    if kur_pbest_xsf(i) > kur_gbest_xsf
        gbest_xsf = pbest_xsf(i,:);
        kur_gbest_xsf = kur_pbest_xsf(i);
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ��Ϊ0.09ʱ���Ϊ465.6466��0.03ʱΪ542.4920
gene_max = 0.8;            % ���Ȩ��
gene_min = 0.3;            % ��СȨ��
vmax = 0.7;                % ����ƶ��ٶ�0.05
num_sum =50;              % ��������
step_max = 0.5;            % ����Ȩ���� �����������ٶȼ�Ȩ��
step_min = 0.5;            % ��С��Ȩ����
for i = 1:num_sum          % ��������
    gene = gene_max - (gene_max - gene_min) * i / num_sum;  % ����Ȩ�أ�Ȩ�صݼ�
    step = step_max - (step_max - step_min) * i / num_sum;       
    for j = 1:n            % ������ n=20
        ww=cir2(q_xsf(j,1)); % �����j��������Ŀǰλ��������Ľ�����w
        y1 = ww * x;                              % �õ��ɴ�w������ķ�����       
        kur_y1 = kurtosis(y1);                    % �����������źŵķ�ȣ����ݹ�ʽ6��
        %kur_y1 = mi(y1,ww,x);
        
        q_xsf(j,3) = kur_y1;                      % �������ӵ�ǰ���ֵ
        if kur_y1 > kur_pbest_xsf(j)              % ������������λ��
            kur_pbest_xsf(j) = kur_y1;
            pbest_xsf(j,:) = q_xsf(j,1);
        end
        if kur_y1 > kur_gbest_xsf                 % ����ȫ�֣�Ⱥ�壩����λ��
            kur_gbest_xsf = kur_y1;               % ȫ�����ŷ��ֵ
            gbest_xsf = q_xsf(j,1);             % ȫ������λ��
        end
        k_best_xsf(i) = kur_gbest_xsf;            % ��¼ÿ�ε�����ȫ�����ŷ��ֵ
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % �����ٶȵĸ���
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        for k = 1        % ���Ӹ�ά N=3
            % x_bc(i,k) = std(q_xsf(:,k))^3;      % std:��׼ƫ��  ������������
            pre = q_xsf(j,k);                     % ��j������λ�������е�kά�ĵ�ǰֵ
            sub1 = pbest_xsf(j,k) - pre;          % �����ӣ��ֲ�����λ�������е�kάֵ-��ǰλ�õĵ�kά�ĵ�ǰֵ��
            sub2 = gbest_xsf(k) - pre;            % ȫ������λ�������е�kάֵ-�����ӵ�ǰλ�õĵ�kά�ĵ�ǰֵ
            prev = q_xsf(j,k+1);                  % ��j�����ӣ���kά�ĵ�ǰ�ٶ�
            tempv = step * (gene * prev + 2 * rand(1) * sub1 + 2 * rand(1) * sub2);   % �������ӵ��ٶ�
            g_bc(i,j,k) = tempv;                  % ��i�ε����У���j�����ӵĵ�kά���ٶ�
            % ����ÿһά���˶��ٶ�V����������[-Vmax,Vmax]֮��
            if tempv > vmax
                q_xsf(j,k + 1) = vmax;
            elseif tempv < -1 * vmax
                q_xsf(j,k + 1) = -vmax;
            else
                q_xsf(j,k + 1) = tempv;
            end
        end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % ����λ�õĸ���
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        for k = 1:1
             xx = q_xsf(j,k) + q_xsf(j,k + 1);        % Xi(n+1)=Xi(n)+Vi(n)
             if xx > 2*pi
                 xx = xx - 2 * pi;
             end
             if xx < -2 * pi
                 xx = xx + 2 * pi;
             end
            q_xsf(j,k) = xx;
        end 
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    end
    q_pace(i,:,:) = q_xsf;
    qq_gbest_xsf(i,:) = gbest_xsf;
    kur_gbest_xsf;
end

% �źŷ���
w=cir2(gbest_xsf)   % �ҵ�����������λ�ã�������������
y = w * x;                                        % �õ����շ����ź� 

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
%qq=[s(3,:)' y(3,:)'];
fprintf('��Դ��ָ��ź������');
format long
cc=corrcoef(bb)  % Դ�ź���ָ����źŵ����ϵ��
ee=corrcoef(dd)
cc2=corrcoef(bb1)  % Դ�ź���ָ����źŵ����ϵ��
ee2=corrcoef(dd1)
%ff=corrcoef(qq)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
global shunxu;
if abs(cc(1,2))>abs(cc2(1,2));
    shunxu=1
else shunxu=0
end

figure(5)
hold on
plot(k_best_xsf,'g');
xlabel('��������');
ylabel('�ʶ�ֵ');

hold off