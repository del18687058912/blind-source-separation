function [ guanxi ] = xiangguanxing( y )
%���������
normy=y/norm(y);
guanxi=0;
for i=1:4
    fzhi = Dhanshu( i,normy )+HDhanshu( i,normy );
    guanxi=guanxi+fzhi;
end

