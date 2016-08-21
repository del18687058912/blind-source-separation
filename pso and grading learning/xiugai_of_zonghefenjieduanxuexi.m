 %���ϴ�������Ϊ6ά
clear all
close all
clc
tic

for runtimes=1:2
Fs=10000;
T=1/Fs;
N=3000;

%¼��Դ�źŲ����ɻ���ź�
s = zeros(4,N);
for i=1:N
    s(1,i)=sin(2*pi*800*i*T)*sin(2*pi*25*i*T);    
    s(2,i)=sin(2*pi*300*i*T+6*cos(2*pi*60*i*T));
    s(3,i)=2*rand(1,1)-1;
    s(4,i)=sign(cos(2*pi*155*i*T)); 
end 
[B,N]=size(s);                                    %�õ�Դ�źŵĳߴ�
figure                                            %Դ�ź�ͼ
for i=1:B  
subplot(B,1,i);plot(s(i,:));
end
A=2*rand(B)-1          ;                              %��Ͼ���,[-a,a]�ľ��ȷֲ�
x=A*s;                                            %�۲��ź�
figure                                            %�۲��ź�ͼ
for i=1:B
    subplot(B,1,i);plot(x(i,:));
end


%��ʼ�������������Ⱥ��ز���������Բ���
W=0.5*eye(B);


particle_number = 10;        % ������
Dimension=1;                 % ����ά��
q(:,1) = 0.01+0.03*rand(particle_number,1);        % ��[0.1,0.4]�������������ת�Ƕ���Ϊ���ӵĳ�ʼλ��
q(:,2) = 0*rand(particle_number,1); % ��ʼ�����ӵ��ƶ��ٶ� 
q(:,3) = 0*rand(particle_number,1);                  % qΪ20*7
q_xsf = q;
gbest_xsf=0.04*rand;
pbest_xsf = 0.04*rand(particle_number,1);                        % ��ʼ����������λ�� 
vmax = 0.04;                % ����ƶ��ٶ�0.05
num_sum =1;              % ��������
gene=0.24;  % ����Ȩ�أ�Ȩ�صݼ�  

oldaveragey=zeros(B,1);
oldaverage2y=zeros(B,1);
Cij=zeros(B,B);HCij=zeros(B,B);Cii=zeros(1,B);HCii=zeros(1,B);


jishu=0;   %���ڼ�¼������Ⱥȷ�������Ĵ���
y(:,1)=x(:,1);
%��ʼ���������ź�
for iter=2:N
    %��������źŵ������
    y(:,iter)=W *x(:,iter);
    [ newaveragey ,newaverage2y ] = jieduanaverage1( iter,y,oldaveragey,oldaverage2y );
    [ Cij , HCij ] = jieduancovyiyj( Cij , HCij ,  iter , y , newaveragey ,oldaveragey ,newaverage2y ,oldaverage2y);
    [ Cii , HCii ] = jieduancovyi( Cii , HCii,  iter , y , newaveragey ,oldaveragey ,newaverage2y ,oldaverage2y );
    oldaveragey=newaveragey;oldaverage2y=newaverage2y;
    lamuda =0.999;
    for i=1:4
         for j=1:4
             SC(i,j)=Cij(i,j)/(Cii(i)*Cii(j)).^.5;
             HC(i,j)=HCij(i,j)/(HCii(i)*Cii(j)).^.5;
         end
    end
    for i=1:4
         for j=1:4
              Dij(i,j)=max([abs(SC(i,j)),abs(HC(i,j)),abs(HC(j,i))]);
         end    
    end
    Dij=Dij-eye(4);
    for i=1:4
         Di(i)=max(Dij(i,:));
    end
    D=max(Di);


    %��������Էֱ�ѡ������Ⱥ������ȷ������
    if D>0.25
         %��¼����Ⱥ�õ�������
         jishu=jishu+1;
   
          kur_gbest_xsf = 0;                            % ��ʼ��ȫ�֣�Ⱥ�壩���ŷ��ֵ
          kur_pbest_xsf = zeros(particle_number,1);
          q(:,1) =  0.04*rand(particle_number,1);        % ��[0��0.2]�������������ת�Ƕ���Ϊ���ӵĳ�ʼλ��
          q_xsf = q;
                  
          for j = 1:particle_number            % ������ n=20
               for kk = 1:Dimension        % ���Ӹ�ά N=3
                    pre = q_xsf(j,kk);                     % ��j������λ�������е�kά�ĵ�ǰֵ
                    sub1 = pbest_xsf(j,kk) - pre;          % �����ӣ��ֲ�����λ�������е�kάֵ-��ǰλ�õĵ�kά�ĵ�ǰֵ��
                    sub2 = gbest_xsf(kk) - pre;            % ȫ������λ�������е�kάֵ-�����ӵ�ǰλ�õĵ�kά�ĵ�ǰֵ
                    prev = q_xsf(j,kk+Dimension);                  % ��j�����ӣ���kά�ĵ�ǰ�ٶ�
                    tempv =sign(rand-0.5)* (gene * prev + 0.5 * rand(1) * sub1 + 0.5 * rand(1) * sub2);   % �������ӵ��ٶ�
                                      % ����ÿһά���˶��ٶ�V����������[-Vmax,Vmax]֮��
                    if tempv > vmax
                          q_xsf(j,kk + Dimension) = vmax;
                    elseif tempv < -1 * vmax
                          q_xsf(j,kk + Dimension) = -vmax;
                    else
                          q_xsf(j,kk + Dimension) = tempv;
                    end
                end
                       %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                        % ����λ�õĸ���
                       %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                 for kk = 1:Dimension
                       xx = q_xsf(j,kk) + q_xsf(j,kk + Dimension);        % Xi(n+1)=Xi(n)+Vi(n)
                       if xx >0.04
                            xx = 0.04;
                       end
                       if xx < 0.01 
                            xx = 0.01;
                       end
                            q_xsf(j,kk) = xx;
                  end                   
                       buchang=diag(q_xsf(j,1:Dimension)); 
                       kur_y1 = zonghanshu( buchang,x,iter,W ,Cij,HCij,Cii,HCii,oldaveragey,oldaverage2y,Di) ;                 % �����������źŵķ�ȣ����ݹ�ʽ6��
                       kur_pbest_xsf(j) =zonghanshu(diag(pbest_xsf(j,:)) ,x,iter,W ,Cij,HCij,Cii,HCii,oldaveragey,oldaverage2y,Di) ;   
                       kur_gbest_xsf=zonghanshu(diag(gbest_xsf) ,x,iter,W ,Cij,HCij,Cii,HCii,oldaveragey,oldaverage2y,Di) ;   
                       q_xsf(j,Dimension*2+1) = kur_y1;                      % �������ӵ�ǰ���ֵ
                  if kur_y1 <  kur_pbest_xsf(j)              % ������������λ��
                        kur_pbest_xsf(j) = kur_y1;
                        pbest_xsf(j,:) = q_xsf(j,1:Dimension);
                  end
                  if kur_y1 <  kur_gbest_xsf                 % ����ȫ�֣�Ⱥ�壩����λ��
                        kur_gbest_xsf = kur_y1;               % ȫ�����ŷ��ֵ
                        gbest_xsf = q_xsf(j,1:Dimension);             % ȫ������λ��
                  end
                       %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
          end
     
          buchang=diag(gbest_xsf);
          buchangjilu(jishu,:)=gbest_xsf;

    else
         buchang=zeros(4,4);
         for ii=1:4
              if Di(i)>0.2
                   buchang(ii,ii)=0.016;
              elseif Di(i)>0.05
                   buchang(ii,ii)=0.00275+0.05*(Di(ii)-0.05)^0.7;
              else
                   buchang(ii,ii)=0.135*Di(ii)^1.3;
              end
          end
    end
 
     W = W + buchang*( eye(B) - ((W *x(:,iter)).^2).*sign(W *x(:,iter))*3*tanh(10*W *x(:,iter))' )*W;
     
     E(iter)=crosstalking ( W,A );
     
end
y=real(y);

figure                                           %����Դ�ź�ͼ
for nn=1:B
    subplot(B,1,nn);plot(y(nn,:));
end

%��ȡ��3001-4000�ĵ����ں�����������
    ss=s(:,2001:3000);
    yy=y(:,2001:3000);
for i=1:4
    for j=1:4
        a=corrcoef(ss(i,:),yy(j,:));   %����Դ�ź�������źŵ����ϵ��
        xingneng(i,j)=a(1,2);
    end
end
        abs(xingneng)
        
        
%���������źŵ�˳��������ֵ
[B,shunxu]=max(abs(xingneng));   %�ҳ������ź���Դ�źŵĶ�Ӧ��ϵ
for i=1:4
    yyy(shunxu(i),:)=yy(i,:);    %���·��䣬ʹ��Դ�ź�������ź�˳���϶�Ӧ
end
for i=1:4                        %�ж�Դ�ź�������źŵ�������ϵ������
    ans=corrcoef(yyy(i,:),ss(i,:));    
    if ans(1,2)<0
        yyy(i,:)=-yyy(i,:);
    end
end
    figure                       %�������µ�����ķ����źţ���ȡ��3001:4000�ĵ�
    for i=1:4
        subplot(4,1,i)
        plot(yyy(i,:));
    end

%%���������
for i=1:4                         %��Դ�ź�������źŽ��й�һ��
    ss(i,:)=ss(i,:)/norm(ss(i,:));
    yyy(i,:)=yyy(i,:)/norm(yyy(i,:));
end
[B,changdu]=size(ss);                    %�õ�Դ�źŵĳߴ�
sums=zeros(1,4);                   %����ֵ
sume=zeros(1,4);
for i=1:B                          %���������
    ss2(i,:)=ss(i,:).^2;
    error1(i,:)=(yyy(i,:)-ss(i,:)).^2;
    for j=1:changdu
        sums(i)=sums(i)+ss2(i,j);
    end
    for j=1:changdu
        sume(i)=sume(i)+error1(i,j);
    end
    snr(i)=10*log10(sums(i)/sume(i));
end
snr                                %��ʾ�����  
figure;
plot(E)
Etongji(runtimes,:)=E;
chouyangE=E(2901:3000);
meanE=mean(chouyangE)
meanEtongji(runtimes)=meanE;
stdE=std(chouyangE)
stdEtongji(runtimes)=stdE;
end
toc